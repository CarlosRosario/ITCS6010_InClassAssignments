//
//  ProfileViewController.swift
//  InClass03
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

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
                default: break
                }
            }
        }
        if let updateemailvc = destinationvc as? UpdateEmailViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "GoToUpdateEmail":
                    updateemailvc.user = user
                default: break
                }
            }
        }
        
        if let updatepasswordvc = destinationvc as? UpdatePasswordViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "GoToUpdatePasswordSegue":
                    updatepasswordvc.user = user
                default: break
                }
            }
        }
        
        if let updatedepartmentvc = destinationvc as? UpdateDepartmentViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "GoToUpdateDepartmentSegue":
                    updatedepartmentvc.user = user
                default: break
                }
            }
        }
    }
    
    @IBAction func unwindToProfileVC(segue: UIStoryboardSegue){
        
        if let identifier = segue.identifier{
            switch identifier{
                case "NameUnwindSegue":
                nameTextField.text = user.name
                case "EmailUnwindSegue":
                emailTextField.text = user.email
                case "PasswordUnwindSegue":
                passwordTextField.text = user.password
                
                asterisks = ""
                for _ in 1...user.password.characters.count {
                    asterisks += "*"
                }
                
                togglePasswordButton.setTitle("Hide", forState: .Normal)
                isPasswordShowing = true


                
                
                case "DepartmentUnwindSegue":
                departmentTextField.text = user.department
            default: break
            }
        }
    }
}
