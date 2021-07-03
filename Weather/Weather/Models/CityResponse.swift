//
//  CityResponse.swift
//  Weather
//
//  Created by huda elhady on 03/07/2021.
//

import Foundation

struct CityResponse : Codable {
    let cod : String?
    let count : Int?
    let list : [List]?
    let message : String?
}

struct List : Codable {

    let coord : Coord?
    let dt : Int?
    let id : Int?
    let name : String?
    let rain : String?
    let snow : String?
    let weather : [Weather]?
}

struct Coord : Codable {

    let lat : Double?
    let lon : Double?
}
