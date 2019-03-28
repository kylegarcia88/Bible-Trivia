//
//  AppDelegate.swift
//  Bible Trivia
//
//  Created by Kyle Garcia on 3/17/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        openRealm()
        
        return true
    }
    func openRealm() {
        
        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
        let bundleReamPath = defaultRealmPath.deletingLastPathComponent().appendingPathComponent("default.realm")
        
        if !FileManager.default.fileExists(atPath: defaultRealmPath.absoluteString) {
                
                try! FileManager.default.copyItem(at: bundleReamPath, to: defaultRealmPath)
        }
        
    }
}

