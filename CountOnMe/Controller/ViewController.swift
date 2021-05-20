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
    @IBOutlet weak var cancelButton: UIButton!
    var calculate = Calculate()
    var tapGesture: UITapGestureRecognizer?
    var longTapGesture: UILongPressGestureRecognizer?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculate.displayHandlerDelegate = self
        longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(cancelAll(_:)))
        cancelButton.addGestureRecognizer(longTapGesture!)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelEntry(_:)))
        cancelButton.addGestureRecognizer(tapGesture!)
    }
    /// Cancel the last entry
    @IBAction func cancelEntry(_ sender: Any) {
        calculate.cancelEntry()
    }
    /// Cancel all the entry
    @IBAction func cancelAll(_ sender: Any) {
        calculate.cancelAllEntry()
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
        guard let symbolText = sender.title(for: .normal) else {
            return
        }
        calculate.TappedOperatorButtons(symbolText: symbolText)
    }
    /// Action to launch the calcul
     @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculate.makeTheCalcul()
    }
}

// MARK: - Delegate Pattern

extension ViewController: DisplayHandler {
    /// Update of the view
    func upDateCalcul(calcul: String) {
        textView.text = calcul
    }
    /// Alert message when error on display
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Attention!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
