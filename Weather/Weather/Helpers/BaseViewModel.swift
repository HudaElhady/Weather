//
//  BaseViewModel.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation

class BaseViewModel {

    var isLoading: Dynamic<Bool> = Dynamic(false)

    init(isLoading: Bool) {
        self.isLoading.value = isLoading
    }

    func startLoading() {
        isLoading.value = true
    }

    func stopLoading() {
        isLoading.value = false
    }

}
