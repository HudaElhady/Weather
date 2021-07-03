//
//  SearchViewController.swift
//  WeatherTests
//
//  Created by huda elhady on 03/07/2021.
//

import XCTest
@testable import Weather

class SearchTests: XCTestCase {
    var viewModel: SearchViewModel!
    var forecastRepo: ForecastRepoMock!
    
    override func setUpWithError() throws {
        
        forecastRepo = ForecastRepoMock()
        viewModel = SearchViewModel(forecastRepo: forecastRepo)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        forecastRepo = nil
    }
    
    func testSearchFailWithRequestFailedError() {
        //Given
        forecastRepo.shouldSuccess = false
        forecastRepo.failReponse = .requestFailed
        //When
        viewModel.getCities(name: "")
        //Then
        XCTAssertEqual(viewModel.errorMessage.value, "Internet connection error")
    }
    
    func testSearchFailWithBadURLError() {
        //Given
        forecastRepo.shouldSuccess = false
        forecastRepo.failReponse = .badURL
        //When
        viewModel.getCities(name: "")
        //Then
        
        XCTAssertEqual(viewModel.errorMessage.value, "Bad URL")
    }
    
    func testSearchFailWithUnknownErrorError() {
        //Given
        forecastRepo.shouldSuccess = false
        forecastRepo.failReponse = .unknown
        //When
        viewModel.getCities(name: "")
        //Then
        XCTAssertEqual(viewModel.errorMessage.value, "Unknown error")
    }
    
    func testSearchSucceeded(){
        //Given
        guard let jsonData = GeneralMehtods.readLocalFile(forName: "cities") ,
              let cityModel = try? JSONDecoder().decode(CityResponse.self, from: jsonData) else {return}
        //When
        forecastRepo.shouldSuccess = true
        forecastRepo.getCitiesSuccess = cityModel
        viewModel.getCities(name: "cairo")
        //Then
        XCTAssertEqual(viewModel.citiestArr.value.count, cityModel.list?.count)
        XCTAssertEqual(viewModel.isLoading.value, false)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
