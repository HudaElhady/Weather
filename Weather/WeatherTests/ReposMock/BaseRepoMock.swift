//
//  BaseRepoMock.swift
//  WeatherTests
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation

@testable import Weather

class BaseRepoMock {
    var shouldSuccess: Bool = false
    var failReponse: NetworkError!
}
