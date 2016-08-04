//
//  ShowNotesTableViewController.swift
//  InClass09
//
//  Created by Carlos Rosario on 8/2/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class ShowNotesTableViewController: UITableViewController, refreshUsersDelegate {

    @IBOutlet var newWordField: UITextField?
    var notebookname: String!
    var notes = [String]()
    var user: String!
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        var userString = user.stringByReplacingOccurrencesOfString("@", withString: "-")
        userString = userString.stringByReplacingOccurrencesOfString(".", withString: "-")
        
        rootRef.child(userString+"~~~~"+notebookname).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if(snapshot.value != nil){
                if(snapshot.value is NSNull){
                    
                }
                else {
                    
                    let notesfromDB = snapshot.value! as! [String]
                    self.notes.removeAll()
                    for note in notesfromDB {
                        self.notes.append(note)
                    }
                    self.tableView.reloadData()
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notes.isEmpty {
            return 0
        }
        else {
            return notes.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notecell", forIndexPath: indexPath)
        
        if let notecell = cell as? NoteTableViewCell{
            var cellData = (note: "", date: "", dbkey: "", row: "")
            
            let tempArray = notes[indexPath.row].componentsSeparatedByString("~~~")
            
            cellData.note = tempArray[0]
            
            if tempArray.count > 1 {
                cellData.date = tempArray[1]
            }
            var userString = user.stringByReplacingOccurrencesOfString("@", withString: "-")
            userString = userString.stringByReplacingOccurrencesOfString(".", withString: "-")
            cellData.dbkey = userString+"~~~~"+notebookname
            cellData.row = String(indexPath.row)
            notecell.data = cellData
            notecell.refreshUserTableViewDelegate = self
            
            return notecell
        }
        
        return cell
    }
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func newNoteEntered(alert: UIAlertAction!){
        // get new notebook name and print it (for now)
        var newNote = self.newWordField?.text
        newNote = newNote! + "~~~" + String(NSDate())
        
        // Enter new notebook name into firebase
        var userString = user.stringByReplacingOccurrencesOfString("@", withString: "-")
        userString = userString.stringByReplacingOccurrencesOfString(".", withString: "-")
        
        notes.append(newNote!)
        let userRef = rootRef.child(userString+"~~~~"+notebookname).setValue(notes)
        self.tableView.reloadData()
    }
    
    
    func addTextField(textField: UITextField){
        textField.placeholder = "New Note"
        self.newWordField = textField
    }

    
    @IBAction func addNote(sender: UIBarButtonItem) {
        let refreshAlert = UIAlertController(title: "New Note", message: "Enter New Note", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addTextFieldWithConfigurationHandler(addTextField)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: newNoteEntered))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func refresh(row: Int) {
//        var userString = user.stringByReplacingOccurrencesOfString("@", withString: "-")
//        userString = userString.stringByReplacingOccurrencesOfString(".", withString: "-")
//        
//        rootRef.child(userString+"~~~~"+notebookname).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//            
//            if(snapshot.value != nil){
//                if(snapshot.value is NSNull){
//                    self.notes.removeAll()
//                }
//                else {
//                    
//                    let notesfromDB = snapshot.value! as! [String]
//                    self.notes.removeAll()
//                    for note in notesfromDB {
//                        self.notes.append(note)
//                    }
//                    self.tableView.reloadData()
//                }
//            }
//            else {
//                self.notes.removeAll()
//            }
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        self.notes.removeAtIndex(row)
        self.tableView.reloadData()
    }
    

}
