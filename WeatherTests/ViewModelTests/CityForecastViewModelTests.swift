//
//  CityForecastViewModelTests.swift
//  WeatherTests
//
//  Created by Shah, Dhruv on 7/31/22.
//

import XCTest
@testable import Weather

class CityForecastViewModelTests: XCTestCase {
    private var viewModel: CityForecastViewModel!

    override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    super.setUp()
        //Mock Data
        let forecastURL = "https://api.weather.gov/gridpoints/OKX/32,34/forecast"
        let citiesData = CitiesListData(city: "Cupertino, USA", celciusTemperatureValue: "25 °C", farenheitTemperatureValue: "70 °F", icon: "icon-url", properties: CurrentCondition(temperature: Temperature(value: 24, unitCode: ""), dewpoint: DewPoint(value: 34, unitCode: ""), windSpeed: WindSpeed(value: 23, unitCode: WindSpeedUnit.kmPerHour.rawValue), relativeHumidity: Humidity(value: 12)),forecastSearchData: CityForecastSearchData(forecast: forecastURL, forecastHourly: ""))
        viewModel = CityForecastViewModel(cityData: citiesData)
        
    }
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testCityNameTitle() {
        XCTAssertEqual(viewModel.cityData.city, "Chicago, USA")
    }
    
    func testWeatherDetailHeadings() {
        XCTAssertEqual(viewModel.windSpeedHeading, "WIND SPEED: ")
        XCTAssertEqual(viewModel.humidityHeading, "HUMIDITY: ")
        XCTAssertEqual(viewModel.precipitationHeading, "PRECIPITATION: ")
        XCTAssertEqual(viewModel.weeklyForecastHeading, "Weekly Forecast")
    }
    
    func testWeatherDetailValues() {
        XCTAssertEqual(viewModel.cityData.farenheitTemperatureValue, "70 °F")
        XCTAssertEqual(viewModel.windSpeedValue, "23 km/hr")
        XCTAssertEqual(viewModel.humidityValue, "12 %")
        XCTAssertEqual(viewModel.precipitationValue, "34.0")
    }
    
    func testResultWeeklyWeatherForecast_Success() throws {
        let weatherForecastExpectation = self.expectation(description: "get weekly weather forecast expectation")
        // Mock Data
        let weatherForecastUrl = URL(string: viewModel.forecastAPI)!
        viewModel.getWeatherForecast(url: weatherForecastUrl) { result in
            XCTAssertTrue(result)
            weatherForecastExpectation.fulfill()
        }

        wait(for: [weatherForecastExpectation], timeout: 5)
    }
    
    func testResultWeeklyWeatherForecast_Fail() throws {
        let weatherForecastExpectation = self.expectation(description: "error fetching weekly weather forecast")
        // Mock Bad Data
        let weatherForecastUrl = URL(string: "badurl")!
        viewModel.getWeatherForecast(url: weatherForecastUrl) { result in
            XCTAssertFalse(result)
            weatherForecastExpectation.fulfill()
        }

        wait(for: [weatherForecastExpectation], timeout: 5)
    }

}
