//
//  ViewController.swift
//  Bulats_practice
//
//  Created by Admin on 23/11/2017.
//  Copyright © 2017 utt.fr. All rights reserved.
//

import UIKit
import SQLite
class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    var db: Connection!
    
    let sentencessTable = Table("sentences")
    let id = Expression<Int>("id")
    let type = Expression<String>("Type")
    let sentence = Expression<String>("sentence")
    let position = Expression<Int>("position")
    let paragraph = Expression<Int>("paragraph")

    var tableView: UITableView  =   UITableView()
    var items: [String] = ["Viper", "X", "Games"]

    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var alert: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        do {
            self.db = try Connection("/Users/admin/Documents/Xcode-applications/Project/Bulats_practice/Bulats.db")
        }
        catch{
            print(error)
        }
        listSentence()
        
        //add cells
        tableView.frame         =  CGRect(origin: CGPoint(x: 0,y :50), size: CGSize(width: 320, height: 200))
        tableView.delegate      =   self
        tableView.dataSource    =   self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        
       
        
        // Do any additional setup after loading the view.
    }

  
    
    
   
    
    
    
    
    func listSentence() {
        print("list user")
       

        do{
            let sentences = try self.db.prepare(self.sentencessTable.filter(self.type == "Right word"))
            
            //let sentences = self.sentencessTable.filter(self.type == "Right word")
            
            for sentence in sentences{
                
                print("userID  \(sentence[self.id]), type : \(sentence[self.type]), sentence : \(sentence[self.sentence]), paragraph : \(String(sentence[self.position])), type : \(String(sentence[self.paragraph]))")
            }
        }
        catch{
            print(error)
        }
    }
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("SUce !!!!")
        var cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text = "row#\(indexPath.row)"
        cell.detailTextLabel?.text = "subtitle#\(indexPath.row)"
        return cell
    }
    
    
    func sideMenu()
    {
        if revealViewController() != nil {
            menu.target = revealViewController()
            
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            alert.target = revealViewController()
            alert.action = #selector(SWRevealViewController.rightRevealToggle(_:))

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("yolojdjkqshdjkqshjkd")

    }
    

}
