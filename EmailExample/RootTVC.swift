//
//  RootTVC.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

protocol CellSelectedDelegate {
    func read(email : Email)
}

protocol DataUpdateDelegate {
    func delete(removemails : [Email], trashemails: [Email])
    func send(newemails : [Email])
    
}

class RootTVC: UITableViewController {
    var emails = [Email]()
    var delegate: CellSelectedDelegate?
    var delegateupdate: DataUpdateDelegate?
    var newemails = [Email]()
    var removemails = [Email]()
     var trashemails = [Email]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem!.title = "test"
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
        return emails.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: react to user selecting row
        //I want the detail view controller to update based on the row that I selected
        
       let selectedEmail = emails[indexPath.row]
       delegate?.read(email: selectedEmail)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let currentEmail = emails[indexPath.row]
        cell.textLabel?.text = currentEmail.subject
        cell.detailTextLabel?.text = currentEmail.sender
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            trashemails = [emails[indexPath.row]]
           //  print("\(trashemails)")
            // Delete the row from the data source
             emails.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .automatic)
             removemails = emails
            delegateupdate?.delete(removemails: removemails, trashemails: trashemails)
            
        }
           /* } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }*/
 
    }

    
    func  actionEdit(){
        tableView.insertRows(at: [], with: .automatic)
        emails.append(Email(sender: "asu@asu.edu", subject: "Spam", contents: "It works!"))
        tableView.reloadData()
        newemails = emails
        delegateupdate?.send(newemails: newemails)
        /*for item in newemails {
            print("\(item.sender) "+"\(item.subject)")
        }*/
        
    }
    
    
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
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       let menuDest = segue.destination as! MenuTVC
       menuDest.test = newemail
        
        // menuDest.tableView.reloadData()
      // delegateupdate?.send(emailsupdate: newemail)
        
    }*/
    
}
