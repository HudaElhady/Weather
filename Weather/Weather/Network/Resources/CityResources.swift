//
//  CityResources.swift
//  Weather
//
//  Created by huda elhady on 02/07/2021.
//

import Foundation

struct CityResources {
    
    static func cityResource(searchString: String) -> Resource<CityResponse> {
        let urlString = Constants.Api.baseUrl + "find?q=\(searchString)&appid=\(Constants.Api.appId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
       return Resource<CityResponse>(get: URL(string: urlString)!)
    }
}


