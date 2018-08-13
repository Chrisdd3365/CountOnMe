//
//  CountOnMeBrain.swift
//  CountOnMe
//
//  Created by Christophe DURAND on 09/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import UIKit

//Using protocol to delegate alerts and update the display(textView)
protocol CountOnMeDelegate {
    func alertShow(title: String, message: String)
    func updateTextView(label: String)
}

class CountOnMeBrain {
    
    //MARK: - Properties
    //Array of numbers
    var stringNumbers: [String] = [String()]
    //Array of operators
    var operators: [String] = ["+"]
    var index = 0
    //Var that holds the delegate
    var countOnMeDelegate: CountOnMeDelegate?
    //Var checking if the expression is correctly typed by the user, else it will alert the user
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
    //Var checking if a string of numbers contains something, else it will alert the user to type a string of numbers first and then the user can add an operator
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
    //Method managing numbers when user types them
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }
    //Method managing operations (+, -)
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        orderOfOperations()
        var total = Double()
        for (index, stringNumber) in stringNumbers.enumerated() {
            guard let number = Double(stringNumber) else { return }
            if operators[index] == "+" {
                total += number
            } else if operators[index] == "-" {
                total -= number
            }
        }
        let result = String(format: "%.2f", total)
        countOnMeDelegate?.updateTextView(label: result)
        clear()
    }
    //Method managing order of operations and managing operations (*, /)
    func orderOfOperations() {
        let priorityOperators = ["x", "÷"]
        var result: Double = 0
        var i = 0
        while i < stringNumbers.count - 1 {
            if var firstOperand = Double(stringNumbers[i]) {
                while priorityOperators.contains(operators[i + 1]) {
                    if let secondOperand = Double(stringNumbers[i + 1]) {
                        if operators[i + 1] == "x" {
                            result = firstOperand * secondOperand
                        } else if operators[i + 1] == "÷" {
                            result = firstOperand / secondOperand
                        }
                        stringNumbers[i] = String(result)
                        firstOperand = result
                        stringNumbers.remove(at: i + 1)
                        operators.remove(at: i + 1)
                        if i == stringNumbers.count - 1 {
                            return
                        }
                    }
                }
                i += 1
            }
        }
    }
    //Method managing reset of the label's text
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
    //Method managing the divide operator when user types it
    func divide() {
        if canAddOperator {
            operators.append("÷")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    //Method managing the multiply operator when user types it
    func multiply() {
        if canAddOperator {
            operators.append("x")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    //Method managing the minus operator when users types it
    func minus() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    //Method managing the plus operator when users types it
    func plus() {
        if canAddOperator {
            operators.append("+")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    //Method managing to update the label text(display)
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





