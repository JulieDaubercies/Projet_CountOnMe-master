//
//  Calculator.swift
//  CountOnMe
//
//  Created by DAUBERCIES on 10/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol DisplayHandler {
    func upDateCalcul(calcul: String)
    func showAlert(message: String)
}

class Calculate {
    
    var number = "" {
        didSet {
            displayHandlerDelegate?.upDateCalcul(calcul: number)
        }
    }
    var elements: [String] { return number.split(separator: " ").map { "\($0)" } }
    var expressionIsCorrect: Bool { return elements.last != "+" && elements.last != "-" }
    var expressionHaveEnoughElement: Bool { return elements.count >= 3 }
    var expressionHaveResult: Bool { return number.firstIndex(of: "=") != nil }
    var symbol = ""
    lazy var numberToCalculate = elements
    var displayHandlerDelegate: DisplayHandler?
    
    
    func tappedNumberButton(numberText: String) {
        if expressionHaveResult {
            number = ""
        }
        number.append(numberText)
    }
    
    
    func calculatedButtons(symbolText: String) {
        if expressionHaveResult {
            number = ("\(elements.last ?? "")")
        }
        for _ in number {
            if elements.last == "+" || elements.last == "-"  || elements.last == "/" || elements.last == "*" {
                for _ in 0..<3 {
                    number.removeLast()
                }
            }
        }
        number.append(" \(symbolText) ")
    }
    
    func controlPrioritySymbol() {
        if numberToCalculate.contains("/") {
            symbol = "/"
        } else  if numberToCalculate.contains("*"){
            symbol = "*"
        } else  if numberToCalculate.contains("+"){
            symbol = "+"
            firstOperand()
        } else  if numberToCalculate.contains("-"){
            symbol = "-"
            firstOperand()
        }
    }
    
    func firstOperand() {
        if numberToCalculate.contains("+") && numberToCalculate.contains("-") {
            if numberToCalculate.firstIndex(of: "+")! < numberToCalculate.firstIndex(of: "-")! {
                symbol = "+"
            } else {
                symbol = "-"
            }
        }
    }
    
    func calcul() {
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
            for _ in numberToCalculate {
                controlPrioritySymbol()
                while let indexTest = numberToCalculate.firstIndex(of: symbol) {
                    var resultat = 0.0
                    switch symbol {
                    case "*": resultat = Double(numberToCalculate[indexTest - 1])! * Double(numberToCalculate[indexTest + 1])!
                    case "/": resultat = Double(numberToCalculate[indexTest - 1])! / Double(numberToCalculate[indexTest + 1])!
                    case "+": resultat = Double(numberToCalculate[indexTest - 1])! + Double(numberToCalculate[indexTest + 1])!
                    case "-": resultat = Double(numberToCalculate[indexTest - 1])! - Double(numberToCalculate[indexTest + 1])!
                    default: break
                    }
                    numberToCalculate.insert(("\(resultat)"), at: indexTest - 1)
                    for _ in 0..<3 {
                        numberToCalculate.remove(at: indexTest)
                    }
                    controlPrioritySymbol()
                }
            }
            number = ("\(number) =  \(numberToCalculate[0])")
        }
        
    }
}
