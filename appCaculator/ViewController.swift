//
//  ViewController.swift
//  appCaculator
//
//  Created by Lei on 4/13/16.
//  Copyright © 2016 Lei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var brain = Brain()
    
    @IBOutlet weak var display: UILabel!
    
    var userIsMiddleOfTyping = false
    
    var hasNoSign = true
    
    var hasDot = false
    
    var alreadyGetResult = false
    
    var buttonPushAlready = false
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsMiddleOfTyping {
            display.text = display.text! + digit
        } else {
            if !buttonPushAlready {
                allclear.setTitle("C", forState: .Normal)
                buttonPushAlready = true
            }
            if !hasNoSign {
                display.text = "-" + digit
                userIsMiddleOfTyping = true
            }else{
            display.text = digit
            userIsMiddleOfTyping = true
            }
        }

    }
    
    var displayValue:Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            if newValue % 1 == 0 {
            display.text = "\(Int(newValue))"
            } else {
            display.text = "\(newValue)"
            }
        }
    }

    @IBAction func operation(sender: UIButton) {
        if !alreadyGetResult{
            pushDigit()
        }
        if let result = brain.getResult(){
            displayValue = result
            pushDigit()
        }
        brain.evalutionList.append(sender.currentTitle!)
    }

    @IBAction func unaryOperation(sender: UIButton) {
        pushDigit()
        if let result = brain.binaryEvaluation(sender.currentTitle!) {
            displayValue = result
        }
    }
    @IBAction func getResult() {
        pushDigit()
        if let result = brain.getResult(){
            displayValue = result
            pushDigit()
            alreadyGetResult = true
        }
    }
    
    @IBAction func addSign() {
        if hasNoSign {
            display.text = "−" + display.text!
            hasNoSign = false
        } else {
            display.text = String(display.text!.characters.dropFirst())
            hasNoSign = true
        }
    }
    func pushDigit(){
        brain.pushOperand(displayValue)
        userIsMiddleOfTyping = false
        hasNoSign = true
        hasDot = false
    }
    @IBOutlet weak var allclear: UIButton!
    
    @IBAction func allClear(sender: UIButton) {
        userIsMiddleOfTyping = false
        brain.operandStack.removeAll()
        display.text = "0"
        hasNoSign = true
        brain.evalutionList.removeAll()
        alreadyGetResult = false
        sender.setTitle("AC", forState: .Normal)
        buttonPushAlready = false
    }
    
    
    @IBAction func addDot() {
        if userIsMiddleOfTyping {
            if !hasDot{
                display.text = display.text! + "."
                hasDot = true
            }
        }
    }
}

