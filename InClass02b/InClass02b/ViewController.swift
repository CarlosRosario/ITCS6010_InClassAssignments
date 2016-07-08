//
//  ViewController.swift
//  InClass02b
//
//  Created by Carlos Rosario on 7/7/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var firstOperand: UITextField!
    @IBOutlet weak var secondOperand: UITextField!
    @IBOutlet weak var display: UILabel!
    
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = "Result : " + String(newValue)
        }
    }
    
    var currentlyChosenOperation = "add" // add by default
    @IBAction func operationSelected(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            // Addition
            currentlyChosenOperation = "add"
        case 1:
            // Subtraction
            currentlyChosenOperation = "subtract"
        case 2:
            // Multiply
            currentlyChosenOperation = "multiply"
        case 3:
            // Division
            currentlyChosenOperation = "division"
        default: break
        }
        
    }
    @IBAction func clearAll(sender: UIButton) {
        firstOperand.text = ""
        secondOperand.text = ""
        display.text = "Result : 0.00"
    }
    
    
    @IBAction func performOperation(sender: UIButton) {
        
        if let op1 = Double(firstOperand.text!){
            if let op2 = Double(secondOperand.text!) {
                switch(currentlyChosenOperation){
                    
                case "add":
                    displayValue = op1 + op2
                    
                case "subtract":
                    displayValue = op1 - op2
                    
                case "multiply":
                    displayValue = op1 * op2
                    
                case "division":
                    if(op2 == 0){
                        let alert = UIAlertController(title: "Error", message: "Cannot divide by zero!", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else {
                        displayValue = op1 / op2
                    }
                    
                    
                default: break
                }
            }
            else {
                // issue with second operand
                displayErrorMessage("second")
            }
        }
        else {
            // issue with first operand
            displayErrorMessage("first")
        }
    }
    
    func displayErrorMessage(operand: String){
        let alert = UIAlertController(title: "Error", message: "Please input a number for " + operand +  " operand", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

