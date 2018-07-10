//
//  ViewController.swift
//  IndiaSwift
//
//  Created by Orient Technologies Mac on 6/5/18.
//  Copyright © 2018 Orient. All rights reserved.
//

import UIKit
import MBProgressHUD
class ViewController: UIHelper,UITextFieldDelegate,UIAlertViewDelegate {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserId: UITextField!
    var CurrentTextfield = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        let strUUID:String = CastUUID.sharedInstance.getUUID()
        print("UUID IS :\(strUUID)")
        self.txtUserId.delegate = self
        self.txtPassword.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
    }
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }

    public func textFieldDidBeginEditing(_ textField: UITextField){
        CurrentTextfield = textField
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    @IBAction func btnLogin(_ sender: Any) {
        
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        
        spinnerActivity.label.text = "Loading";
        spinnerActivity.detailsLabel.text = "Please Wait!!";
        spinnerActivity.isUserInteractionEnabled = false;
        
        DispatchQueue.global(qos: .userInitiated).async {
             self.CurrentTextfield.resignFirstResponder()
            self.LoadData()
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
               spinnerActivity.hide(animated: true);
            }
        }

    }
    func LoadData() -> Void {
       
        if (self.txtUserId.text?.characters.count)!>0 && (self.txtPassword.text?.characters.count)!>0 {
            
            if(self.isInternetAvailable()){
                Helper.sharedInstance.getData(Constants.Url,JsonHelper.sharedInstance.getDictionarytoStringlogin(Dict:JsonHelper.sharedInstance.loginCallsJson(callName: "login",userId: txtUserId.text! as String,password: txtPassword.text! as String)), completion: {
                    resultData in
                    //spinner running code
                    /*
                    let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
                    
                    spinnerActivity.hide(animated: false)
                    spinnerActivity.label.text = "Loading";
                    spinnerActivity.detailsLabel.text = "Please Wait!!";
                    spinnerActivity.isUserInteractionEnabled = false;
                   */
                    //responceCode
                    var jsonData = JSON(data:resultData)
                    let str = String.init(data: resultData, encoding: .utf8)
                    let dict = JsonHelper.sharedInstance.convertStringToDictionary(text: str!)
                    print("Response:\(dict)")
                    if( Helper.sharedInstance.nullToNil(value: jsonData[Constants.ResponseCode] as AnyObject?) != nil ){
                       // self.txtUserId.text = nil
                       // self.txtPassword.text = nil
                        if String(describing: jsonData[Constants.ResponseCode]) == Constants.LoginSuccessRespCode {
                            let isDeleted:Bool = ModelManager.getInstance().deleteTabeldata(tableName:Constants.tblName_LoginResponce)
                            if isDeleted {
                                print("tblName_LoginResponce deleted successfully!")
                            }
                            self.insertLoginData(ResponseLoginDict:dict!)
                            self.callsToDo()
                            
                            
                        }else{
                            
                            self.globalAlertView(message:String(describing: jsonData[Constants.Message]) )
                        }
                    }else{
                        self.globalAlertView(message:"Server not available")
                    }
                    
                    
                    DispatchQueue.main.async(execute: {
                        //stopSpin
                     //  spinnerActivity.hide(animated: true);
                    })
                })
            }else{
                self.globalAlertView(message:"Network not available")
            }
            
        }
        else
        {
            self.globalAlertView(message:"Please enter valid Account Id, Login Id and Password")
            
        }
    }
    
    func insertLoginData(ResponseLoginDict:Dictionary<String,Any>) -> Void {
        
         let userIdStr:String = txtUserId.text! as String
         let passworStr:String = txtPassword.text! as String
        
        print(passworStr)
        //login Credentials.
        let login:Login=Login()
        login.cId = "1"
        login.ptn = userIdStr
        login.passwd = passworStr
        ModelManager.getInstance().InsertLogincredits(login)
        //login Response.
        let loginResponse:LoginResponse=LoginResponse()
        let yourStringVar = NSArray(array:ResponseLoginDict["callToDo"] as! Array).componentsJoined(by: ",")
          var stringArray = Array<String>()
             stringArray = [yourStringVar]
        let string = stringArray.joined(separator: " ")
    
          loginResponse.callToDo = string
          loginResponse.uName = ResponseLoginDict["uName"] as! String
          loginResponse.empNo = ResponseLoginDict["empNo"] as! String
          loginResponse.uId = (Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["uId"] as Any))
          loginResponse.cId = (Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["cId"] as Any ))
          loginResponse.SFA = (Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["SFA"] as Any ))
          loginResponse.sessionId = (Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["sessionId"] as Any ))
        ModelManager.getInstance().InsertLoginresponse(loginResponse)
        //stored in Defaults
        
        Helper.sharedInstance.setUserDefaults(value: "1", key: "accountId")
        Helper.sharedInstance.setUserDefaults(value:userIdStr, key: "loginId")
        Helper.sharedInstance.setUserDefaults(value:passworStr, key: "password")
        Helper.sharedInstance.setUserDefaults(value:ResponseLoginDict["uName"] as! String, key: "uName")
        Helper.sharedInstance.setUserDefaults(value:Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["sessionId"] as Any), key: "sessionId")
        Helper.sharedInstance.setUserDefaults(value:Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["uId"] as Any), key: "uId")
        Helper.sharedInstance.setUserDefaults(value:Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["cId"] as Any), key: "cId")
        Helper.sharedInstance.setUserDefaults(value:Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["empNo"] as Any), key: "empNo")
        Helper.sharedInstance.setUserDefaults(value:Helper.sharedInstance.convertAnyToString(value: ResponseLoginDict["SFA"] as Any ), key: "SFA")
        
        
    }
    func callsToDo() -> Void {
        let callsToDoList = ["settingsGet","icSalesAppList"]
        for calls in callsToDoList {
            let aStr = String(format:calls )
            Helper.sharedInstance.getData(Constants.Url,JsonHelper.sharedInstance.getDictionarytoStringlogin(Dict:JsonHelper.sharedInstance.getCallsToDoJson(callName: aStr)), completion: {
                resultData in
               // let jsonData = JSON(data:resultData)
                let str = String.init(data: resultData, encoding: .utf8)
                let dict:Dictionary = JsonHelper.sharedInstance.convertStringToDictionary(text: str!)!
                print("Response:\(dict)")
                Helper.sharedInstance.inserServiceDetai(Data:dict)
                DispatchQueue.main.async(execute: {
                  
                })
            })
            
            
        }
    }
    
}

