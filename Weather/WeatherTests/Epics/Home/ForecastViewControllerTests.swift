//
//  ForecastViewControllerTests.swift
//  WeatherTests
//
//  Created by huda elhady on 03/07/2021.
//

import XCTest
@testable import Weather

class ForecastViewControllerTests: XCTestCase {
    var viewModel: ForecastViewModel!
    var forecastRepo: ForecastRepoMock!
    
    override func setUpWithError() throws {
        
        forecastRepo = ForecastRepoMock()
        viewModel = ForecastViewModel(forecastRepo: forecastRepo)
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
        viewModel.getForecast(latitude: 0, longatitude: 0)
        //Then
        XCTAssertEqual(viewModel.errorMessage.value, "Internet connection error")
    }
    
    func testSearchFailWithBadURLError() {
        //Given
        forecastRepo.shouldSuccess = false
        forecastRepo.failReponse = .badURL
        //When
        viewModel.getForecast(latitude: 0, longatitude: 0)
        //Then
        
        XCTAssertEqual(viewModel.errorMessage.value, "Bad URL")
    }
    
    func testSearchFailWithUnknownErrorError() {
        //Given
        forecastRepo.shouldSuccess = false
        forecastRepo.failReponse = .unknown
        //When
        viewModel.getForecast(latitude: 0, longatitude: 0)
        //Then
        XCTAssertEqual(viewModel.errorMessage.value, "Unknown error")
    }
    
    func testSearchSucceeded(){
        //Given
        
        guard let jsonData = GeneralMehtods.readLocalFile(forName: "forecast") ,
              let forecastModel = try? JSONDecoder().decode(ForecastResponse.self, from: jsonData) else {return}
        //When
        forecastRepo.shouldSuccess = true
        forecastRepo.getForecastSuccess = forecastModel
        viewModel.getForecast(latitude: 0, longatitude: 0)
        //Then
        XCTAssertEqual(viewModel.forecastArr.value.count, forecastModel.daily?.count)
        XCTAssertEqual(viewModel.isLoading.value, false)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}

