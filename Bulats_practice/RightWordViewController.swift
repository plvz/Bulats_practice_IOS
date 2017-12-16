//
//  RightWordViewController.swift
//  Bulats_practice
//
//  Created by Admin on 15/12/2017.
//  Copyright © 2017 utt.fr. All rights reserved.
//

import UIKit
import SQLite
class RightWordViewController: UIViewController {
    var db: Connection!
    
    let sentencessTable = Table("sentences")
    let id = Expression<Int>("id")
    let type = Expression<String>("Type")
    let sentence = Expression<String>("sentence")
    let position = Expression<Int>("position")
    let paragraph = Expression<Int>("paragraph")
    
    
    let answersTable = Table("answers")
    let idAnswer = Expression<Int>("id")
    let fk_sentence = Expression<Int>("fk_sentence")
    let answer = Expression<String>("answer")
    let valid = Expression<String>("valid")
    
    
    
    
    
    var valid_Answer = 0

    @IBOutlet weak var startSentence: UILabel!
    @IBOutlet weak var blankText: UILabel!
    @IBOutlet weak var endSentence: UILabel!
    
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            self.db = try Connection("/Users/admin/Documents/Xcode-applications/Project/Bulats_practice/Bulats.db")
        }
        catch{
            print(error)
        }
        listSentence()

       // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func listSentence(){
        print("list user")
        
        
        do
        {
            let sentences = try self.db.prepare(self.sentencessTable.filter(self.type == "Right word").limit(1, offset: 0))
            //let sentences = self.sentencessTable.filter(self.type == "Right word")
            for sentence in sentences{
                let id = sentence[self.id]

                let position = Int(sentence[self.position])
                let sentence = sentence[self.sentence]
                //print("userID  \(sentence[self.id]), type : \(sentence[self.type]), sentence : \(sentence[self.sentence]), position : \(String(sentence[self.position])), pargraph : \(String(sentence[self.paragraph]))")
                
                let sentenceArray = sentence.characters.split{$0 == " "}.map(String.init)
                

                
                
                print(sentenceArray[0] )
                print("position :")
                print(position)
                var splitedSetnece = buildSentence(arrayString: sentenceArray, limit: position)
                startSentence?.text = splitedSetnece[0]
                endSentence?.text = splitedSetnece[1]
                
                
                print("ID :")
                print(id)
                var c=0
                let answers = try self.db.prepare(self.answersTable.filter(self.fk_sentence == id))
                for answer in answers
                {
                    print("I am over here !!!!")
                    var labelAnswer = answer[self.answer]
                    print(labelAnswer)

                    
                    
                    
                    
                    switch c {
                    case 0:
                        answerA.setTitle(labelAnswer, for: UIControlState.normal)
                        print("Button A")
                    case 1:
                        answerB.setTitle(labelAnswer, for: UIControlState.normal)
                        print("Button B")
                    case 2:
                        answerC.setTitle(labelAnswer, for: UIControlState.normal)
                        print("Button C")
                    case 3:
                        answerD.setTitle(labelAnswer, for: UIControlState.normal)
                        print("Button D")
                    default:
                        print("Some other character")
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    var validity = answer[self.valid]
                    print(validity)
                    if(validity == "True")
                    {
                       valid_Answer = c
                    }
                    
                    
                    
                    
                    c = c + 1

                }

                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                

            }
        }
        catch
        {
            print(error)
        }
    }
    
    func buildSentence(arrayString: [String], limit: Int) -> [String]
    {
        var firstPart = ""
        var secondPart = ""

        var counter = 0
        for c in arrayString {
            
            if(counter < limit)
            {
                print(c)
                firstPart += c+" "
            }
            else
            {
                print(c)
                secondPart += c+" "
            }
            counter = counter + 1

        }
        return [firstPart,secondPart]
    }
    
    
    
    
    
    
    
    func checkAnswers(answer_num: Int)
    {
        print(answer_num)
        if(answer_num == valid_Answer){
            print("correct answer !!!!")
        }
        else
        {
            print("Wrong !!!")
        }
    }
    
    //Answers Button
    @IBAction func answerA(_ sender: Any) {
        print("A")
        checkAnswers(answer_num :0)
    }
    
    
    @IBAction func answerB(_ sender: Any) {
        print("B")
        checkAnswers(answer_num :1)
    }
    
    @IBAction func answerC(_ sender: Any) {
        print("C")
        checkAnswers(answer_num :2)

    }
    
    @IBAction func answerD(_ sender: Any) {
        print("D")
        checkAnswers(answer_num :3)

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
