//
//  QuestionModel.swift
//  Bible Trivia
//
//  Created by Kyle Garcia on 3/19/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class Question: Object {
    
    @objc dynamic var questionText : String = ""
    @objc dynamic var answer : String = ""
    @objc dynamic var category : String = ""
    @objc dynamic var amount : Int = 0
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "questions")
    
//    let questionText : String
//    let answer : String
//    let category : String
//
//    init(text: String, correctAnswer: String, categorySelected: String){
//        questionText = text
//        answer = correctAnswer
//        category = categorySelected
//
//    }
}
