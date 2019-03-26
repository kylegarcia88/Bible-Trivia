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
        // Override point for customization after application launch.
        openRealm()
       
       
        return true
    }
    func openRealm() {
//        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
//        let bundleRealmPath = Bundle.main.url(forResource: "questionBank", withExtension: "realm")
//        
//        if !FileManager.default.fileExists(atPath: defaultRealmPath.absoluteString) {
//            do {
//                
//                try FileManager.default.copyItem(at: bundleRealmPath!, to: defaultRealmPath)
//            } catch let error {
//                print("error copying seeds: \(error)")
//            }
//        }
    }
    
    


}

