//
//  UIViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 04/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import UIKit
import ARSLineProgress

extension UIViewController {
    
    func presentAlert(withTitle title: String, message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentSuccessAlert(withMessage message: String, completion: (() -> Void)?) {
        self.presentAlert(withTitle: "Success", message: message, completion: completion)
    }
    
    func presentErrorAlert(withMessage message: String, completion: (() -> Void)?) {
        self.presentAlert(withTitle: "Error", message: message, completion: completion)
    }
    
    func presentUnknownError(completion: (() -> Void)?) {
        self.presentErrorAlert(withMessage: "An error has ocurred, please try again later", completion: completion)
    }
    
    func showLoader() {
        ARSLineProgress.show()
    }
    
    func hideLoader() {
        ARSLineProgress.hide()
    }
    
}
