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
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    
    var questions : Results<Question>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadQuestion()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel.isHidden = true
        
        QuestionStyle()
        answerButtonStyle()
        answerStyle()
        
        
    }
    
    func loadQuestion() {
        questions = realm.objects(Question.self)
//        let selectedAmount = selectedCategory?.amount ?? 0
//        let selectedQuestionCategory = selectedCategory?.categorySelected ?? "cant find"
//
//
//        if let questionResult = questions?.filter("category CONTAINS[cd] '\(selectedQuestionCategory)' AND amount == \(selectedAmount)") {
//            //questionLabel.text = "\(questionResult.first?.questionText ?? "Filter Failed"))"
//            print(" questionREsult: \(questionResult.first?.questionText ?? "filter failed")")
//        }
        
        
        
        
       // print("questionResult: \(String(describing: questionResult?.first?.questionText))")
        
      //  print(" Selected Category Amount: \(selectedCategory?.questions.first?.amount ?? 0)")
        //print(" Selected question category: \(selectedQuestionCategory)")
        
        //print("question Array: \(questions?.first?.questionText)")
        //print("Question Data: \(questions?.first?.questionText)")
        
        
    }
    
    
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        answerLabel.isHidden = false
        answerButton.isHidden = true
    }
    
    //MARK: - Stylling
    func QuestionStyle() {
        questionLabel.backgroundColor = UIColor(hex: "#3498db")
        questionLabel.textColor = UIColor.white
        
        let selectedAmount = selectedCategory?.amount ?? 0
        let selectedQuestionCategory = selectedCategory?.categorySelected ?? "cant find"
        if let questionResult = questions?.filter("category CONTAINS[cd] '\(selectedQuestionCategory)' AND amount == \(selectedAmount)") {
            questionLabel.text = "\(questionResult.first?.questionText ?? "Filter Failed")"
            answerLabel.text = "\(questionResult.first?.answer ?? "Filter Failed")"
           // print(" questionREsult: \(questionResult.first?.questionText ?? "filter failed")")
        }
        
        
        //questionLabel.text = "\()"
        let screensize : CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        questionLabel.frame.size = CGSize(width: screenWidth/2, height: (screenHeight)/2 )
        answerLabel.frame.size = CGSize(width: screenWidth/2, height: (screenHeight)/2 )
        
    
        
        
        questionLabel.layer.cornerRadius = 20
        questionLabel.clipsToBounds = true
        
        
    }
    
    func answerButtonStyle() {
        answerButton.backgroundColor = UIColor(hex: "#16a085")
        answerButton.tintColor = UIColor.white
        answerButton.layer.cornerRadius = answerButton.frame.height/2
        answerButton.setTitleColor(UIColor.white, for: .normal)
        answerButton.setTitle("View Answer", for: .normal)
    }
    
    func answerStyle() {
        
        answerLabel.backgroundColor = UIColor(hex: "#16a085")
        answerLabel.layer.cornerRadius = 20
        answerLabel.tintColor = UIColor.white
        answerLabel.clipsToBounds = true
        
    
    }
    
    
    
    
    
}
