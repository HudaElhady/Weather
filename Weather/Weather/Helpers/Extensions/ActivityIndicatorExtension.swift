//
//  ActivityIndicatorExtension.swift
//  Weather
//
//  Created by huda elhady on 07/07/2021.
//

import UIKit

extension UIActivityIndicatorView {
    func startSpinner() {
        startAnimating()
        isHidden = false
        isUserInteractionEnabled = false
    }

    func stopSpinner() {
        stopAnimating()
        isHidden = true
        isUserInteractionEnabled = true
    }
}

