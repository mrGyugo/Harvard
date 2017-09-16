//
//  ViewController.swift
//  Calculator
//
//  Created by Mac_Work on 18.08.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var allButtons: [UIButton]!
    
    override func loadView() {
        super.loadView()
        
        for button in allButtons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    
    @IBOutlet weak var display: UILabel! {
        didSet {
            if let x = display?.text {
                print(x)
            }
        }
    }
    @IBOutlet weak var displayHistory: UILabel!
    
    var userIsInTheMiddleOfTyping: Bool = false
    
    private var brain = CalculatorBrain()


    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            
            if digit != "." || !(display.text?.contains("."))! {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + digit
            }
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        if display.text! == "." {
            display.text = "0."
        }
        
    }
    
    @IBAction func operand(_ sender: UIButton) {
        
    }

    
    
    @IBAction func allClear(_ sender: Any) {
        userIsInTheMiddleOfTyping = false
        display.text = "0"
        displayHistory.text = ""
        brain.allClear()
    }

    @IBAction func perfomOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
           brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result.accumulator {
            displayValue = result
        }
        
        if let historyResult = brain.result.description {
            displayHistory.text = historyResult
        }
        
    }
    

    @IBAction func deleteDigit(_ sender: UIButton) {
        if display.text!.characters.count >= 2 {
            display.text = display.text?.substring(to: display.text!.index(before: display.text!.endIndex))
        } else {
            display.text = "0"
            userIsInTheMiddleOfTyping = false
        }
        
    }

    var displayValue: Double {
        set {
            display.text! = changeString(String(newValue))
        }
        get {
            return Double(display.text!)!
        }
    }
    
    @IBAction func actionRendom(_ sender: UIButton) {
        display.text = String(brain.randomNumber)
        userIsInTheMiddleOfTyping = true
    }
    
    private func changeString (_ stringNumber: String) -> String {
        if let tempNumber = Double(stringNumber) {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 4
            return formatter.string(from: NSNumber(value: tempNumber))!
        }
        return stringNumber
    }
    
}

