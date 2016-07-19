//
//  ProfileViewController.swift
//  InClass03
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, writeValueBackDelegate {

    var user : User! = nil
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var passwordTextField: UILabel!
    @IBOutlet weak var departmentTextField: UILabel!
    @IBOutlet weak var togglePasswordButton: UIButton!
    
    var asterisks = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Lets go ahead and populate the UI from the passed User object
        nameTextField.text = user.name
        emailTextField.text = user.email
        
        for _ in 1...user.password.characters.count {
            asterisks += "*"
        }
        
        passwordTextField.text = asterisks
        departmentTextField.text = user.department
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var isPasswordShowing = false
    @IBAction func togglePassword(sender: UIButton) {
        
        if(isPasswordShowing == true){
            // switch back to asterisks
            passwordTextField.text = asterisks
            togglePasswordButton.setTitle("Show", forState: .Normal)
            isPasswordShowing = false
        }
        else {
            // switch back to plaintext
            passwordTextField.text = user.password
            togglePasswordButton.setTitle("Hide", forState: .Normal)
            isPasswordShowing = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc = segue.destinationViewController
        
        if let updatenamevc = destinationvc as? UpdateNameViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "GoToUpdateNameSegue":
                    updatenamevc.user = user
                    updatenamevc.writeDataDelegate = self
                default: break
                }
            }
        }
        if let updateemailvc = destinationvc as? UpdateEmailViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "GoToUpdateEmail":
                    updateemailvc.user = user
                    updateemailvc.writeDataDelegate = self
                default: break
                }
            }
        }
        
        if let updatepasswordvc = destinationvc as? UpdatePasswordViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "GoToUpdatePasswordSegue":
                    updatepasswordvc.user = user
                    updatepasswordvc.writeDataDelegate = self
                default: break
                }
            }
        }
        
        if let updatedepartmentvc = destinationvc as? UpdateDepartmentViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "GoToUpdateDepartmentSegue":
                    updatedepartmentvc.user = user
                    updatedepartmentvc.writeDataDelegate = self
                default: break
                }
            }
        }
    }
    
    
    func writeValueBack(parameterUpdated: String, value: String){
        switch(parameterUpdated){
            case "name":
            nameTextField.text = value
            case "email":
            emailTextField.text = value
            case "password":
            passwordTextField.text = value
            asterisks = ""
            for _ in 1...user.password.characters.count {
                asterisks += "*"
            }
            
            togglePasswordButton.setTitle("Hide", forState: .Normal)
            isPasswordShowing = true
            case "department":
            departmentTextField.text = value

        default: break
        }
    }
}
