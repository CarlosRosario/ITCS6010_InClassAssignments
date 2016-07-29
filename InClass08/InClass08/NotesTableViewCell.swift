//
//  NotesTableViewCell.swift
//  InClass08
//
//  Created by Carlos Rosario on 7/28/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewCell: UITableViewCell {

    var managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    weak var refreshUserTableViewDelegate: refreshUsersDelegate?
    
    var user: User?
    var myUserNote: UserNote?
    
    var data : (note: String, date: String)? {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func deleteNote(sender: UIButton) {
        let usernotes = self.user?.mutableSetValueForKey("userNotes")
        usernotes?.removeObject(myUserNote!)
        
        
        //managedObjectContext?.deleteObject(myUserNote!)
        do {
            try managedObjectContext!.save()
        }
        catch let error {
            print(error)
        }
        refreshUserTableViewDelegate?.refresh()
    }
    
    private func updateUI(){
        // reset any existing information
        dateLabel?.text = nil
        notesLabel?.text = nil
        
        notesLabel?.text = data?.note
        dateLabel?.text = data?.date
        
        notesLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        notesLabel.numberOfLines = 0
    }
}
