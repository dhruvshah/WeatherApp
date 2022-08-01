//
//  CityListViewModelTests.swift
//  WeatherTests
//
//  Created by Shah, Dhruv on 7/31/22.
//

import XCTest
@testable import Weather

class CityListViewModelTests: XCTestCase {
    private var viewModel: CityListViewModel!

    override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    super.setUp()
    viewModel = CityListViewModel()
        
    }
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testScreenTitle() {
        XCTAssertEqual(viewModel.screenTitle, "Weather")
    }
    
    func testInputCityData() {
        XCTAssertNotNil(viewModel.cities)
        let city = "Chicago, USA"
        XCTAssertTrue(viewModel.cities.contains(city))
    }
    
    func testGetResultForLocation_Success() throws {
        let locationExpectation = self.expectation(description: "get location expectation")
        // Mock Location url
        let locationURL = APIEndpoint().locationUrl(latitude: 47.6174, longitude: -122.2017)
        XCTAssertEqual(APIEndpoint().baseURL.absoluteString, "https://api.weather.gov/")
        XCTAssertEqual(locationURL.absoluteString,"https://api.weather.gov/points/47.6174,-122.2017")
        
        viewModel.getLocation(url: locationURL, city: "Cupertino, USA") { result in
            XCTAssertTrue(result)
            locationExpectation.fulfill()
        }

        wait(for: [locationExpectation], timeout: 5)
    }
    
    func testResultForLocation_Fail() throws {
        let locationExpectation = self.expectation(description: "cannot get location")
        // mock bad location data
        let locationURL = APIEndpoint().locationUrl(latitude: -0, longitude: -0)
        viewModel.getLocation(url: locationURL, city: "") { result in
           XCTAssertFalse(result)
           locationExpectation.fulfill()
        }

        wait(for: [locationExpectation], timeout: 5)
    }
    
    func testGetResultForStation() throws {
        let stationExpectation = self.expectation(description: "get station expectation")
        // Mock Data
        let stationUrl = URL(string: "https://api.weather.gov/gridpoints/ABQ/121,112/stations")!
        viewModel.getStation(url: stationUrl, city: "Cupertino, USA") { result in
            XCTAssertTrue(result)
            stationExpectation.fulfill()
        }

        wait(for: [stationExpectation], timeout: 5)
    }
    
    func testGetResultForCurrentWeatherData() throws {
        let currentWeatherDataExpectation = self.expectation(description: "get current weather Data expectation")
        // Mock Data
        let currentWeatherUrl = URL(string: "https://api.weather.gov/stations/K0E0/observations/latest")!
        viewModel.getCurrentWeatherData(url: currentWeatherUrl, city: "Cupertino, USA") { result in
            XCTAssertTrue(result)
            currentWeatherDataExpectation.fulfill()
        }

        wait(for: [currentWeatherDataExpectation], timeout: 5)
    }
    
    func testUpdateCitiesListData() throws {
        let citiesListUpdatedExpectation = self.expectation(description: "cities List updated expectation")
        // Mock Data
        let currentCondition = CurrentCondition(temperature: Temperature(value: 25, unitCode: TemperatureUnit.celcius.rawValue), windSpeed: WindSpeed(value: 15, unitCode: "km/hr"), relativeHumidity: Humidity(value: 55), icon: "icon-url")
        
        viewModel.updateCitiesList(data: currentCondition, city: "Cupertino, USA") { result in
            XCTAssertTrue(result)
            let citiesListData = self.viewModel.citiesListData
            XCTAssertEqual(citiesListData.first?.city, "Cupertino, USA")
            XCTAssertEqual(citiesListData.first?.celciusTemperatureValue, "25 °C")
            XCTAssertEqual(citiesListData.first?.properties.windSpeed.value, 15)
            XCTAssertEqual(citiesListData.first?.properties.relativeHumidity.value, 55)
            XCTAssertEqual(citiesListData.first?.icon, "icon-url")
            
            citiesListUpdatedExpectation.fulfill()
        }
        wait(for: [citiesListUpdatedExpectation], timeout: 5)
    }

}
