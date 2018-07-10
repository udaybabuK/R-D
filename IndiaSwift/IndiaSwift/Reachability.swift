//
//  Reachability.swift
//  Forms
//
//  Created by Orient Technologies Mac on 7/31/17.
//  Copyright © 2017 Orient. All rights reserved.
//

import UIKit

class Reachability: NSObject {
   static let sharedInstance = Reachability()
    
    
    class func isConnectedToNetwork(Url:String)->Bool{
        
        var Status:Bool = false
        let url = NSURL(string: Constants.WebUrl)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: URLResponse?
        
         if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
            
                Status = true
            
        }
        else
        {
            
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            
            alert.show()
        }
        
        return Status
    }
}
