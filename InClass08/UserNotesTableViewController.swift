//
//  UserNotesTableViewController.swift
//  InClass08
//
//  Created by Carlos Rosario on 7/28/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import CoreData

class UserNotesTableViewController: UITableViewController, refreshUsersDelegate {
    
    var SortedUserNotes = [UserNote]()
    
    var managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    var user: User?
    var userNote = [UserNote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = (user?.name)! + " Notes"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let usernotes = self.user?.mutableSetValueForKey("userNotes") {
            if usernotes.count == 0 {
                return 0
            }
            else {
                return usernotes.count
            }
        }
        else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notesCell", forIndexPath: indexPath) as? NotesTableViewCell
            let singleUserNote = SortedUserNotes[indexPath.row] //self.user?.mutableSetValueForKey("userNotes")
//            let singleUserNote = usernotes?.allObjects[indexPath.row] as? UserNote
//            let singleUserNote = usernotes.allObjects[indexPath.row] as? UserNote
            var cellData  = (note: "", date: "")
            cellData.note = (singleUserNote.notetext)!
            
        
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
//            print("Created on " + dateFormatter.stringFromDate(singleUserNote?.created)
            cellData.date = "Created on " + dateFormatter.stringFromDate((singleUserNote.created)!)
            cell!.data = cellData
            cell!.refreshUserTableViewDelegate = self
            cell!.user = user
            cell!.myUserNote = singleUserNote
        
            return cell!
    }
    
    func refresh() {
        SortedUserNotes.removeAll()
        if let usernotes = self.user?.mutableSetValueForKey("userNotes") {
            for singleNote in usernotes {
                SortedUserNotes.append(singleNote as! UserNote)
            }
        }
        SortedUserNotes.sortInPlace({ $0.created!.compare($1.created!) == NSComparisonResult.OrderedDescending })
        
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAddNewNote" {
            if let addNoteVC = segue.destinationViewController.contentViewController as? AddNewNoteViewController {
                addNoteVC.user = user
                addNoteVC.refreshUserTableViewDelegate = self
            }
        }
    }
    
}
