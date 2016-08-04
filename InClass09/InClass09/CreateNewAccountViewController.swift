//
//  CreateNewAccountViewController.swift
//  InClass09
//
//  Created by Carlos Rosario on 8/2/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class CreateNewAccountViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func cancelTouched(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    
    @IBAction func submitTouched(sender: UIButton) {
        
        // Lets check that the password and confirm password fields are the same. Also check that the password is more than 6 characters
        
        let password: String = passwordTextField.text!
        let confirmPassword: String = confirmPasswordTextField.text!
        
        if password == confirmPassword && password.characters.count > 6{
            let email : String = emailTextField.text!
            let password : String = passwordTextField.text!
            
            FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) -> Void in
                if(error == nil){
                    print(user?.email)
                    print(user?.uid)
                    self.performSegueWithIdentifier("showNoteBooksViewControllerSegue", sender: self)
                }
                else if (error?.userInfo["error_name"])! as! String == "ERROR_EMAIL_ALREADY_IN_USE"{
                    self.showMessage("Error creating account", message: "This email is already used")
                    print(error?.localizedDescription)
                }
            }

        }
    }
    
    private func showMessage(title: String, message: String){
        // Create the AlertController
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)  // .ActionSheet
        
        // Create the action
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        // Add action to the AlertController
        alertController.addAction(defaultAction)
        
        // Show the alert
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNoteBooksViewControllerSegue" {
            let destinationvc = segue.destinationViewController.contentViewController
            if let notesbooksvc = destinationvc as? NoteBooksTableViewController{
                notesbooksvc.user = emailTextField.text
            }
        }

    }

}
