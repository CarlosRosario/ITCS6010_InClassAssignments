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
    weak var writeDataDelegate: writeValueBackDelegate?
    
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
    
    @IBAction func updateDepartment(sender: UIButton) {
        if (!department.isEmpty){
            user.department = department
            writeDataDelegate?.writeValueBack("department", value: user.department)
        }
        self.dismissViewControllerAnimated(true, completion: {})
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
}
