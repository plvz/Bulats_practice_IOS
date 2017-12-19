//
//  ExtraWordViewController.swift
//  Bulats_practice
//
//  Created by Admin on 18/12/2017.
//  Copyright © 2017 utt.fr. All rights reserved.
//

import UIKit
import SQLite
class ExtraWordViewController: UIViewController {
    var db: Connection!
    
    let sentencessTable = Table("sentences")
    let id = Expression<Int>("id")
    let type = Expression<String>("type")
    let sentence = Expression<String>("sentence")
    let position = Expression<Int>("position")
    let exercice = Expression<Int>("exercice")
    
    
    let answersTable = Table("answers")
    let idAnswer = Expression<Int>("id")
    let fk_sentence = Expression<Int>("fk_sentence")
    let answer = Expression<String>("answer")
    let valid = Expression<String>("valid")
    
    let historyTable = Table("history")
    let exercice_number = Expression<Int>("exercice_number")
    
    var arrayOfTextFields:[UITextField] = []
    var arrayOfAnswers:[String] = []
    var scrollView: UIScrollView!
    var currentExercice: Int!
    var history_exercice:[Int] = [-1]
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
        print("extra word !!!")
        listSentence()
        
        // Do any additional setup after loading the view.
    }
    
    
    func listSentence()
    {
        
        
        var yposition = 20
        do
        {
            let history = try self.db.prepare(self.historyTable)
            
            for exercice in history
            {
                history_exercice.append(Int(exercice[self.exercice_number]))
            }
            
            let sentences = try self.db.prepare(self.sentencessTable.filter(self.type == "Extra word" && !history_exercice.contains(id)))
            
            //let sentences = self.sentencessTable.filter(self.type == "Right word")
            for sentence in sentences{
                let id = sentence[self.id]
                currentExercice = sentence[self.exercice]
                let position = Int(sentence[self.position])
                let sentence = sentence[self.sentence]
               // print("userID  \(sentence[self.id]), type : \(sentence[self.type]), sentence : \(sentence[self.sentence]), position : \(String(sentence[self.position])), pargraph : \(String(sentence[self.paragraph]))")

                
                
                
                
                
                
                var label = UILabel()
                label.frame = CGRect(x: 10, y: yposition, width: 200, height: 70)
                label.textAlignment = NSTextAlignment.center
                label.numberOfLines = 3
                label.text = sentence
                scrollView.addSubview(label)
                
                
                let sampleTextField =  UITextField(frame: CGRect(x: 230, y: yposition, width: 100, height: 70))
                sampleTextField.placeholder = "answer"
                sampleTextField.font = UIFont.systemFont(ofSize: 15)
                sampleTextField.borderStyle = UITextBorderStyle.roundedRect
                sampleTextField.autocorrectionType = UITextAutocorrectionType.no
                sampleTextField.keyboardType = UIKeyboardType.default
                sampleTextField.returnKeyType = UIReturnKeyType.done
                sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
                sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
                //sampleTextField.delegate = self
                
                self.arrayOfTextFields.append(sampleTextField)
                scrollView.addSubview(sampleTextField)
                
                
                yposition = yposition + 70
                
                
                
                
                
               
                print("ID :")
                print(id)
                let answers = try self.db.prepare(self.answersTable.filter(self.fk_sentence == id))
                for answer in answers
                {
                    
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
    
    @IBAction func validate(_ sender: UIButton) {
        print("Button Tapped!!!")
        var c=0
        for textField in arrayOfTextFields{
            print(textField.text)
            print("answer :   ".uppercased())
            
            print("correction :   ".uppercased())
            print(arrayOfAnswers[c])
            
            if(arrayOfAnswers[c].uppercased() == textField.text?.uppercased())
            {
                textField.backgroundColor = UIColor.green
            }
            else
            {
                textField.backgroundColor = UIColor.red

            }
            
            
            
            c = c + 1

        }
     
        
    }
   

    
    @IBAction func next(_ sender: UIButton) {
        do {
            let rowid = try db.run(historyTable.insert(exercice_number <- currentExercice))
            
            print("inserted id: \(rowid)")
        } catch {
            print("insertion failed: \(error)")
        }
        //listSentence(offset: exercice_offset)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.s
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
