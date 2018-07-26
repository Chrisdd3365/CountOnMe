//
//  CountOnMeBrain.swift
//  CountOnMeTests
//
//  Created by Christophe DURAND on 10/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeBrainTests: XCTestCase {
    
    let numberString = CountOnMeBrain()
    
    func testGivenExpressionIsCorrectIsFalse_WhenAlertShow_ThenExpressionIsNotCorrect() {
        numberString.addNewNumber(123)
        numberString.plus()
        numberString.calculateTotal()
        numberString.countOnMeDelegate?.alertShow(title: "Zéro!", message: "Entrez une expression correcte!")
        
        XCTAssertFalse(numberString.isExpressionCorrect)
    }
    
    func testGivenExpressionIsCorrectIsFalse_WhenAlertShow_ThenExpressionIsNotCorrect2() {
        numberString.countOnMeDelegate?.alertShow(title: "Zéro!", message: "Démarrez un nouveau calcul!")
        
        XCTAssertFalse(numberString.isExpressionCorrect)
    }
    
    func testGivenExpressionIsCorrectIsTrue_WhenCalculating_ThenExpressionIsCorrect() {
        numberString.addNewNumber(12345)
        numberString.minus()
        numberString.addNewNumber(1234)
        numberString.calculateTotal()
        
        XCTAssertFalse(numberString.isExpressionCorrect)
    }
    
    func testGivenCanAddOperatorIsFalse_WhenAlertShow_ThenCanAddOperatorCallAlertShowMethod() {
        numberString.countOnMeDelegate?.alertShow(title: "Zéro!", message: "Expression incorrecte!")
        
        XCTAssert(numberString.canAddOperator == false)
    }
    
    func testGivenNumberStringIsNil_WhenAddNewNumber_ThenNumberStringIsNotNil() {
        numberString.addNewNumber(1234)
        
        XCTAssert(numberString.stringNumbers[numberString.stringNumbers.count-1] == "1234")
    }
    
    func testGivenNumberStringIsNotClear_WhenClear_ThenNumberStringIsClear() {
        numberString.clear()
        
        XCTAssert(numberString.stringNumbers[numberString.stringNumbers.count-1] == "")
        XCTAssert(numberString.operators == ["+"])
        XCTAssert(numberString.index == 0)
    }
}
