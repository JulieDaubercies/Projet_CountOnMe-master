//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by DAUBERCIES on 10/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe
import UIKit

class CountOnMeTests: XCTestCase {
    
    var calcultate: Calculate!
    var displayHandler: DisplayHandler!
    
    override func setUp() {
        super.setUp()
        calcultate = Calculate()
    }
    /// Test many addition and sustraction
    func testGivenCalculIsAnAdditionAndSustraction_WhenTappedToEqualButton_ThenGiveTheResult() {
        calcultate.number = "1 + 2 - 1 + 3"
        
        calcultate.makeTheCalcul()

        XCTAssertEqual(calcultate.number, "1 + 2 - 1 + 3 =  5.0")
    }
    
    func testGivenMakeCalculWithPrioritySymbol_WhenTappedToEqualButton_ThenGiveTheResult() {
        calcultate.number = "2 * 2 - 1 / 2"
        
        calcultate.makeTheCalcul()

        XCTAssertEqual(calcultate.number, "2 * 2 - 1 / 2 =  3.5")
    }
    /// Test cancel simple entry
    func testGivenMakeTwoEntry_WhenTappedButtonCancelEntry_ThenRestOneEntry() {
        calcultate.tappedNumberButton(numberText: "1")
        calcultate.TappedOperatorButtons(symbolText: "+")
        
        calcultate.cancelEntry()
        
        XCTAssertEqual(calcultate.number, "1 ")
    }
    /// Test cancel all the entry
    func testGivenMakeTwoEntry_WhenTappedButtonCancelEntry_ThenNumberEqualNothing() {
        calcultate.tappedNumberButton(numberText: "1")
        calcultate.TappedOperatorButtons(symbolText: "+")
        
        calcultate.cancelAllEntry()
        
        XCTAssertEqual(calcultate.number, "")
    }
    /// First entry is an operator
    func testGivenOperatorAtFirstEntry_WhenTappedNumberButton_ThenRestNumberButton() {
        calcultate.TappedOperatorButtons(symbolText: "+")
        
        calcultate.tappedNumberButton(numberText: "1")
        
        XCTAssertEqual(calcultate.number, "1")
    }
    /// First entry is minus operator
    func testGivenMinusAtFirstEntry_WhenTappedNumberButton_ThenMinusAndNumberAreInOneEntry() {
        calcultate.TappedOperatorButtons(symbolText: "-")
        
        calcultate.tappedNumberButton(numberText: "1")
        
        XCTAssertEqual(calcultate.number, "-1")
    }
    /// Add operator to a result
    func testGivenWeMakeACalcul_WhenTappedOperatorButton_ThenRestResultOfCalculAndNewOperator() {
        calcultate.number = "1 + 1 =  2.0"
        
        calcultate.TappedOperatorButtons(symbolText: "-")
        
        XCTAssertEqual(calcultate.number, "2.0 - ")
    }
    /// Change operator
    func testGivenHaveAnOperator_WhenTappedOperatorButtonTwice_ThenChangeOperator() {
        calcultate.tappedNumberButton(numberText: "1")
        calcultate.TappedOperatorButtons(symbolText: "+")
        
        calcultate.TappedOperatorButtons(symbolText: "-")
        
        XCTAssertEqual(calcultate.number, "1 - ")
    }
    /// Tapped twice equal button
    func testGivenMakeACalcul_WhenTappedMaketheTheCalculAgain_ThenRestResultOfFirstCalcul() {
        calcultate.number = "1 + 1 =  2.0"
        
        calcultate.makeTheCalcul()
        
        XCTAssertEqual(calcultate.number, "2.0")
    }
    
    func testGivenMissANumber_WhenMakeTheCalcul_ThenDontMakeCalcul() {
        calcultate.tappedNumberButton(numberText: "1")
        calcultate.TappedOperatorButtons(symbolText: "+")

        calcultate.makeTheCalcul()
        
        XCTAssertEqual(calcultate.number, "1 + ")
   }

    func testGivenNeedMoreEntry_WhenMakeTheCalcul_ThenDontMakeCalcul() {
        calcultate.tappedNumberButton(numberText: "1")

        calcultate.makeTheCalcul()
        
        XCTAssertEqual(calcultate.number, "1")
   }

    func testGivenDivideBy0_WhenMakeTheCalcul_ThenDontMakeCalcul() {
        calcultate.number = "1 / 0"

        calcultate.makeTheCalcul()
        
        XCTAssertEqual(calcultate.number, "1 / 0 =  ")
   }
}
