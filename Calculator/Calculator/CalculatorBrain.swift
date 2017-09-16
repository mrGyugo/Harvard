//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mac_Work on 22.08.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    

    private var resultIsPending: Bool = false
    private var mainTuple: (accumulator: Double?, description: String?)
    
    var randomNumber: Double {
        get {
            let number = arc4random() % 100
            let result = Double(number) / 100
            return result
        }
    }
    
    //Установить оперант
    mutating func setOperand(_ operand: Double) {
        mainTuple = (operand, String(operand))
    }
    
    
    
    func   setOperand (variable named: String) {
        
        
        
    }
    
    
    //Enum
    private enum OperationType {
        case constant (Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    //Доп структура для бинарных операций
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        let tempDescription: String
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    //Доп функция для бинарной операции
    private mutating func performPendingBinaryOperation () {
        if pendingBinaryOperation != nil && mainTuple.accumulator != nil {
            mainTuple = (pendingBinaryOperation!.perform(with: mainTuple.accumulator!), pendingBinaryOperation!.tempDescription + mainTuple.description!)
            pendingBinaryOperation = nil
            resultIsPending = false
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    //База оперантов
    private var operations: Dictionary<String, OperationType> =
        [
            //Condtants
            
            "π"     :   OperationType.constant(Double.pi),
            "e"     :   OperationType.constant(M_E),
            
            //UnaryOperations
            
            "√"     :   OperationType.unaryOperation(sqrt),
            "cos"   :   OperationType.unaryOperation(cos),
            "sin"   :   OperationType.unaryOperation(sin),
            "±"     :   OperationType.unaryOperation({-$0}),
            "%"     :   OperationType.unaryOperation({$0 * 0.01}),
            "ln"    :   OperationType.unaryOperation(log),
            "x!"    :   OperationType.unaryOperation({
                guard Int($0) != 0 else { return 0}
                return Double((1...Int($0)).reduce(1, *))}),
            
            //BinaryOperations
            
            "x" : OperationType.binaryOperation({$0 * $1}),
            "÷" : OperationType.binaryOperation({$0 / $1}),
            "+" : OperationType.binaryOperation({$0 + $1}),
            "-" : OperationType.binaryOperation({$0 - $1}),
            "=" : OperationType.equals
    ]
    
    //Выполнить операцию
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value): mainTuple = (value, symbol)
   
            case .unaryOperation(let function):
                if mainTuple.accumulator != nil { mainTuple = (function(mainTuple.accumulator!), symbol + "(\(mainTuple.description!))")}
                
            case .binaryOperation(let function):
                performPendingBinaryOperation()
                if mainTuple.accumulator != nil {
                    resultIsPending = true
                    mainTuple.description! += " \(symbol) "
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: mainTuple.accumulator!, tempDescription: mainTuple.description!)
                    mainTuple.accumulator = nil
                }
                
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    mutating func allClear () {
        mainTuple.accumulator = nil
        mainTuple.description = nil
        pendingBinaryOperation = nil
    }
    
    //Result
    var result: (accumulator:Double? , description: String?) {
        get {
            if mainTuple.description != nil && resultIsPending {
                return (mainTuple.accumulator, "\(mainTuple.description ?? "") ...")
            } else {
                return (mainTuple.accumulator, "\(mainTuple.description ?? "") =")
            }
        }
    }
}









