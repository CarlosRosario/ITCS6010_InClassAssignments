//
//  HomeViewController.swift
//  InClass03
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var department = "SIS" // default to SIS
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "GoToProfileSegue"{
            
            
            // Check name field
            if !(nameTextField.text?.isEmpty)!{
                user.name = nameTextField.text!
            }
            else {
                showAlert("Please enter your name")
                return false
            }
            
            // Check email field
            if !(emailTextField.text?.isEmpty)!{
                user.email = emailTextField.text!
            }
            else {
                showAlert("Please enter your email address")
                return false
            }
            
            // Check password field
            if !(passwordTextField.text?.isEmpty)!{
                user.password = passwordTextField.text!
            }
            else {
                showAlert("Please enter a password")
                return false
            }
            
            user.department = department
            return true
            
            
        }
        else {
            return false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc = segue.destinationViewController
        if let profilevc = destinationvc as? ProfileViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "GoToProfileSegue":
                    profilevc.user = user
                default: break
                }
            }
        }
    }
    
    func showAlert(message: String){
        // Create the AlertController
        let alertController = UIAlertController(title: "Error Submitting", message: message, preferredStyle: .Alert)  // .ActionSheet
        
        // Create the action
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        // Add action to the AlertController
        alertController.addAction(defaultAction)
        
        // Show the alert
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func departmentSelected(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            // CS
            department = "CS"
            
        case 1:
            // SIS
            department = "SIS"
            
        case 2:
            //BIO
            department = "BIO"
        default: break
        }
        
    }
}
