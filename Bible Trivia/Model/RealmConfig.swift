//
//  RealmConfig.swift
//  Bible Trivia
//
//  Created by Kyle Garcia on 3/28/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmConfig {
    //copy bundled file to documents folder
//   private static var copyInitialFile: Void = {
//        TriviaData.copyInitialData(
//            Bundle.main.url(forResource: "default_v1.0", withExtension: "realm")!
//            , to: RealmConfig.mainConfig.fileURL!)
//
//    }()
    
    //private configurations
    private static let mainConfig = Realm.Configuration(
        fileURL: URL.inDocumentsFolder(fileName: "questionBank.realm"),
        schemaVersion: 1
    )
    
    //enum cases
    case main
    
    
    //MARK: - Current COnfiguration
    var configuration: Realm.Configuration{
        switch self {
        case .main:
            //_ = RealmConfig.copyInitialFile
            return RealmConfig.mainConfig
        }
    }
    
}

extension URL {
    
    // returns an absolute URL to the desired file in documents folder
    static func inDocumentsFolder(fileName: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
            .appendingPathComponent(fileName)
    }
}

struct TriviaData {
    
    // MARK: - copy a file
    static func copyInitialData(_ from: URL, to: URL) {
        let copy = {
            _ = try? FileManager.default.removeItem(at: to)
            try! FileManager.default.copyItem(at: from, to: to)
        }
        
        let exists: Bool
        do {
            exists = try to.checkPromisedItemIsReachable()
        } catch {
            copy()
            return
        }
        if !exists {
            copy()
        }
    }
    
    
}


