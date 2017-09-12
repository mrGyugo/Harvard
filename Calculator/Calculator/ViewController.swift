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
    
    
    @IBOutlet weak var display: UILabel!
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

    var displayValue: Double {
        set {
            display.text! = String(newValue)
        }
        get {
            return Double(display.text!)!
        }
    }
    



}

