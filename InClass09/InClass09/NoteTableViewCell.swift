//
//  NoteTableViewCell.swift
//  InClass09
//
//  Created by Carlos Rosario on 8/2/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class NoteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var noteText: UILabel!
    @IBOutlet weak var createdText: UILabel!
    weak var refreshUserTableViewDelegate: refreshUsersDelegate?
    
    let rootRef = FIRDatabase.database().reference()
    
    var data: (note: String, date: String, dbkey: String, row: String)? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        // reset any existing information
        noteText?.text = nil
        createdText?.text = nil
        noteText?.text = data?.note
        createdText?.text = data?.date
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func deleteNote(sender: UIButton) {
        rootRef.child((data?.dbkey)!).child((data?.row)!).removeValue()
        self.refreshUserTableViewDelegate!.refresh(Int((data?.row)!)!)
    }
    
}
