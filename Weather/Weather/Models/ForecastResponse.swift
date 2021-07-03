//
//  Forecast.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation

struct ForecastResponse : Codable {

    let daily : [Daily]?
    let lat : Float?
    let lon : Float?
    let timezone : String?
    let timezoneOffset : Int?


    enum CodingKeys: String, CodingKey {
        case daily, lat, lon, timezone
        case timezoneOffset = "timezone_offset"
    }
    
}

struct Daily : Codable {

    let clouds : Int?
    let dewPoint : Float?
    let dt : Int?
    let feelsLike : FeelsLike?
    let humidity : Int?
    let moonPhase : Float?
    let moonrise : Int?
    let moonset : Int?
    let pop : Int?
    let pressure : Int?
    let sunrise : Int?
    let sunset : Int?
    let temp : Temp?
    let uvi : Float?
    let weather : [Weather]?
    let windDeg : Int?
    let windGust : Float?
    let windSpeed : Float?

    enum CodingKeys: String, CodingKey {
        case clouds, dt, humidity, moonrise, moonset, pop, pressure, sunrise, sunset, temp, uvi, weather
        case dewPoint = "dew_point"
        case feelsLike = "feels_like"
        case moonPhase = "moon_phase"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case windSpeed = "wind_speed"
    }
}

struct Weather : Codable {

    let descriptionField : String?
    let icon : String?
    let id : Int?
    let main : String?


    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case icon,id,main
    }
    
}

struct Temp : Codable {

    let day : Float?
    let eve : Float?
    let max : Float?
    let min : Float?
    let morn : Float?
    let night : Float?

}

struct FeelsLike : Codable {

    let day : Float?
    let eve : Float?
    let morn : Float?
    let night : Float?

}
