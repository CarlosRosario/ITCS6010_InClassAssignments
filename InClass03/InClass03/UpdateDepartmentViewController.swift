//
//  UpdateDepartmentViewController.swift
//  InClass03
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class UpdateDepartmentViewController: UIViewController {
    
    var user: User! = nil
    var department: String! = nil
    @IBOutlet weak var departmentSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        switch user.department{
            case "CS":
            departmentSegmentedControl.selectedSegmentIndex = 0
            case "SIS":
            departmentSegmentedControl.selectedSegmentIndex = 1
            case "BIO":
            departmentSegmentedControl.selectedSegmentIndex = 2
        default: break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func departmentSelected(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            // CS
            department = "CS"
        case 1:
            //SIS
            department = "SIS"
            
        case 2:
            //BIO
            department = "BIO"
        default: break
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (!department.isEmpty){
            user.department = department
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
                case "DepartmentUnwindSegue":
                    profilevc.user = user
                default: break
                }
            }
        }
    }

}
