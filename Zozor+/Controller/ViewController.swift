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
    var tag = 0
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
        }
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        tag = sender.tag
    }
    
    func operatorButtonTapped() {
        switch tag {
        case 1:
            countOnMeBrain.plus()
        case 2:
            countOnMeBrain.minus()
        case 3:
            countOnMeBrain.multiply()
        case 4:
            countOnMeBrain.divide()
        case 5:
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





