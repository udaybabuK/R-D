//
//  JsonHelper.swift
//  Forms
//
//  Created by Orient Technologies Mac on 7/31/17.
//  Copyright © 2017 Orient. All rights reserved.
//

import UIKit

class JsonHelper: NSObject {

    static let sharedInstance = JsonHelper()

    
    func loginCallsJson(callName:String,userId:String,password:String) -> Dictionary<String,String>{
        var loginDict = Dictionary<String,String>()
        
        loginDict["callName"] = callName
        loginDict["phoneNumber"] = ""
        loginDict["ptn"] = userId
        loginDict["cId"] = "1"
        loginDict["cVer"] = Constants.Version
        loginDict["lat"] = "12.12"
        loginDict["lon"] = "17.11"
        loginDict["imei"] = CastUUID.sharedInstance.getUUID()
        loginDict["callType"] = "get"
        loginDict["pId"] = "1.0"
        loginDict["passwd"] = password
        loginDict["appVersion"] = Constants.Version
        loginDict["phoneModel"] = UIDevice.modelName
        loginDict["ts"] = String(Date().currentTS())
       // loginDict["utc"] = Date().getUTCFormateDate()
        loginDict["utc"] = ""
        
        return loginDict
    }
    
    
    func getCallsToDoJson(callName:String) -> Dictionary<String,String> {
        let myarr = ModelManager.getInstance().getLogincredits()
        let login = myarr[0] as! Login
        print(login.cId)
        
        let loginresponsearray = ModelManager.getInstance().getLoginresponse()
        let Response = loginresponsearray[0] as! LoginResponse
        
        var loginDict = Dictionary<String,String>()
        var Sfa = String()
           Sfa = Helper.sharedInstance.getUserDefaults(key: "SFA")
         loginDict["SFA"] = Sfa
         loginDict["appVersion"] = Constants.Version
         loginDict["cId"] = Helper.sharedInstance.getUserDefaults(key: "cId")
       //  loginDict["cId"] =  login.cId
         loginDict["cVer"] = Constants.Version
         loginDict["callName"] = callName
         loginDict["callType"] = "get"
         loginDict["dateFrom"] = ""
         loginDict["dateTo"] = ""
         loginDict["empNo"] = Helper.sharedInstance.getUserDefaults(key: "empNo")
       //  loginDict["empNo"] = Response.empNo
         loginDict["imei"] = CastUUID.sharedInstance.getUUID()
         loginDict["lat"] = ""
         loginDict["lon"] = ""
         loginDict["month"] = ""
         loginDict["pId"] = "1.0"
        
        loginDict["passwd"] = Helper.sharedInstance.getUserDefaults(key: "password")
       // loginDict["passwd"] = login.passwd
        loginDict["phoneModel"] = UIDevice.modelName
        loginDict["phoneNumber"] = ""
        loginDict["ptn"] = Helper.sharedInstance.getUserDefaults(key: "loginId")
       // loginDict["ptn"] = login.ptn
        loginDict["role"] = ""
        loginDict["searchDF"] = ""
        loginDict["searchDT"] = ""
        loginDict["searchUserId"] = "0"
        loginDict["sessionId"] = Helper.sharedInstance.getUserDefaults(key: "sessionId")
       // loginDict["sessionId"] = Response.sessionId
        loginDict["status"] = ""
        loginDict["ts"] = String(Date().currentTS())
        loginDict["uId"] = Helper.sharedInstance.getUserDefaults(key: "uId")
       // loginDict["uId"] = Response.uId
        loginDict["utc"] = ""
        loginDict["year"] = "2018"
        
        
        return loginDict
        
    }
    func getDictionarytoStringlogin(Dict: Dictionary<String,String>) -> String {
       
        
        var error : NSError?
        
        let jsonData = try! JSONSerialization.data(withJSONObject: Dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
    
     return "jsonString="+jsonString
        
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            }
            catch
            {
                print("error")
            }
        }
        return nil
    }
    
}
