//
//  UIViewController.swift
//  CountOnMe
//
//  Created by Christophe DURAND on 23/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import UIKit

extension UIViewController {
    //Method showing alerts to user when user's inputs are wrong
    func updateShowAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
