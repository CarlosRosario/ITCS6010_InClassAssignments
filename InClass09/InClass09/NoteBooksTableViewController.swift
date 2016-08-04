//
//  NoteBooksTableViewController.swift
//  InClass09
//
//  Created by Carlos Rosario on 8/2/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class NoteBooksTableViewController: UITableViewController {

    @IBOutlet var newWordField: UITextField?
    
    let rootRef = FIRDatabase.database().reference()
    
    var notebooks = [String]()
    var selectedRow = -1
    
    var user: String! {
        didSet{
            print("From NoteBooksTableviewController: " + user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        var userString = user.stringByReplacingOccurrencesOfString("@", withString: "-")
        userString = userString.stringByReplacingOccurrencesOfString(".", withString: "-")
        
        rootRef.child(userString).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if(snapshot.value != nil){
                if(snapshot.value is NSNull){
                    
                }
                else {
                    
                    let notebooknames = snapshot.value! as! [String]
                    self.notebooks.removeAll()
                    for notebook in notebooknames {
                        self.notebooks.append(notebook)
                    }
                    self.tableView.reloadData()
                }
            }
 
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if notebooks.isEmpty {
            return 0
        }
        else {
            return notebooks.count
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        print(selectedRow)
        performSegueWithIdentifier("showNotesViewSegue", sender: self)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notebookcell", forIndexPath: indexPath)
        
        let tempArray = notebooks[indexPath.row].componentsSeparatedByString("~~~")
        
        cell.textLabel?.text = tempArray[0]
        
        if tempArray.count > 1 {
                cell.detailTextLabel?.text = tempArray[1]
        }
        
        return cell
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showNotesViewSegue" {
            let destinationvc = segue.destinationViewController.contentViewController
            if let notesvc = destinationvc as? ShowNotesTableViewController{
                notesvc.user = user
                notesvc.notebookname = notebooks[selectedRow]
            }
        }
    }
    
    // add new notebook
    func newNoteBookEntered(alert: UIAlertAction!){
      // get new notebook name and print it (for now)
        var newNoteBookName = self.newWordField?.text
        newNoteBookName = newNoteBookName! + "~~~" + String(NSDate())
        print(newNoteBookName)
        
        
        // Enter new notebook name into firebase
        var userString = user.stringByReplacingOccurrencesOfString("@", withString: "-")
        userString = userString.stringByReplacingOccurrencesOfString(".", withString: "-")
        notebooks.append(newNoteBookName!)
        let userRef = rootRef.child(userString).setValue(notebooks)
        self.tableView.reloadData()
    }
    
    
    func addTextField(textField: UITextField){
        textField.placeholder = "New Notebook"
        self.newWordField = textField
    }
    
    @IBAction func addTouched(sender: UIBarButtonItem) {
        let refreshAlert = UIAlertController(title: "New Notebook", message: "Enter New Notebook Name", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addTextFieldWithConfigurationHandler(addTextField)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: newNoteBookEntered))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func logoutTouched(sender: UIBarButtonItem) {
        try! FIRAuth.auth()!.signOut()
        self.dismissViewControllerAnimated(true) { 
//            self.performSegueWithIdentifier("goBackToLoginSegue", sender: self)
        }
    }
    
    
    
    
    
    
    
    

}
