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
    var calculate = Calculate()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculate.displayHandlerDelegate = self
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        textView.text = ""
        calculate.number = ""
    }
    
    /// Actions to tap on numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculate.tappedNumberButton(numberText: numberText)
    }
    
    /// Actions to choose an operator
    @IBAction func calculatedButtons(_ sender: UIButton) {
        guard let SymbolText = sender.title(for: .normal) else {
            return
        }
        calculate.calculatedButtons(symbolText: SymbolText)
    }
    
    //            let calculSign = sender.currentTitle
    //            calculate.number.append(" \(calculSign ?? "") ")
    
    /// Action to launch the calcul
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculate.calcul()
    }
}

// MARK: - Delegate Pattern

extension ViewController : DisplayHandler {
    
    func upDateCalcul(calcul: String) {
        textView.text = calcul
    }
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
