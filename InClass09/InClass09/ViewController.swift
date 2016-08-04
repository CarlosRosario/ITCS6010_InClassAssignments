//
//  ViewController.swift
//  InClass09
//
//  Created by Carlos Rosario on 8/5/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userEmail : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if(!AppDelegate.easyLogin){
            AppDelegate.easyLogin = true
            // Check if there is a currently signed in user
            FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                
                if let user = user {
                    // User is signed in
                    self.userEmail = user.email!
                    self.performSegueWithIdentifier("showNoteBooksViewControllerSegue", sender: self)
                } else {
                    // don't do anything stay on the login page
                }
                
            }
        //}
    }
    
    
    @IBAction func loginTouched(sender: UIButton) {
        let email : String = emailTextField.text!
        let password : String = passwordTextField.text!
        
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) -> Void in
            
            if(error == nil){
                // User successfully signed in
                self.userEmail = user!.email!
                self.performSegueWithIdentifier("showNoteBooksViewControllerSegue", sender: self)
                print(user?.email)
                print(user?.uid)
                
            }
            else {
                // Could not sign User in
                print(error?.localizedDescription)
                self.showMessage("Login failed", message: "Could not login this user. Please try again")
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if(!AppDelegate.easyLogin){
            AppDelegate.easyLogin = true
            if segue.identifier == "showNoteBooksViewControllerSegue" {
                let destinationvc = segue.destinationViewController.contentViewController
                if let notesbooksvc = destinationvc as? NoteBooksTableViewController{
                    notesbooksvc.user = userEmail
                }
            }
        //}
        
    }
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }
        else {
            return self
        }
    }
}

