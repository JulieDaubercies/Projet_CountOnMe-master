//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by DAUBERCIES on 10/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    // MARK: - Properties

    var calcultate: Calculator!
    override func setUp() {
        super.setUp()
        calcultate = Calculator()
    }

    // MARK: - Tests

    /// Test many addition and subtraction
    func testGivenCalculIsAnAdditionAndsubtraction_WhenTappedToEqualButton_ThenGiveTheResult() {
        calcultate.number = "1 + 2 - 1 + 3"

        calcultate.giveTheResult()

        XCTAssertEqual(calcultate.number, "1 + 2 - 1 + 3 =  5.0")
    }
    /// Test calcul with priority symbol
    func testGivenMakeCalculWithPrioritySymbol_WhenTappedToEqualButton_ThenGiveTheResult() {
        calcultate.number = "2 * 2 - 1 / 2"
        //
        calcultate.giveTheResult()

        XCTAssertEqual(calcultate.number, "2 * 2 - 1 / 2 =  3.5")
    }
    /// Test cancel simple entry
    func testGivenMakeTwoEntry_WhenTappedButtonCancelEntry_ThenRestOneEntry() {
        calcultate.tappedNumberButton(numberText: "1")
        calcultate.tappedOperatorButtons(symbolText: "+")

        calcultate.cancelEntry()

        XCTAssertEqual(calcultate.number, "1 ")
    }
    /// Test cancel all the entry
    func testGivenMakeTwoEntry_WhenTappedButtonCancelEntry_ThenNumberEqualNothing() {
        calcultate.tappedNumberButton(numberText: "1")
        calcultate.tappedOperatorButtons(symbolText: "+")

        calcultate.cancelAllEntry()

        XCTAssertEqual(calcultate.number, "")
    }
    /// First entry is an operator
    func testGivenOperatorAtFirstEntry_WhenTappedNumberButton_ThenRestNumberButton() {
        calcultate.tappedOperatorButtons(symbolText: "+")

        calcultate.tappedNumberButton(numberText: "1")

        XCTAssertEqual(calcultate.number, "1")
    }
    /// First entry is minus operator
    func testGivenMinusAtFirstEntry_WhenTappedNumberButton_ThenMinusAndNumberAreInOneEntry() {
        calcultate.tappedOperatorButtons(symbolText: "-")

        calcultate.tappedNumberButton(numberText: "1")

        XCTAssertEqual(calcultate.number, "-1")
    }
    /// Add operator to a result
    func testGivenWeMakeACalcul_WhenTappedOperatorButton_ThenRestResultOfCalculAndNewOperator() {
        calcultate.number = "1 + 1 =  2.0"

        calcultate.tappedOperatorButtons(symbolText: "-")

        XCTAssertEqual(calcultate.number, "2.0 - ")
    }
    /// Change operator
    func testGivenHaveAnOperator_WhenTappedOperatorButtonTwice_ThenChangeOperator() {
        calcultate.tappedNumberButton(numberText: "1")
        calcultate.tappedOperatorButtons(symbolText: "+")

        calcultate.tappedOperatorButtons(symbolText: "-")

        XCTAssertEqual(calcultate.number, "1 - ")
    }
    /// Tapped twice equal button
    func testGivenMakeACalcul_WhenTappedMaketheTheCalculAgain_ThenRestResultOfFirstCalcul() {
        calcultate.number = "1 + 1 =  2.0"

        calcultate.giveTheResult()

        XCTAssertEqual(calcultate.number, "2.0")
    }
    /// expression have not correct
    func testGivenMissANumber_WhenMakeTheCalcul_ThenDontMakeCalcul() {
        calcultate.tappedNumberButton(numberText: "1")
        calcultate.tappedOperatorButtons(symbolText: "+")

        calcultate.giveTheResult()

        XCTAssertEqual(calcultate.number, "1 + ")
   }
    /// expression have not enough element
    func testGivenNeedMoreEntry_WhenMakeTheCalcul_ThenDontMakeCalcul() {
        calcultate.tappedNumberButton(numberText: "1")

        calcultate.giveTheResult()

        XCTAssertEqual(calcultate.number, "1")
   }
    /// Division by 0 impossible
    func testGivenDivisionBy0_WhenMakeTheCalcul_ThenDontMakeCalcul() {
        calcultate.number = "1 / 0"

        calcultate.giveTheResult()

        XCTAssertEqual(calcultate.number, "1 / 0")
   }
}
