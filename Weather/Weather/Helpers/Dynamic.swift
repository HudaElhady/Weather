//
//  Dynamic.swift
//  Weather
//
//  Created by huda elhady on 08/07/2021.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
}
