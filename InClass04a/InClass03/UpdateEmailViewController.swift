//
//  UpdateEmailViewController.swift
//  InClass03
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class UpdateEmailViewController: UIViewController {

    var user: User! = nil
    
    weak var writeDataDelegate: writeValueBackDelegate?

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailTextField.text = user.email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateEmail(sender: UIButton) {
        
        if ((emailTextField.text?.isEmpty) != nil){
            // don't do anything in this case - user did not enter anything for the name
            user.email = emailTextField.text!
            writeDataDelegate?.writeValueBack("email", value: user.email)
        }
        self.dismissViewControllerAnimated(true) {}
    }
}
