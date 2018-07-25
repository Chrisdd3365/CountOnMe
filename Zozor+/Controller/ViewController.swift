//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    //MARK: - Properties
    var countOnMeBrain = CountOnMeBrain()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        countOnMeBrain.countOnMeDelegate = self
    }
    
    //MARK: - Action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (index, numberButton) in numberButtons.enumerated() where sender == numberButton {
            countOnMeBrain.addNewNumber(index)
            countOnMeBrain.updateDisplay()
        }
    }
    
    @IBAction func plus() {
        countOnMeBrain.plus()
    }
    
    @IBAction func minus() {
        countOnMeBrain.minus()
    }
    
    @IBAction func equal() {
        countOnMeBrain.calculateTotal()
        textView.text = textView.text + "=\(countOnMeBrain.total)"
    }
    
    //MARK: - Methods
    
    
    
}

extension ViewController: CountOnMeDelegate {
    func alertShow(title: String, message: String) {
        updateShowAlert(title: title, message: message)
    }
}





