//
//  CountOnMeBrain.swift
//  CountOnMe
//
//  Created by Christophe DURAND on 09/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import UIKit

protocol CountOnMeDelegate {
    func alertShow(title: String, message: String)
    func updateTextView(label: String)
}

class CountOnMeBrain {
    
    //MARK: - Properties
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    var countOnMeDelegate: CountOnMeDelegate?
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    countOnMeDelegate?.alertShow(title: "Zero!", message: "Start a new calculation!")
                } else {
                    countOnMeDelegate?.alertShow(title: "Zero!", message: "Type a correct expression!")
                }
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                countOnMeDelegate?.alertShow(title: "Zero!", message: "Wrong expression!")
                return false
            }
        }
        return true
    }
    
    //MARK: - Methods
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }
    
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        orderOfOperations()
        var total = Double()
        for (index, stringNumber) in stringNumbers.enumerated() {
            guard let number = Double(stringNumber) else { return }
            switch operators[index] {
            case "+":
                total += number
            case "-":
                total -= number
            default:
                break
            }
        }
        countOnMeDelegate?.updateTextView(label: "\(total)")
        clear()
    }
    
    func orderOfOperations() {
        for (index, calculateOperator) in operators.enumerated().reversed() where calculateOperator == "x" || calculateOperator == "÷" {
            var operation: ((Double, Double)-> Double)?
            if calculateOperator == "x" {
                operation = (*)
            } else if calculateOperator == "÷" && stringNumbers[index] != "0"{
                operation = (/)
            } else {
                countOnMeDelegate?.alertShow(title: "Error!", message: "Dividing by 0 doesn't exist!")
                clear()
            }
            guard let operand = operation else { return }
            guard let firstNumber = Double(stringNumbers[index - 1]) else { return }
            guard let secondNumber = Double(stringNumbers[index]) else { return }
            let total = operand(firstNumber, secondNumber)
            let totalString = String(format: "%.2f", total)
            stringNumbers[index - 1] = String(totalString)
            stringNumbers.remove(at: index)
            operators.remove(at: index)
        }
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
    
    func divide() {
        if canAddOperator {
            operators.append("÷")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func multiply() {
        if canAddOperator {
            operators.append("x")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func minus() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func plus() {
        if canAddOperator {
            operators.append("+")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func updateDisplay() {
        var text = ""
        for (index, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index]
            }
            // Add number
            text += stringNumber
        }
        countOnMeDelegate?.updateTextView(label: text)
    }
}





