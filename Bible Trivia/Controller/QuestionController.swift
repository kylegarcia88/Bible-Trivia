//
//  QuestionController.swift
//  Bible Trivia
//
//  Created by Kyle Garcia on 3/19/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    

    
    var questions : Results<Question>?
    var pickedAnswer : String = ""
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadQuestion()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.hidesBackButton = true
        
        QuestionStyle()
        
        answerButtonStyle(answerButton: optionA)
        answerButtonStyle(answerButton: optionB)
        answerButtonStyle(answerButton: optionC)
        answerButtonStyle(answerButton: optionD)
        
        
    }
    
    func loadQuestion() {
        
        questions = realm.objects(Question.self)
    }
    
    

    
    //MARK: - Stylling
    func QuestionStyle() {
        questionLabel.backgroundColor = UIColor(hex: "#3498db")//UIColor(hex: "#ecf0f1")
        questionLabel.textColor = UIColor.white
        questionLabel.layer.shadowColor = UIColor(hex: "#34495e")?.cgColor
        questionLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        questionLabel.layer.shadowRadius = 3
        questionLabel.layer.shadowOpacity = 1.0
        
        
        let selectedAmount = selectedCategory?.amount ?? 0
        let selectedQuestionCategory = selectedCategory?.categorySelected ?? "cant find"
        if let questionResult = questions?.filter("category CONTAINS[cd] '\(selectedQuestionCategory)' AND amount == \(selectedAmount)") {
            //set question Text
            questionLabel.text = "\(questionResult.first?.questionText ?? "Filter Failed")"
            //Set Answer Button Text
            optionA.setTitle(questionResult.first?.optionA, for: .normal)
            optionB.setTitle(questionResult.first?.optionB, for: .normal)
            optionC.setTitle(questionResult.first?.optionC, for: .normal)
            optionD.setTitle(questionResult.first?.optionD, for: .normal)
        }
        
        let screensize : CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        questionLabel.frame.size = CGSize(width: screenWidth/2, height: (screenHeight)/2 )
        questionLabel.layer.cornerRadius = 20
        questionLabel.clipsToBounds = true
        
        
    }
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        let selectedAmount = selectedCategory?.amount ?? 0
        let selectedQuestionCategory = selectedCategory?.categorySelected ?? "cant find"
       
        if let questionResult = questions?.filter("category CONTAINS[cd] '\(selectedQuestionCategory)' AND amount == \(selectedAmount)") {
            //let correctAnswer = questionResult.first?.correctAnswer
            if sender.tag == 1{
                pickedAnswer = (questionResult.first?.optionA)!
                print(pickedAnswer)
                answerChecked()
                
            }
            else if sender.tag == 2{
                pickedAnswer = (questionResult.first?.optionB)!
                answerChecked()
            }
            else if sender.tag == 3{
                pickedAnswer = (questionResult.first?.optionC)!
                answerChecked()
            }
            else {
                pickedAnswer = (questionResult.first?.optionD)!
                answerChecked()
            }
            
        
        }
        navBar.hidesBackButton = false
        
    }
    
    
    func answerButtonStyle(answerButton: UIButton) {
        answerButton.backgroundColor = UIColor(hex: "#3498db")
        answerButton.tintColor = UIColor.white
        answerButton.layer.cornerRadius = answerButton.frame.height/2
        answerButton.setTitleColor(UIColor.white, for: .normal)
        answerButton.layer.shadowColor = UIColor(hex: "#34495e")?.cgColor
        answerButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        answerButton.layer.shadowRadius = 3
        answerButton.layer.shadowOpacity = 1.0
        
    }
    
    func answerChecked() {
        
        let selectedAmount = selectedCategory?.amount ?? 0
        let selectedQuestionCategory = selectedCategory?.categorySelected ?? "cant find"
        let questionResult = questions?.filter("category CONTAINS[cd] '\(selectedQuestionCategory)' AND amount == \(selectedAmount)")
        let correctAnswer = questionResult!.first?.correctAnswer
        print(correctAnswer!)
        print(pickedAnswer)
                
        if questionResult?.first?.optionA == correctAnswer! {
            optionB.backgroundColor = UIColor(hex: "#e74c3c")
            optionC.backgroundColor = UIColor(hex: "#e74c3c")
            optionD.backgroundColor = UIColor(hex: "#e74c3c")
            print(correctAnswer!)
        }else if questionResult?.first?.optionB == correctAnswer! {
            optionA.backgroundColor = UIColor(hex: "#e74c3c")
            optionC.backgroundColor = UIColor(hex: "#e74c3c")
            optionD.backgroundColor = UIColor(hex: "#e74c3c")
            print(correctAnswer!)
        }else if questionResult?.first?.optionC == correctAnswer! {
            optionA.backgroundColor = UIColor(hex: "#e74c3c")
            optionB.backgroundColor = UIColor(hex: "#e74c3c")
            optionD.backgroundColor = UIColor(hex: "#e74c3c")
            print(correctAnswer!)
        } else if questionResult?.first?.optionD == correctAnswer! {
            optionA.backgroundColor = UIColor(hex: "#e74c3c")
            optionB.backgroundColor = UIColor(hex: "#e74c3c")
            optionC.backgroundColor = UIColor(hex: "#e74c3c")
            print(correctAnswer!)
        } else {
            print("could not find a match for button coloring")
        }

    }
    
    
    
    
    
}
