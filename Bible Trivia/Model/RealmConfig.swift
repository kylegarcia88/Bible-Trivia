//
//  RealmConfig.swift
//  Bible Trivia
//
//  Created by Kyle Garcia on 3/28/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import Foundation
import RealmSwift



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


