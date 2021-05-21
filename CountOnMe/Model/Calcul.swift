//
//  Calcul.swift
//  CountOnMe
//
//  Created by DAUBERCIES on 21/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calcul {

    // MARK: - Properties

    private var symbol = ""
    var numberToCalculate = [""]

    // MARK: - Methods

    private func controlPrioritySymbol() {
        if numberToCalculate.contains("/") {
            symbol = "/"
        } else  if numberToCalculate.contains("*") {
            symbol = "*"
        } else  if numberToCalculate.contains("-") {
            symbol = "-"
        } else  if numberToCalculate.contains("+") {
            symbol = "+"
        }
    }
    /// Make the calcul
    func makeTheCalcul() {
        controlPrioritySymbol()
        while let index = numberToCalculate.firstIndex(of: symbol) {
            var resultat = 0.0
            if  symbol == "/" && Int(numberToCalculate[index + 1]) == 0 {
                numberToCalculate = ["error"]
            } else {
                switch symbol.self {
                case "*": resultat = Double(numberToCalculate[index - 1])! * Double(numberToCalculate[index + 1])!
                case "/" : resultat = Double(numberToCalculate[index - 1])! / Double(numberToCalculate[index + 1])!
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
    }
}
