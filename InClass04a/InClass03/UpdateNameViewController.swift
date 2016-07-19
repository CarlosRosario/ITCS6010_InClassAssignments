//
//  UpdateNameViewController.swift
//  InClass03
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class UpdateNameViewController: UIViewController {

    var user: User! = nil
    
    weak var writeDataDelegate: writeValueBackDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.text = user.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateName(sender: UIButton) {
        
        if ((nameTextField.text?.isEmpty) != nil){
            // don't do anything in this case - user did not enter anything for the name
            user.name = nameTextField.text!
            writeDataDelegate?.writeValueBack("name", value: user.name)
        }
        self.dismissViewControllerAnimated(true, completion:{})
    }
}
