//
//  ViewController.swift
//  InClass02a
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
    
    
    @IBAction func performOperation(sender: UIButton) {
        
        let operation = sender.currentTitle!
        if let op1 = Double(firstOperand.text!){
            if let op2 = Double(secondOperand.text!) {
                switch(operation){
                    
                case "Add":
                    displayValue = op1 + op2
                    
                case "Subtract":
                    displayValue = op1 - op2
                    
                case "Multiply":
                    displayValue = op1 * op2
                    
                case "Divide":
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
    
    @IBAction func clearFields(sender: UIButton) {
        
        firstOperand.text = ""
        secondOperand.text = ""
        display.text = "Result : 0.00"
        
    }
    
    
    
}

