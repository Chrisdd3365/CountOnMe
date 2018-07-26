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
                    countOnMeDelegate?.alertShow(title: "Zéro!", message: "Démarrez un nouveau calcul!")
                } else {
                    countOnMeDelegate?.alertShow(title: "Zéro!", message: "Entrez une expression correcte!")
                }
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                countOnMeDelegate?.alertShow(title: "Zéro!", message: "Expression incorrecte!")
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
        var total = 0
        for (index, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[index] == "+" {
                    total += number
                }
                if operators[index] == "-" {
                    total -= number
                }
                if operators[index] == "÷" {
                    total /= number
                }
                if operators[index] == "x" {
                    total *= number
                }
            }
        }
        countOnMeDelegate?.updateTextView(label: "\(total)")
        clear()
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





