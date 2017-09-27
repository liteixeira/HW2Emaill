//
//  MenuTVC.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/20/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit
//import Foundation



class MenuTVC: UITableViewController, DataUpdateDelegate {
    
    var dataDictionary: [String:Array<Email>] = [:]
    var selectedRow = ""
    var delegate: CellSelectedDelegate?
   // var trashDataDictionary : [String:Array<Email>] = [:]
    var receiveTrashEmails = [Email]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //  self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataDictionary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)

        // Configure the cell...
        let keywords = Array(dataDictionary.keys)
        cell.textLabel?.text = keywords[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: react to user selecting row
        //I want the detail view controller to update based on the row that I selected
       
        
        print("In didSelectRowAt")
        //TODO: get cell information
        let keywords = Array(dataDictionary.keys)
        selectedRow = keywords[indexPath.row]
        print("\(selectedRow)")
        
        //call segue manually
        performSegue(withIdentifier: "cellSelected", sender: self)
        
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func send(newemails: [Email]) {
       // test = newemails
        dataDictionary[selectedRow] = newemails
       /* for item in dataDictionary[selectedRow]! {
            print("\(item.sender)")
        }*/
    }
    
    func delete(removemails : [Email], trashemails: [Email]) {
        dataDictionary[selectedRow] = removemails
        receiveTrashEmails = trashemails
        
        for item in receiveTrashEmails {
            print("\(item.sender)")
        }

        count = 0
    } 
    
    

    
    // Override to support editing the table view.
   /* override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
          //  let keywords = Array(dataDictionary.keys)
          //  deleteRow = keywords[indexPath.row]
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! RootTVC
       
        destVC.emails = dataDictionary[selectedRow]!
        
        destVC.delegate = delegate
        destVC.delegateupdate = self
        
     
        /*for item in destVC.emails {
            print("\(item.sender)")
        }*/
        
        destVC.navigationItem.title = "\(selectedRow)"
    
        if selectedRow == "Sent" {
           let addbutton = UIBarButtonItem(barButtonSystemItem: .add, target: destVC, action: #selector(destVC.actionEdit))
           destVC.navigationItem.rightBarButtonItem = addbutton
        
        }
        else if selectedRow == "Inbox" {
            destVC.navigationItem.rightBarButtonItem = destVC.editButtonItem
            destVC.navigationItem.rightBarButtonItem!.title = "test"
            
        }
        else if selectedRow == "Trash" {
            if receiveTrashEmails != nil && count == 0 {
                dataDictionary[selectedRow]?.append(contentsOf: receiveTrashEmails)
                destVC.emails = dataDictionary[selectedRow]!
                 count += 1
                
            }
           
            
        }
        
        
        
       
        //1. which button got pressed
        //2. up-to-date data
        
        print("In prepare")
    }
    


}
