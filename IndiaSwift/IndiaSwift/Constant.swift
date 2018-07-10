//
//  Constant.swift
//  Forms
//
//  Created by Orient Technologies Mac on 7/29/17.
//  Copyright © 2017 Orient. All rights reserved.
//

import Foundation
class Constants: NSObject {
    static let sharedInstance = Constants()
    //Url's
    static let WebUrl = "http://106.51.136.169:8080"
     // static let Url = "http://192.168.12.33:8080/mg"
     static let Url = "\(WebUrl)/indiacast/mg.do"
     //  static let Url = "http://118.102.248.251:8585/mg"
    //Version
     static let Version = "3.1.4_IP"
    
    //ResponseMessage
    static let Message = "message"
    static let ResponseCode = "respCode"
    //login
    static let LoginSuccessMsg = "Login Success!"
    static let LoginSuccessRespCode = "success"
    //settings
    static let SettingsSuccessMsg = "Settings call Success!"
    static let SettingsSuccessRespCode = "success"
    // IC Sales Activity Approval Data
    static let ICSalesSuccessMsg = "IC Sales Activity Approval Data"
    static let ICSalesSuccessRespCode = "success"
    //
     static let  INDIACASTDB = "indiacast.db"
    //TabelNames
    static let  tblName_Logincredits = "tblLogincredits"
    static let  tblName_LoginResponce = "tblLoginResponce"
    static let  tblName_Settings = ""
    static let  tblName_ICSalesActivityApproval = ""
    //CreationQuery
    static let  tblLogincredits = "CREATE TABLE IF NOT EXISTS tblLogincredits (Id INTEGER PRIMARY KEY AUTOINCREMENT,cId NVARCHAR(20),ptn NVARCHAR(20),passwd NVARCHAR(20))";
    static let  tblLoginResponce = "CREATE TABLE IF NOT EXISTS tblLoginResponce (Id INTEGER PRIMARY KEY AUTOINCREMENT,callToDo NVARCHAR(200),uName NVARCHAR(50),empNo NVARCHAR(20),uId NVARCHAR(10),cId NVARCHAR(10),SFA NVARCHAR(10),sessionId NVARCHAR(20))";
    static let  tblSetting = "CREATE TABLE IF NOT EXISTS tblSettings (Id INTEGER PRIMARY KEY AUTOINCREMENT,AUTO_TRACKING_ENABLED INTEGER,LOG_OUT INTEGER,ENABLE_PICTURE INTEGER,CONNECT_BLUETOOTH INTEGER,ALLOW_MULTIPLE_VISIT INTEGER,ENABLE_MESSAGING INTEGER,ASSIGNMENT_CHECK_INTERVAL INTEGER,CLEAR_DATA_ON_LOGOUT INTEGER,CHECK_FOR_UPDATE INTEGER,ENABLE_SUBCUSTOMER INTEGER,ASSIGNMENT_ENABLED INTEGER,ENABLE_RETAILER INTEGER,TRACKING_FREQUENCY INTEGER,SEND_LOW_BATTERY_ALERT INTEGER,ENABLE_AUDIO INTEGER,SENDING_FREQUENCY INTEGER,TRACKING_LEVEL INTEGER,SAMPLING_FREQUENCY INTEGER,DELETE_SUBCUSTOMER INTEGER,SMS_ENABLED INTEGER,ENABLE_ROUTE INTEGER,ALLOW_MULTIPLE_VISIT_CUSTOMER INTEGER,TRACKING_END_TIME NVARCHAR(10),ENABLE_EDIT_FORM INTEGER,INCLUDE_CELLSITE INTEGER,TRACKING_START_TIME NVARCHAR(10),ENABLE_VIDEO INTEGER)"
    static let  tblICSalesActivityApproval = ""
    //InsertQuery
    static let insertlogincredits="INSERT INTO tblLogincredits (cId,ptn,passwd) VALUES (?, ?, ?)"
    static let insertloginresponce="INSERT INTO tblLoginResponce (callToDo ,uName ,empNo  ,uId ,cId ,SFA ,sessionId) VALUES (?, ?, ? ,?, ?, ?, ?)"
    static let  insertSetting = "INSERT INTO tblSettings (AUTO_TRACKING_ENABLED ,LOG_OUT ,ENABLE_PICTURE ,CONNECT_BLUETOOTH ,ALLOW_MULTIPLE_VISIT ,ENABLE_MESSAGING ,ASSIGNMENT_CHECK_INTERVAL ,CLEAR_DATA_ON_LOGOUT ,CHECK_FOR_UPDATE ,ENABLE_SUBCUSTOMER ,ASSIGNMENT_ENABLED ,ENABLE_RETAILER ,TRACKING_FREQUENCY ,SEND_LOW_BATTERY_ALERT ,ENABLE_AUDIO ,SENDING_FREQUENCY ,TRACKING_LEVEL ,SAMPLING_FREQUENCY ,DELETE_SUBCUSTOMER ,SMS_ENABLED ,ENABLE_ROUTE ,ALLOW_MULTIPLE_VISIT_CUSTOMER ,TRACKING_END_TIME ,ENABLE_EDIT_FORM ,INCLUDE_CELLSITE ,TRACKING_START_TIME ,ENABLE_VIDEO) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")"
    static let  insertICSalesActivityApproval = ""
     //SelectQuery
    static let sel_tblLoginCredits="SELECT * FROM tblLogincredits"
    static let sel_tblLoginResponce="SELECT * FROM tblLoginResponce"
    static let sel_tblSettings=""
    static let sel_tblApprovalAction=""
    static let sel_tblApprovalNotAction=""
    static let sel_tblApprovalcase=""
    
}
