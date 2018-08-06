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
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
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
    //Method managing operations (+, -, *, /)
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
        countOnMeDelegate?.updateTextView(label: "\(total)")
        clear()
    }
    //Method managing order of operations
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
            guard let op = operation else { return }
            guard let firstNumber = Double(stringNumbers[index - 1]) else { return }
            guard let secondNumber = Double(stringNumbers[index]) else { return }
            let total = op(firstNumber, secondNumber)
            let totalString = String(format: "%.2f", total)
            stringNumbers[index - 1] = String(totalString)
            stringNumbers.remove(at: index)
            operators.remove(at: index)
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





