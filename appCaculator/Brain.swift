//
//  Brain.swift
//  appCaculator
//
//  Created by Lei on 4/13/16.
//  Copyright © 2016 Lei. All rights reserved.
//

import Foundation

class Brain {
    
    var operandStack = [Double]()
    
    func pushOperand(operand: Double) {
        operandStack.append(operand)
    }
    
    var evalutionList = [String]()
    
    func binaryEvaluation(symbol: String) -> Double? {
        if !operandStack.isEmpty {
            let operand = operandStack.removeLast()
            switch symbol {
                case "%":
                return operand * 0.01
            default: break
            }
        }
        return nil
    }


    
    func getResult() -> Double? {
        if operandStack.count >= 2 {
            let operand1 = operandStack.removeLast()
            let operand2 = operandStack.removeLast()
            let currentEvluation = evalutionList.removeLast()
            switch currentEvluation {
            case "+":
                return operand1 + operand2
            case "−":
                return operand2 - operand1
            case "×":
                return operand1 * operand2
            case "÷":
                return operand2 / operand1
            default:
                break
            }
          
        }
        return nil
    }
    
}
