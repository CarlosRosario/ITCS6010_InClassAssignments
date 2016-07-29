//
//  File.swift
//  InClass08
//
//  Created by Carlos Rosario on 7/28/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import CoreData

class UserTVC: UITableViewController, refreshUsersDelegate{
    var users = [User]()

    var managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    var selectedUser : User?
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.users.isEmpty {
            return 0
        }
        else {
            return self.users.count
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedUser = users[indexPath.row]
        super.performSegueWithIdentifier("showUserNotes", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        let user = self.users[indexPath.row]
        
        cell.textLabel?.text = user.name
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        cell.detailTextLabel?.text = "Created on " + dateFormatter.stringFromDate(user.created!)
        
        return cell
    }
    
    func getUsers(){
        let request = NSFetchRequest(entityName: "User")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
        
        //3
        do {
            let results =
                try managedObjectContext!.executeFetchRequest(request)
            self.users = results as! [User]

//            for user in results as! [User] {
//                print(user.name)
//                print(user.userNotes)
//            }
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAddNewUserSegue" {
            if let addNewUserTVC = segue.destinationViewController as? AddNewUserViewController {
                addNewUserTVC.managedObjectContext = managedObjectContext
                addNewUserTVC.refreshUserTableViewDelegate = self
            }
        }
        
        if segue.identifier == "showUserNotes" {
            if let userNotesTVC = segue.destinationViewController.contentViewController as? UserNotesTableViewController {
                userNotesTVC.user = selectedUser
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
    func refresh() {
        getUsers()
        self.tableView.reloadData()
    }
}


extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }
        else {
            return self
        }
    }
}