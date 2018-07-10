//
//  CastUUID.swift
//  IndiaSwift
//
//  Created by Orient Technologies Mac on 6/6/18.
//  Copyright © 2018 Orient. All rights reserved.
//

import UIKit

class CastUUID: NSObject {
static let sharedInstance = CastUUID()
    public func getUUID() -> String{
        var DeviceUUID:String?
        if !Helper.sharedInstance.isKeyPresentInUserDefaults(key:"deviceUUID") {
            
            DeviceUUID = String(String().toGetUUID())
            
            Helper.sharedInstance.setUserDefaults(value: DeviceUUID!, key: "deviceUUID")
        }else{
        DeviceUUID = Helper.sharedInstance.getUserDefaults(key: "deviceUUID")
        }
        return DeviceUUID!
    }
}
public extension String {
    func toGetUUID() -> String! {
        let uuid = NSUUID().uuidString.lowercased()
        let yourString = String(uuid)
        let urlNew:String =  (yourString?.replacingOccurrences(of: "-", with: ""))!
         Helper.sharedInstance.setUserDefaults(value: urlNew, key: "deviceUUID")
        return String(urlNew)
    }
}
