//
//  Calculator.swift
//  CountOnMe
//
//  Created by DAUBERCIES on 10/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

// MARK: - Protocol between model and controller

protocol DisplayHandler: AnyObject {
    func upDateCalcul(calcul: String)
    func showAlert(message: String)
}

class Calculator {

    // MARK: - Properties

    var calcul = Calcul()
    var number = "" {
        didSet {
            displayHandlerDelegate?.upDateCalcul(calcul: number)
        }
    }
    weak var  displayHandlerDelegate: DisplayHandler?
    var elements: [String] {
        return number.split(separator: " ").map { "\($0)" }
    }
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*"
    }
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    private var expressionHaveResult: Bool {
        return number.firstIndex(of: "=") != nil
    }
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*"
    }
    private var expressionBeginByMinus: Bool {
        return elements.first == "-"
    }
    private var expressionBeginByOtherOperator: Bool {
        return elements.first == "*" || elements.first == "/" || elements.first == "+"
    }

    // MARK: - Methods

    /// Manage TapGesture : cancel last entry
    func cancelEntry() {
        if number != "" {
            if number.last == " " {
                number.removeLast()
            }
            number.removeLast()
        }
    }
    /// Manage LongTapGesture : cancel all the entry
    func cancelAllEntry() {
        number = ""
    }
    /// Manage number button
    func tappedNumberButton(numberText: String) {
        if expressionHaveResult || expressionBeginByOtherOperator {
            number = ""
        }
        if expressionBeginByMinus {
            number = ""
            number.append("-\(numberText)")
        } else {
            number.append(numberText)
        }
    }
    /// Manage operator button
    func tappedOperatorButtons(symbolText: String) {
        if expressionHaveResult {
            number = ("\(elements.last ?? "")")
        }
        if canAddOperator {
            number.append(" \(symbolText) ")
        } else {
            for _ in 0..<3 {
                number.removeLast()
            }
            number.append(" \(symbolText) ")
        }
    }
    /// Manage equal button
    func giveTheResult() {
        guard expressionIsCorrect else {
            displayHandlerDelegate?.showAlert(message: "Entrez une expression correcte !")
            return
        }
        guard expressionHaveEnoughElement else {
            displayHandlerDelegate?.showAlert(message: "Démarrez un nouveau calcul !")
            return
        }
        if expressionHaveResult {
            number = ("\(elements.last ?? "")")
        } else {
            calcul.numberToCalculate = elements
            calcul.makeTheCalcul()
            if calcul.numberToCalculate == ["error"] {
                displayHandlerDelegate?.showAlert(message: "Division par 0 impossible !")
            } else {
                number = ("\(number) =  \(calcul.numberToCalculate[0])")
            }
        }
    }
}
