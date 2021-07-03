//
//  ViewControllerExtension.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import UIKit

extension UIViewController {
    
    func alert(title: String = "", message: String, actions: [(String, UIAlertAction.Style)]) {
        
        let alerting = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alerting.addAction(UIAlertAction(title: action.0, style: action.1, handler: nil))
        }
        self.present(alerting, animated: true, completion: nil)
    }
}
