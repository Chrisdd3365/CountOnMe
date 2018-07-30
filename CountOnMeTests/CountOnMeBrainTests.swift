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
    
    //MARK: - Properties
    var numberString: CountOnMeBrain!
    
    override func setUp() {
        super.setUp()
        numberString = CountOnMeBrain()
    }
    
    //MARK: - Methods
    func testGivenIsExpressionCorrect_WhenStringNumberContainNothing_ThenExpressionReturnFalse() {
        
        XCTAssertFalse(numberString.isExpressionCorrect)
    }
    
    func testGivenExpressionIsCorrectIsFalse_WhenExpressionTappedIsNotCorrect_ThenExpressionReturnFalse() {
        numberString.addNewNumber(123)
        numberString.plus()
        numberString.calculateTotal()
        
        XCTAssertFalse(numberString.isExpressionCorrect)
    }
    
    func testGivenExpressionIsCorrectIsTrue_WhenCalculating_ThenExpressionIsCorrect() {
        numberString.addNewNumber(1)
        
        XCTAssertTrue(numberString.isExpressionCorrect)
    }
    
    func testGivenCanAddOperatorIsFalse_WhenStringNumberContainNothing_ThenCanAddOperatorReturnTrue() {
     
        XCTAssertFalse(numberString.canAddOperator)
    }
    
    func testGivenCanAddOperatorIsTrue_WhenStringNumberContainSomething_ThenCanAddOperatorReturnTrue() {
        numberString.addNewNumber(1)
        
        XCTAssertTrue(numberString.canAddOperator)
    }
    
    func testGivenNumberStringIsNil_WhenAddNewNumber_ThenNumberStringIsNotNil() {
        numberString.addNewNumber(1)
        
        XCTAssert(numberString.stringNumbers[numberString.stringNumbers.count-1] == "1")
    }
    
    func testGivenNumberStringIsNotClear_WhenClear_ThenNumberStringIsClear() {
        numberString.clear()
        
        XCTAssert(numberString.stringNumbers[numberString.stringNumbers.count-1] == "")
        XCTAssert(numberString.operators == ["+"])
        XCTAssert(numberString.index == 0)
    }
    
    func testGivenNumberStringIsSomething_WhenDivide_ThenNumberStringIsDivided() {
        numberString.addNewNumber(1)
        numberString.divide()
        numberString.addNewNumber(1)
        numberString.calculateTotal()
        
        XCTAssertFalse(numberString.isExpressionCorrect)
    }
    
    func testGivenNumberStringIsSomething_WhenMultiply_ThenNumberStringIsMultiplied() {
        numberString.addNewNumber(8)
        numberString.multiply()
        numberString.addNewNumber(2)
        numberString.calculateTotal()
        
        XCTAssertFalse(numberString.isExpressionCorrect)
    }
}
