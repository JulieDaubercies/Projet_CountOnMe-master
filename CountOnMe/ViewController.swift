//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var signForCalcul: [UIButton]!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    // Last expression can't be an operator
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Actions to tap on numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
          //  print(textView.text!)
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    /// Actions to choose an operator
    @IBAction func calculatedButtons(_ sender: UIButton) {
        if expressionHaveResult {
            textView.text = ("\(elements.last ?? "")")
        }
        for sign in signForCalcul {
            if elements.last == sign.currentTitle {
                for _ in 0..<3 {
                    textView.text.removeLast()
                }
            }
        }
        for _ in 0..<1 {
            let calculSign = sender.currentTitle
            textView.text.append(" \(calculSign ?? "") ")
        }
    }
    
    /// Action to launch the calcul
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        if expressionHaveResult {
            textView.text = ("\(elements.last ?? "")")
        } else {
        // Create local copy of operations
        var numberToCalculate = elements
        // Iterate over operations while an operand still here
            while numberToCalculate.count > 1 {
                let left = Int(numberToCalculate[0])!
                print(left)
                let operand = numberToCalculate[1]
                print(operand)
                let right = Int(numberToCalculate[2])!
                print(right)
                let result: Int
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "/": result = left / right
                case "*": result = left * right
                default: fatalError("Unknown operator !")
                }
                print(result)
                // après le calcul des deux premiers chiffres ceux-ci sont supprimés du tableau
                numberToCalculate = Array(numberToCalculate.dropFirst(3))
                numberToCalculate.insert("\(result)", at: 0)
            }
            textView.text.append(" = \(numberToCalculate.first!)")
         //   print("\(numberToCalculate.first!)")
    }
    }
}
