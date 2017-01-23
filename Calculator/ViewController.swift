//
//  ViewController.swift
//  Calculator
//
//  Created by Wenzhong Zheng on 2017-01-16.
//  Description This is a Simple Calculator App
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Percent = "%"
        case Empty = "empty"
        case Pi = "pi"
        case Sqrt = "sqrt"
        case Power = "power"
        case Factorial = "factorial"
        case Mod = "mod"
    }
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    //whole process: leftVal operator rightVal
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Display values when number button pressed
    @IBAction func numberPressed(_ sender: UIButton){
        runningNumber += "\(sender.tag)"
        
        updateText(updateNum: runningNumber)
    }
    //Formating passing values
    func updateText(updateNum: String) {
        guard let number:Double = Double(updateNum) else {
            return
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.maximumFractionDigits = 9
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: number)
        
        outputLbl.text = formatter.string(from: num)
    }
    //proceed when reset button clicked
    @IBAction func clearDidTouch(_ sender: UIButton) {
        runningNumber = ""
        currentOperation = Operation.Empty
        leftValString = ""
        rightValString = ""
        result = ""
        outputLbl.text = "0"
    }
    //proceed when dot button clicked
    @IBAction func dotDidTouch(_ sender: UIButton) {
        if (!(outputLbl.text?.contains("."))!){
            runningNumber = (outputLbl.text?.appending("."))!
            outputLbl.text = runningNumber
        }
    }
    //proceed when +/- sign button clicked
    @IBAction func signButtonDidTouch(_ sender: UIButton) {
        if (!(outputLbl.text?.contains("-"))!){
            runningNumber = "-\(outputLbl.text!)"
        }
        else {
            let index = outputLbl.text!.index(outputLbl.text!.startIndex, offsetBy: 1)
            runningNumber = outputLbl.text!.substring(from: index)
        }
        outputLbl.text = runningNumber
    }
    
    //call processOperation function when one operator pressed
    @IBAction func operatorPressed(_ sender: UIButton){
        if sender.currentTitle == "+" {
            processOperation(operation: .Add)
        } else if sender.currentTitle == "-" {
            processOperation(operation: .Subtract)
        } else if sender.currentTitle == "X" {
            processOperation(operation: .Multiply)
        } else if sender.currentTitle == "/" {
            processOperation(operation: .Divide)
        } else if sender.currentTitle == "=" {
            processOperation(operation: currentOperation)
        } else if sender.currentTitle == "%" {
            processOperation(operation: .Percent)
        }
    }
    
    //process calculation logics and update value to the output label
    func processOperation(operation: Operation){
        if currentOperation != Operation.Empty{
            
            //A user selected an operator, but then selected another one without first entering a number
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                updateText(updateNum: result)
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
        //percent sign pressed
        if operation == Operation.Percent {
            result = "\(Double(leftValString)! / 100)"
            leftValString = result
            updateText(updateNum: result)
        }
    }


}

