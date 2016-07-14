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
    
    
    @IBAction func updateEmail(sender: UIButton) {
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if ((passwordTextField.text?.isEmpty) != nil){
            // don't do anything in this case - user did not enter anything for the name
            user.password = passwordTextField.text!
            return true
        }
        else {
            //            user.name = nameTextField.text!
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc = segue.destinationViewController
        if let profilevc = destinationvc as? ProfileViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "PasswordUnwindSegue":
                    profilevc.user = user
                default: break
                }
            }
        }
    }
    
}
