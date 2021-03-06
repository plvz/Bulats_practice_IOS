//
//  ViewController.swift
//  Bulats_practice
//
//  Created by Admin on 23/11/2017.
//  Copyright © 2017 utt.fr. All rights reserved.
//

import UIKit
import SQLite
class ViewController: UIViewController {
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
    
    let historyTable = Table("history")
    let exercice_number = Expression<Int>("exercice_number")
    
    @IBOutlet weak var rightWordProgressBar: UIProgressView!
    @IBOutlet weak var extraWordProgressBar: UIProgressView!
    @IBOutlet weak var gapFillingProgressBar: UIProgressView!
    
    
    var tableView: UITableView = UITableView()

    
    
    
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var alert: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            self.db = try Connection("/Users/admin/Documents/Xcode-applications/Project/Bulats_practice/Bulats.db")
        }
        catch{
            print(error)
        }
        
        load_stats()
       
        
        // Do any additional setup after loading the view.
    }

  
    func load_stats()
    {
        do
        {
            var stmt = try db.prepare("SELECT count (*) FROM sentences WHERE type='Right Word'")
            var count = try stmt.scalar() as! Int64
            
            var stmt2 = try db.prepare("SELECT count (*) FROM sentences WHERE type='Right Word' and sentences.id IN (SELECT * FROM history)")
            var done = try stmt2.scalar() as! Int64
            var percentage: Float = Float(done)/Float(count)
            if(done != 0){
                print(done)
                rightWordProgressBar.setProgress(percentage, animated: true)
            }
            else{
                rightWordProgressBar.setProgress(0, animated: true)
                
            }
            stmt = try db.prepare("SELECT count(*) FROM ( SELECT type,count (*) FROM sentences WHERE type='Extra Word' GROUP BY exercice)")
            count = try stmt.scalar() as! Int64
            
            stmt2 = try db.prepare("SELECT count(*) FROM ( SELECT count (*) FROM sentences WHERE type='Extra Word' and sentences.exercice IN (SELECT * FROM history) GROUP BY exercice) ")
            done = try stmt2.scalar() as! Int64
            percentage = Float(done)/Float(count)
            print(done)
            if(done != 0){
                print("oups")
                extraWordProgressBar.setProgress(percentage, animated: true)
            }
            else{
                extraWordProgressBar.setProgress(0, animated: true)

            }
            
            
        }
        catch
        {
            
        }
            
        
            

        
    }
   
    
    
    @IBAction func resetRightWord(_ sender: UIButton) {
        do{
            let stmt = try db.run("DELETE FROM HISTORY WHERE exercice_number IN (SELECT SENTENCES.exercice FROM SENTENCES WHERE TYPE ='Right Word')")
            print("coucou")

        }
        catch
        {
            
        }
        load_stats()

    }
    

    @IBAction func extraWordReset(_ sender: UIButton) {
        do{
            let stmt = try db.run("DELETE FROM HISTORY WHERE exercice_number IN (SELECT SENTENCES.exercice FROM SENTENCES WHERE TYPE ='Extra Word')")
            load_stats()
        }
        catch
        {
            
        }
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
    

}
