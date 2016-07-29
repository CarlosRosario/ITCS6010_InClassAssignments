//
//  AddNewUserViewController.swift
//  InClass08
//
//  Created by Carlos Rosario on 7/28/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import CoreData

class AddNewUserViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    weak var refreshUserTableViewDelegate: refreshUsersDelegate?
    
    var managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New User"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIButton) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//        dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveUser(sender: UIButton) {
        
        if let name = nameTextField.text {
            if name != "" {
                dispatch_async(dispatch_get_main_queue()){
                    self.managedObjectContext?.performBlockAndWait{
                        
                        if let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: (self.managedObjectContext)!) as? User {
                            //let uuid = NSUUID().UUIDString
                            //newUser.id = uuid
                            newUser.name = name
                            newUser.created = NSDate()
                        }
                        
                        do {
                            try self.managedObjectContext?.save()
                            
                        } catch let error {
                            print ("Core Data Error: \(error)")
                        }
                    }
                    self.refreshUserTableViewDelegate?.refresh()
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            else {
                // Create the AlertController
                let alertController = UIAlertController(title: "Error", message: "Please enter a name", preferredStyle: .Alert)  // .ActionSheet
                
                // Create the action
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                // Add action to the AlertController
                alertController.addAction(defaultAction)
                
                // Show the alert
                self.presentViewController(alertController, animated: true, completion: nil)            }
        }
    }
}
