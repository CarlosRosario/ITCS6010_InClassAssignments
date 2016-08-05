//
//  ViewController.swift
//  InClass10
//
//  Created by Carlos Rosario on 8/4/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let rootRef = FIRDatabase.database().reference()
    
    var didSegueOccur = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        // Check if there is a currently signed in user
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in, lets go ahead and segue to the photos view controller
                if(!self.didSegueOccur){
                    let currentUserEmail = user.email
                    
                    self.rootRef.child("Users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                        
                        if(snapshot.value != nil){
                            if(snapshot.value is NSNull){
                                
                            }
                            else {
                                
                                let users = snapshot.value! as! [String: AnyObject]
                                for (key, value) in users {
                                    let valueArray = value as! [String: AnyObject]
                                    
                                    if let email = valueArray["email"] as? String {
                                        if currentUserEmail == email {
                                            let newUser = User()
                                            newUser.firebaseGeneratedId = key
                                            newUser.userName = valueArray["name"] as? String
                                            newUser.userEmail = email
                                            newUser.userPassword = valueArray["password"] as? String
                                            newUser.images = []
                                            var tempArray = valueArray["imageURLs"] as! [AnyObject]
                                            
                                            for item in tempArray{
                                                if item is NSNull{
                                                    //newUser.images?.append("")
                                                }
                                                else {
                                                    newUser.images?.append(String(item))
                                                }
                                            }
                                            AppDelegate.user = newUser
                                        }
                                    }
                                }
                            }
                        }
                        
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    
                    
                    self.didSegueOccur = true
                    self.performSegueWithIdentifier("showPhotosViewControllerSegue", sender: self)
                }
            }
        }
    }
    
    private func convertStringToNSURL(url: String) -> NSURL? {
        return NSURL(string: url)
    }
    
    @IBAction func signUpTouched(sender: UIButton) {
        let email : String = emailTextField.text!
        let password : String = passwordTextField.text!
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) -> Void in
            if(error == nil){
                print(user?.email)
                print(user?.uid)
                
                // Add a new user to firebase database
                var newUser = User()
                let userReference = self.rootRef.child("Users").childByAutoId()
                newUser.firebaseGeneratedId = userReference.key
                newUser.userName = self.nameTextField.text!
                newUser.userEmail = self.emailTextField.text!
                newUser.userPassword = self.passwordTextField.text!
                newUser.images = []
                AppDelegate.user = newUser
                
                print(userReference.key)
                let values = [
                        "name": (AppDelegate.user?.userName)!,
                        "email": (AppDelegate.user?.userEmail)!,
                        "password": (AppDelegate.user?.userPassword)!,
                        "imageURLs" : []
                    ] as [String: AnyObject]
                
                userReference.updateChildValues(values){
                    (error, reference) in
                    
                    if(error != nil){
                        print(error)
                        return
                    }
                }
                self.performSegueWithIdentifier("showPhotosViewControllerSegue", sender: self)
            }
            else if (error?.userInfo["error_name"])! as! String == "ERROR_EMAIL_ALREADY_IN_USE"{
                self.showMessage("Error creating account", message: "This email is already used")
                print(error?.localizedDescription)
            }
            else {
                self.showMessage("Error signing up", message: "There was an error signing you up. Please make sure all fields are populated and try again.")
            }
        }
    }
    
    @IBAction func loginTouched(sender: UIButton) {
        let email : String = emailTextField.text!
        let password : String = passwordTextField.text!
        
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) -> Void in
            
            if(error == nil){
                // User successfully signed in
                self.rootRef.child("Users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                    
                    if(snapshot.value != nil){
                        if(snapshot.value is NSNull){
                            
                        }
                        else {
                            
                            let users = snapshot.value! as! [String: AnyObject]
                            for (key, value) in users {
                                let valueArray = value as! [String: AnyObject]
                                
                                if let foundemail = valueArray["email"] as? String {
                                    if email == foundemail {
                                        let newUser = User()
                                        newUser.firebaseGeneratedId = key
                                        newUser.userName = valueArray["name"] as? String
                                        newUser.userEmail = email
                                        newUser.userPassword = valueArray["password"] as? String
                                        
                                        newUser.images = []
                                        var tempArray = valueArray["imageURLs"] as! [AnyObject]
                                        
                                        for item in tempArray{
                                            if item is NSNull{
                                                //newUser.images?.append("")
                                            }
                                            else {
                                                newUser.images?.append(String(item))
                                            }
                                        }
                                        
                                        
                                        
                                        
                                        
                        
                                        
                                        //newUser.images = valueArray["imageURLs"] as! [String]
                                        AppDelegate.user = newUser
                                    }
                                }
                            }
                        }
                    }
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
                
                self.performSegueWithIdentifier("showPhotosViewControllerSegue", sender: self)
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

}

