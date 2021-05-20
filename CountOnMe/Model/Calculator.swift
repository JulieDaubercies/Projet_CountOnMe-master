//
//  Calculator.swift
//  CountOnMe
//
//  Created by DAUBERCIES on 10/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

// MARK: - Protocol between model and controller

protocol DisplayHandler {
    func upDateCalcul(calcul: String)
    func showAlert(message: String)
}

class Calculate {
    
    // MARK: - Properties
    
    var number = "" {
        didSet {
            displayHandlerDelegate?.upDateCalcul(calcul: number)
        }
    }
    var  displayHandlerDelegate: DisplayHandler?
    private var elements: [String] {
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
    //  lazy var numberToCalculate =  elements
    private lazy var numberToCalculate: [String] = { elements }()
    private var symbol = ""
    
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
    func TappedOperatorButtons(symbolText: String) {
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
    /// Control of the priority mathematical symbol
    private func controlPrioritySymbol() {
        if numberToCalculate.contains("/") {
            symbol = "/"
        } else  if numberToCalculate.contains("*") {
            symbol = "*"
        } else  if numberToCalculate.contains("+") {
            symbol = "+"
            firstOperand()
        } else  if numberToCalculate.contains("-") {
            symbol = "-"
            firstOperand()
        }
    }
    /// Control way of calcul whit only + and -
    private func firstOperand() {
        if numberToCalculate.contains("+") && numberToCalculate.contains("-") {
            if numberToCalculate.firstIndex(of: "+")! < numberToCalculate.firstIndex(of: "-")! {
                symbol = "+"
            } else {
                symbol = "-"
            }
        }
    }
    /// Control display screen before calcul
    func makeTheCalcul() {
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
            numberToCalculate = elements
            controlPrioritySymbol()
            while let index = numberToCalculate.firstIndex(of: symbol) {
                var resultat = 0.0
                if  symbol == "/" && Int(numberToCalculate[index + 1]) == 0 {
                    displayHandlerDelegate?.showAlert(message: "Division par 0 impossible !")
                    numberToCalculate = [""]
                } else {
                    switch symbol {
                    case "*": resultat = Double(numberToCalculate[index - 1])! * Double(numberToCalculate[index + 1])!
                    case "/": resultat = Double(numberToCalculate[index - 1])! / Double(numberToCalculate[index + 1])!
                    case "+": resultat = Double(numberToCalculate[index - 1])! + Double(numberToCalculate[index + 1])!
                    case "-": resultat = Double(numberToCalculate[index - 1])! - Double(numberToCalculate[index + 1])!
                    default: break
                    }
                    numberToCalculate.insert(("\(resultat)"), at: index - 1)
                    for _ in 0..<3 {
                        numberToCalculate.remove(at: index)
                    }
                    controlPrioritySymbol()
                }
            }
            number = ("\(number) =  \(numberToCalculate[0])")
        }
    }
}
