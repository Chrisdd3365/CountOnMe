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
    @IBOutlet var numberButtons: UIButton!
    @IBOutlet var operatorButtons: UIButton!
    
    //MARK: - Properties
    var countOnMeBrain = CountOnMeBrain()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        countOnMeBrain.countOnMeDelegate = self
    }
    
    //MARK: - Action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        countOnMeBrain.addNewNumber(sender.tag)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "+":
            countOnMeBrain.plus()
        case "-":
            countOnMeBrain.minus()
        case "x":
            countOnMeBrain.multiply()
        case "÷":
            countOnMeBrain.divide()
        case "=":
            countOnMeBrain.calculateTotal()
        default:
            break
        }
    }
}

extension ViewController: CountOnMeDelegate {
    func alertShow(title: String, message: String) {
        updateShowAlert(title: title, message: message)
    }
    
    func updateTextView(label: String) {
        textView.text = label
    }
}





