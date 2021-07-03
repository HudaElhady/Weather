//
//  GeneralMehtods.swift
//  WeatherTests
//
//  Created by huda elhady on 03/07/2021.
//

import XCTest
@testable import Weather

class GeneralMehtods {
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
