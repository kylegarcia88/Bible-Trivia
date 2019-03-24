//
//  Category.swift
//  Bible Trivia
//
//  Created by Kyle Garcia on 3/20/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var amount : Int = 0
    @objc dynamic var categorySelected : String = ""
    @objc dynamic var hasBeenSelected : Bool = false
    
    let questions = List<Question>()
    
}
