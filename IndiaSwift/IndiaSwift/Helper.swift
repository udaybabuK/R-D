//
//  Helper.swift
//  Forms
//
//  Created by Orient Technologies Mac on 7/29/17.
//  Copyright © 2017 Orient. All rights reserved.
//

import UIKit
import NoOptionalInterpolation

class Helper: NSObject {
    
    static let sharedInstance = Helper()
    
    
    func getData(_ strUrl:String,_ permString:String, completion completionBlock:@escaping(_ data:Data)-> Void)
    {
        print("url is:\(strUrl) parameters is:\(permString)")
        let request = NSMutableURLRequest(url:NSURL(string:strUrl) as! URL)
        request.httpMethod = "POST"
        let postString = permString
         request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){ (data,response,error) in
            guard error  == nil && data != nil else
            {
                print(error! as Error)
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                //   print("statusCode should be 200, but is \(httpStatus.statusCode)")
                //  print("response = \(response)")
                
                let alert = UIAlertView(title: "No Internet Connection", message: "Network not available.\nPlease check settings", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            _ = String(data: data!, encoding: String.Encoding.utf8)
            
            completionBlock(data!)
        }
        task.resume()
        
    }
    
    func setValueforKey(Value:String,Key:String) -> Void {
        //To save the string
        let userDefaults = UserDefaults.standard
        userDefaults.set( Value, forKey: Key)
    }
    func getValuforKey(Key:String) -> String {
        //To retrieve from the key
        let userDefaults = UserDefaults.standard
        let value  = userDefaults.string(forKey: Key)
        return value!
    }
    
    /*
    func myData(_ strUrl:String,_ permString:String) -> String {
        
        var request = URLRequest(url: URL(string:strUrl)!)
        request.httpMethod = "POST"
        let postString = permString
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
        }
        task.resume()
       return "ddd"
    }
   */
    
public func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
   
public func setUserDefaults(value : String,key : String) -> Void{
      let defaults:UserDefaults = UserDefaults.standard
       defaults.set(value, forKey: key)
        //var returnValue: [NSString]? = UserDefaults.standard.object(forKey: "yourkey") as? [NSString]
    }
    
public func getUserDefaults(key : String) -> String{
        let returnValue:NSString? = UserDefaults.standard.object(forKey: key) as! NSString?
       return returnValue as! String
    }
public func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    //Convert Any to String
    public func convertAnyToString(value:Any) -> String {
        let pvalue:Any? = value
        let myString:String? = "\(pvalue)"
        
        return myString!
    }
    public func inserServiceDetai(Data:Dictionary<String, Any>) -> Void{
        print("Response:\(Data)")
        
        if Helper.sharedInstance.convertAnyToString(value:Data[Constants.Message] as Any) == Constants.SettingsSuccessMsg {
            let isDeleted:Bool = ModelManager.getInstance().deleteTabeldata(tableName:Constants.tblName_Settings)
            if isDeleted {
                print("tblName_Settings deleted successfully!")
            }
            var respDict:Dictionary<String,Any> = Data["settings"] as! Dictionary<String, Any>
            /*
            //insert Settings.
            let settings:Settings=Settings()
            settings.AUTO_TRACKING_ENABLED = Helper.sharedInstance.convertAnyToString(value: respDict["AUTO_TRACKING_ENABLED"] as Any)
            settings.LOG_OUT = Helper.sharedInstance.convertAnyToString(value: respDict["LOG_OUT"] as Any)
            settings.ENABLE_PICTURE = Helper.sharedInstance.convertAnyToString(value: respDict["ENABLE_PICTURE"] as Any)
            settings.CONNECT_BLUETOOTH = Helper.sharedInstance.convertAnyToString(value: respDict["CONNECT_BLUETOOTH"] as Any)
            settings.ALLOW_MULTIPLE_VISIT = Helper.sharedInstance.convertAnyToString(value: respDict["ALLOW_MULTIPLE_VISIT"] as Any)
            settings.ENABLE_MESSAGING = Helper.sharedInstance.convertAnyToString(value: respDict["ENABLE_MESSAGING"] as Any)
            settings.ASSIGNMENT_CHECK_INTERVAL = Helper.sharedInstance.convertAnyToString(value: respDict["ASSIGNMENT_CHECK_INTERVAL"] as Any)
            settings.CLEAR_DATA_ON_LOGOUT = Helper.sharedInstance.convertAnyToString(value: respDict["CLEAR_DATA_ON_LOGOUT"] as Any)
            settings.CHECK_FOR_UPDATE = Helper.sharedInstance.convertAnyToString(value: respDict["CHECK_FOR_UPDATE"] as Any)
            settings.ENABLE_SUBCUSTOMER = Helper.sharedInstance.convertAnyToString(value: respDict["ENABLE_SUBCUSTOMER"] as Any)
            settings.ASSIGNMENT_ENABLED = Helper.sharedInstance.convertAnyToString(value: respDict["ASSIGNMENT_ENABLED"] as Any)
            settings.ENABLE_RETAILER = Helper.sharedInstance.convertAnyToString(value: respDict["ENABLE_RETAILER"] as Any)
            settings.TRACKING_FREQUENCY = Helper.sharedInstance.convertAnyToString(value: respDict["TRACKING_FREQUENCY"] as Any)
            settings.SEND_LOW_BATTERY_ALERT = Helper.sharedInstance.convertAnyToString(value: respDict["SEND_LOW_BATTERY_ALERT"] as Any)
            settings.ENABLE_AUDIO = Helper.sharedInstance.convertAnyToString(value: respDict["ENABLE_AUDIO"] as Any)
            settings.SENDING_FREQUENCY = Helper.sharedInstance.convertAnyToString(value: respDict["SENDING_FREQUENCY"] as Any)
            settings.TRACKING_LEVEL = Helper.sharedInstance.convertAnyToString(value: respDict["TRACKING_LEVEL"] as Any)
            settings.SAMPLING_FREQUENCY = Helper.sharedInstance.convertAnyToString(value: respDict["SAMPLING_FREQUENCY"] as Any)
            settings.DELETE_SUBCUSTOMER = Helper.sharedInstance.convertAnyToString(value: respDict["DELETE_SUBCUSTOMER"] as Any)
            settings.SMS_ENABLED = Helper.sharedInstance.convertAnyToString(value: respDict["SMS_ENABLED"] as Any)
            settings.ENABLE_ROUTE = Helper.sharedInstance.convertAnyToString(value: respDict["ENABLE_ROUTE"] as Any)
            settings.ALLOW_MULTIPLE_VISIT_CUSTOMER = Helper.sharedInstance.convertAnyToString(value: respDict["ALLOW_MULTIPLE_VISIT_CUSTOMER"] as Any)
            settings.TRACKING_END_TIME = Helper.sharedInstance.convertAnyToString(value: respDict["TRACKING_END_TIME"] as Any)
            settings.ENABLE_EDIT_FORM = Helper.sharedInstance.convertAnyToString(value: respDict["ENABLE_EDIT_FORM"] as Any)
            settings.INCLUDE_CELLSITE = Helper.sharedInstance.convertAnyToString(value: respDict["INCLUDE_CELLSITE"] as Any)
            settings.TRACKING_START_TIME = Helper.sharedInstance.convertAnyToString(value: respDict["TRACKING_START_TIME"] as Any)
            settings.ENABLE_VIDEO = Helper.sharedInstance.convertAnyToString(value: respDict["ENABLE_VIDEO"] as Any)
            ModelManager.getInstance().InsertSettings(settings)
            
            //stored in defaults
             Helper.sharedInstance.setUserDefaults(value:Helper.sharedInstance.convertAnyToString(value: respDict["TRACKING_FREQUENCY"] as Any), key: "timeinterval")
             Helper.sharedInstance.setUserDefaults(value:Helper.sharedInstance.convertAnyToString(value: respDict["SENDING_FREQUENCY"] as Any), key: "checkinterval")
             Helper.sharedInstance.setUserDefaults(value:Helper.sharedInstance.convertAnyToString(value: respDict["CHECK_FOR_UPDATE"] as Any), key: "checkupdate")
            
            print("settings is:\(Data["settings"])")
             */
            
        }else if  Helper.sharedInstance.convertAnyToString(value:Data[Constants.Message] as Any) == Constants.ICSalesSuccessMsg {
            print("IC is:\(Data["data"])")
        }
    }
    
}

public extension Date {
    func currentTS() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
public extension Date{
    func getUTCFormateDate() -> String {
        let utcTimestamp = Date().timeIntervalSince1970
        print("timeStamp = \(utcTimestamp)")
        return String(utcTimestamp)
    }
}
public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
                switch identifier {
                case "iPod5,1":                                 return "iPod Touch 5"
                case "iPod7,1":                                 return "iPod Touch 6"
                case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
                case "iPhone4,1":                               return "iPhone 4s"
                case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
                case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
                case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
                case "iPhone7,2":                               return "iPhone 6"
                case "iPhone7,1":                               return "iPhone 6 Plus"
                case "iPhone8,1":                               return "iPhone 6s"
                case "iPhone8,2":                               return "iPhone 6s Plus"
                case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
                case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
                case "iPhone8,4":                               return "iPhone SE"
                case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
                case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
                case "iPhone10,3", "iPhone10,6":                return "iPhone X"
                case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
                case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
                case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
                case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
                case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
                case "iPad6,11", "iPad6,12":                    return "iPad 5"
                case "iPad7,5", "iPad7,6":                      return "iPad 6"
                case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
                case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
                case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
                case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
                case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
                case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
                case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
                case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
                case "AppleTV5,3":                              return "Apple TV"
                case "AppleTV6,2":                              return "Apple TV 4K"
                case "AudioAccessory1,1":                       return "HomePod"
                case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
                default:                                        return identifier
                }
            #elseif os(tvOS)
                switch identifier {
                case "AppleTV5,3": return "Apple TV 4"
                case "AppleTV6,2": return "Apple TV 4K"
                case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
                default: return identifier
                }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

