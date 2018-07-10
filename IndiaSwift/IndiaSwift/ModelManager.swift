//
//  ModelManager.swift
//  DemoSqlite
//
//  Created by LSN SOFTWARE on 23/03/17.
//  Copyright © 2017 LSN SOFTWARE. All rights reserved.
//

import UIKit
let sharedInstance = ModelManager()
class ModelManager: NSObject {

    var database: FMDatabase? = nil
   class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("test.sqlite"))
        }
        return sharedInstance
    }
    func InsertLogincredits(_ LoginInfo: Login) -> Void {
        sharedInstance.database!.open()
         sharedInstance.database!.executeUpdate(Constants.insertlogincredits, withArgumentsIn: [LoginInfo.cId, LoginInfo.ptn,LoginInfo.passwd])
        sharedInstance.database!.close()
        
    }
    func InsertLoginresponse(_ Loginresponse: LoginResponse) -> Void {
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate(Constants.insertloginresponce, withArgumentsIn: [Loginresponse.callToDo, Loginresponse.uName,Loginresponse.empNo,Loginresponse.uId,Loginresponse.cId,Loginresponse.SFA,Loginresponse.sessionId])
        sharedInstance.database!.close()
        
    }
    func InsertSettings(_ Settingsreponse: Settings) -> Void {
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate(Constants.insertSetting, withArgumentsIn: [Settingsreponse.AUTO_TRACKING_ENABLED, Settingsreponse.LOG_OUT,Settingsreponse.ENABLE_PICTURE,Settingsreponse.CONNECT_BLUETOOTH,Settingsreponse.ALLOW_MULTIPLE_VISIT,Settingsreponse.ENABLE_MESSAGING,Settingsreponse.ASSIGNMENT_CHECK_INTERVAL,Settingsreponse.CLEAR_DATA_ON_LOGOUT, Settingsreponse.CHECK_FOR_UPDATE,Settingsreponse.ENABLE_SUBCUSTOMER,Settingsreponse.ASSIGNMENT_ENABLED,Settingsreponse.ENABLE_RETAILER,Settingsreponse.TRACKING_FREQUENCY,Settingsreponse.SEND_LOW_BATTERY_ALERT,Settingsreponse.ENABLE_AUDIO, Settingsreponse.SENDING_FREQUENCY,Settingsreponse.TRACKING_LEVEL,Settingsreponse.SAMPLING_FREQUENCY,Settingsreponse.DELETE_SUBCUSTOMER,Settingsreponse.SMS_ENABLED,Settingsreponse.ENABLE_ROUTE,Settingsreponse.ALLOW_MULTIPLE_VISIT_CUSTOMER, Settingsreponse.TRACKING_END_TIME,Settingsreponse.ENABLE_EDIT_FORM,Settingsreponse.INCLUDE_CELLSITE,Settingsreponse.TRACKING_START_TIME,Settingsreponse.ENABLE_VIDEO])
        sharedInstance.database!.close()
        
    }
    func getLogincredits() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(Constants.sel_tblLoginCredits, withArgumentsIn: nil)
        let marrStudentInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let login:Login=Login()
                login.cId = resultSet.string(forColumn: "cId")
                login.ptn = resultSet.string(forColumn: "ptn")
                login.passwd = resultSet.string(forColumn: "passwd")
                marrStudentInfo.add(login)
            }
        }
        sharedInstance.database!.close()
        return marrStudentInfo
    }
    

  func getLoginresponse() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(Constants.sel_tblLoginResponce, withArgumentsIn: nil)
        let marrStudentInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                
                
                let loginResponse:LoginResponse=LoginResponse()
                loginResponse.callToDo = resultSet.string(forColumn: "callToDo")
                loginResponse.uName = resultSet.string(forColumn: "uName")
                loginResponse.empNo = resultSet.string(forColumn: "empNo")
                loginResponse.uId = resultSet.string(forColumn: "uId")
                loginResponse.cId = resultSet.string(forColumn:"cId")
                loginResponse.SFA = resultSet.string(forColumn:"SFA")
                loginResponse.sessionId = resultSet.string(forColumn: "sessionId")
                
            marrStudentInfo.add(loginResponse)
            }
        }
        sharedInstance.database!.close()
        return marrStudentInfo
    }
    /*
 func getSettings() -> NSMutableArray {
 sharedInstance.database!.open()
 let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(Constants.sel_tblLoginResponce, withArgumentsIn: nil)
 let marrStudentInfo : NSMutableArray = NSMutableArray()
 if (resultSet != nil) {
 while resultSet.next() {
 
 
 let settings:Settings=Settings()
 settings.AUTO_TRACKING_ENABLED = resultSet.string(forColumn:"AUTO_TRACKING_ENABLED")
 settings.LOG_OUT = resultSet.string(forColumn:"LOG_OUT")
 settings.ENABLE_PICTURE = resultSet.string(forColumn:"ENABLE_PICTURE")
 settings.CONNECT_BLUETOOTH = resultSet.string(forColumn: "CONNECT_BLUETOOTH")
 settings.ALLOW_MULTIPLE_VISIT = resultSet.string(forColumn: "ALLOW_MULTIPLE_VISIT")
 settings.ENABLE_MESSAGING = resultSet.string(forColumn: "ENABLE_MESSAGING")
 settings.ASSIGNMENT_CHECK_INTERVAL = resultSet.string(forColumn: "ASSIGNMENT_CHECK_INTERVAL")
 settings.CLEAR_DATA_ON_LOGOUT = resultSet.string(forColumn: "CLEAR_DATA_ON_LOGOUT")
 settings.CHECK_FOR_UPDATE = resultSet.string(forColumn: "CHECK_FOR_UPDATE")
 settings.ENABLE_SUBCUSTOMER = resultSet.string(forColumn: "ENABLE_SUBCUSTOMER")
 settings.ASSIGNMENT_ENABLED = resultSet.string(forColumn: "ASSIGNMENT_ENABLED")
 settings.ENABLE_RETAILER = resultSet.string(forColumn: "ENABLE_RETAILER")
 settings.TRACKING_FREQUENCY = resultSet.string(forColumn: "TRACKING_FREQUENCY")
 settings.SEND_LOW_BATTERY_ALERT = resultSet.string(forColumn: "SEND_LOW_BATTERY_ALERT")
 settings.ENABLE_AUDIO = resultSet.string(forColumn: "ENABLE_AUDIO")
 settings.SENDING_FREQUENCY = resultSet.string(forColumn: "SENDING_FREQUENCY")
 settings.TRACKING_LEVEL = resultSet.string(forColumn: "TRACKING_LEVEL")
 settings.SAMPLING_FREQUENCY = resultSet.string(forColumn: "SAMPLING_FREQUENCY")
 settings.DELETE_SUBCUSTOMER = resultSet.string(forColumn: "DELETE_SUBCUSTOMER")
 settings.SMS_ENABLED = resultSet.string(forColumn: "SMS_ENABLED")
 settings.ENABLE_ROUTE = resultSet.string(forColumn: "ENABLE_ROUTE")
 settings.ALLOW_MULTIPLE_VISIT_CUSTOMER = resultSet.string(forColumn: "ALLOW_MULTIPLE_VISIT_CUSTOMER")
 settings.TRACKING_END_TIME = resultSet.string(forColumn: "TRACKING_END_TIME")
 settings.ENABLE_EDIT_FORM = resultSet.string(forColumn: "ENABLE_EDIT_FORM")
 settings.INCLUDE_CELLSITE = resultSet.string(forColumn: "INCLUDE_CELLSITE")
 settings.TRACKING_START_TIME = resultSet.string(forColumn: "TRACKING_START_TIME")
 settings.ENABLE_VIDEO = resultSet.string(forColumn: "ENABLE_VIDEO")
 
 marrStudentInfo.add(settings)
 }
 }
 sharedInstance.database!.close()
 return marrStudentInfo
 }
 */
    func deleteTabeldata(tableName:String) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("delete from \(tableName)", withArgumentsIn: nil)
        sharedInstance.database!.close()
        return isDeleted
    }
 
}

