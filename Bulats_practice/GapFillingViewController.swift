//
//  GapFillingViewController.swift
//  Bulats_practice
//
//  Created by Admin on 18/12/2017.
//  Copyright © 2017 utt.fr. All rights reserved.
//

import UIKit
import SQLite
class GapFillingViewController: UIViewController {

    var db: Connection!
    
    let sentencessTable = Table("sentences")
    let id = Expression<Int>("id")
    let type = Expression<String>("type")
    let sentence = Expression<String>("sentence")
    let position = Expression<Int>("position")
    let paragraph = Expression<Int>("exercice")
    
    
    let answersTable = Table("answers")
    let idAnswer = Expression<Int>("id")
    let fk_sentence = Expression<Int>("fk_sentence")
    let answer = Expression<String>("answer")
    let valid = Expression<String>("valid")
    
    var arrayOfAnswers:[String] = []
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        do {
            self.db = try Connection("/Users/admin/Documents/Xcode-applications/Project/Bulats_practice/Bulats.db")
        }
        catch{
            print(error)
        }
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 100))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
        print("gap filling ")
        listSentence()
        // Do any additional setup after loading the view.
    }
    
    
    func listSentence()
    {
        
        
        var yposition = 20
        do
        {
            let sentences = try self.db.prepare(self.sentencessTable.filter(self.type == "Best Word"))
            
            let sampleTextField =  UITextField(frame: CGRect(x: 230, y: yposition, width: 100, height: 70))
            //let sentences = self.sentencessTable.filter(self.type == "Right word")
            for sentence in sentences{
                let id = sentence[self.id]
                
                let position = Int(sentence[self.position])
                let sentence = sentence[self.sentence]
                
                
                
                
                
            
                print("ID :")
                print(id)
                let answers = try self.db.prepare(self.answersTable.filter(self.fk_sentence == id))
                for answer in answers
                {
                    print("answer----------------------")
                    
                    arrayOfAnswers.append(answer[self.answer])
                    
                }
                
                
                
                
                
            }
        }
        catch
        {
            print(error)
        }
        self.view.addSubview(scrollView)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
