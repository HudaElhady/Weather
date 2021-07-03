//
//  NetworkError.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation

enum NetworkError: Error {
    case badURL, requestFailed, unknown
    
    var errorMessage: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .requestFailed:
            return "Internet connection error"
        case .unknown:
            return "Unknown error"
        }
    }
    
}
