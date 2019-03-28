//
//  ViewController.swift
//  Bible Trivia
//
//  Created by Kyle Garcia on 3/17/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var catagories : Results<Category>!
    
    
    

    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    //let allQuestions = QuestionBank()
    var selectedCategory = ""
    
    let reuseIdentifier = "boardCell"
    //var catagories = ["The Disciples", "Old Testament", "New Testament", "Heroes", "Jesus", "100", "100", "100", "100", "100", "200", "200", "200", "200", "200", "300", "300", "300", "300", "300", "400", "400", "400", "400", "400", "500", "500","500","500","500"]
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //realm file path
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    
        
        boardCollectionView.dataSource = self
        boardCollectionView.delegate = self
        
        //styling
        cellLayout()
        boardCollectionView.backgroundColor = UIColor(hex: "#ecf0f1")
        view.backgroundColor = UIColor(hex: "#ecf0f1")
        
        //load data
        loadCatagories()
        
        
        
        
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catagories?.count ?? 1
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {    
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if let catagory = catagories?[indexPath.item] {
        
        cell.boardLabel?.text = catagory.name
        //top row a different color
        if indexPath.item < 5 {
            cell.backgroundColor = UIColor(hex: "#6c5ce7")
            cell.boardLabel.textColor = UIColor(hex: "#ecf0f1")
        } else {
            
            if let category = catagories?[indexPath.row] {
                do {
                    try realm.write {
                        category.hasBeenSelected = false
                    }
                } catch {
                    print("Error updating item done status, \(error)")
                }
            }
            
            cell.backgroundColor = UIColor(hex: "#0984e3")
            cell.boardLabel.textColor = UIColor(hex: "#ecf0f1")
        }
        }
        
        
        //cell.layer.borderColor = UIColor(hex: "#2980b9")?.cgColor
        //cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if  indexPath.item > 4 {
            if let category = catagories?[indexPath.row] {
                if category.hasBeenSelected == false {
                    do {
                        try realm.write {
                            category.hasBeenSelected = !category.hasBeenSelected
                        }
                    } catch {
                        print("Error updating item done status, \(error)")
                    }
                    performSegue(withIdentifier: "goToQuestion", sender: self)
                }
            }

        } else {

        }
        
    }
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if indexPath.item > 4{
            cell?.backgroundColor = UIColor.gray
            
        } else {
        }
        
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if indexPath.item > 5{
        cell?.backgroundColor = UIColor.gray
        } else {
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       let destinationVC = segue.destination as! QuestionViewController

        if let indexPath = boardCollectionView.indexPathsForSelectedItems?.first{

            //print ("Selected Index Path:\(indexPath) ")
            //print(indexPath.row)
            destinationVC.selectedCategory = catagories?[indexPath.row]
            print("Data being passed: \(destinationVC.selectedCategory!)")

        }

    }
    
    //MARK: - Restart Button Pressed
    
    @IBAction func restartButtonPressed(_ sender: Any) {
        
        boardCollectionView.reloadData()
        
    }
    
    

    //MARK: - Loading Realm Data
    
    func loadCatagories () {
        
        catagories = realm.objects(Category.self)
        
        boardCollectionView.reloadData()
        
    }
    
    
    
    //MARK: - Cell Styling
    func cellLayout () {
        
//        let itemWidth = (UIScreen.main.bounds.width-20)/5
//        let itemHeight = (UIScreen.main.bounds.height - 20)/5
        
        let itemWidth = (self.boardCollectionView.frame.width-12)/5
        let itemHeight = (self.boardCollectionView.frame.height-14)/6
        
        let layout = self.boardCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.sectionInset = UIEdgeInsets(top: 1,left: 1,bottom: 1,right: 1)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        boardCollectionView.collectionViewLayout = layout
    }
    
}


extension UIColor {
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
}
}


