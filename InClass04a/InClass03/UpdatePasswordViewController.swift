//
//  UpdatePasswordViewController.swift
//  InClass03
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    
    var user: User! = nil
    weak var writeDataDelegate: writeValueBackDelegate?
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        passwordTextField.text = user.password
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func updateEmailAction(sender: UIButton) {
        
        if ((passwordTextField.text?.isEmpty) != nil){
            // don't do anything in this case - user did not enter anything for the name
            user.password = passwordTextField.text!
            writeDataDelegate?.writeValueBack("password", value: user.password)
        }
        self.dismissViewControllerAnimated(true, completion:{})
        
    }
}
