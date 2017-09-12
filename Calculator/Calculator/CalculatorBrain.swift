//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mac_Work on 22.08.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    private var resultIsPending: Bool
    private var description: String?
    
    //Установить оперант
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
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
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    //Доп функция для бинарной операции
    private mutating func performPendingBinaryOperation () {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
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
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    resultIsPending = true
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                resultIsPending = true
                performPendingBinaryOperation()
            }
        }
    }
    
    //Result
    var result: Double? {
        get {
            return accumulator;
        }
    }
}









