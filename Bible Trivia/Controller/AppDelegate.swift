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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
        
        if let v0URL = bundleURL("default-v1") {
            do {
                try FileManager.default.removeItem(at: defaultURL)
                try FileManager.default.copyItem(at: v0URL, to: defaultURL)
            } catch {}
        }
        
        openRealm()
        
      
        
        return true
    }
    func openRealm() {
        
        if let v1URL = bundleURL("default-v1"){
            
            let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
            let defaultParentURL = defaultURL.deletingLastPathComponent()
            
            let realmv1URL = defaultParentURL.appendingPathComponent("default-v1.realm")
            
            let realmv1Configuration = Realm.Configuration(fileURL: realmv1URL, schemaVersion: 1)
            
            
            do {
                try FileManager.default.removeItem(at: realmv1URL)
                try FileManager.default.copyItem(at: v1URL, to: realmv1URL)
                
            } catch {}
            
            // migrate realms at realmv1Path manually, realmv2Path is migrated automatically on access
            try! Realm.performMigration(for: realmv1Configuration)
        
        }
        
    }
    func bundleURL(_ name: String) -> URL? {
        return Bundle.main.url(forResource: name, withExtension: "realm")
    }
    
    
    
    
}

