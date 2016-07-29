//
//  AddNewNoteViewController.swift
//  InClass08
//
//  Created by Carlos Rosario on 7/28/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import CoreData

class AddNewNoteViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext

    weak var refreshUserTableViewDelegate: refreshUsersDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newNoteTextView: UITextView!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Add New Note"
        newNoteTextView.layer.borderWidth = 2.0
        nameLabel?.text = user?.name
    }

    @IBAction func cancel(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveNewNote(sender: UIButton) {
        
        if let note = newNoteTextView.text {
            if note != "" {
                dispatch_async(dispatch_get_main_queue()){
                    self.managedObjectContext?.performBlockAndWait{
                        
                        if let newUserNote = NSEntityDescription.insertNewObjectForEntityForName("UserNote", inManagedObjectContext: (self.managedObjectContext)!) as? UserNote {
                            
                            //let uuid = NSUUID().UUIDString
                            //newUserNote.id = uuid
                            newUserNote.notetext = note
                            //newUserNote.userid = self.user?.id
                            newUserNote.created = NSDate()
                            let usernotes = self.user?.mutableSetValueForKey("userNotes")
                            usernotes?.addObject(newUserNote)
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
                let alertController = UIAlertController(title: "Error", message: "Please enter a note", preferredStyle: .Alert)  // .ActionSheet
                
                // Create the action
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                // Add action to the AlertController
                alertController.addAction(defaultAction)
                
                // Show the alert
                self.presentViewController(alertController, animated: true, completion: nil)            }
        }
    }
}
