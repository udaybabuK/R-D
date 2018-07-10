//
//  AppDelegate.swift
//  IndiaSwift
//
//  Created by Orient Technologies Mac on 6/5/18.
//  Copyright © 2018 Orient. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.createDataBase()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func createDataBase() -> Void {
        let fileManager = FileManager.default
        if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let databasePath = documentsURL.appendingPathComponent(Constants.INDIACASTDB).path
            print("directory path:", documentsURL.path)
            print("database path:", databasePath)
            // open database
            
            var db: OpaquePointer?
            if sqlite3_open(databasePath, &db) == SQLITE_OK {
                if sqlite3_exec(db, Constants.tblLogincredits, nil, nil, nil) != SQLITE_OK {
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("error creating tblLogincredits: \(errmsg)")
                }
                if sqlite3_exec(db, Constants.tblLoginResponce, nil, nil, nil) != SQLITE_OK {
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("error creating tblLoginResponse: \(errmsg)")
                }
            }
            
            
            
            if !fileManager.fileExists(atPath: databasePath) {
                fileManager.createFile(atPath: databasePath, contents: nil, attributes: nil)
            }
        }
        
        // open database
    Util.copyFile("test.sqlite")
    }
}

