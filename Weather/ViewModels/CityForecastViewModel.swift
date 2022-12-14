//
//  CityForecastViewModel.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/29/22.
//

import SwiftUI
import Combine
import CoreLocation

final class CityForecastViewModel: ObservableObject{
        
    let cityData: CitiesListData
    let properties: CurrentCondition
    let weatherSummary: String
    let forecastAPI: String
    let forecastHourlyAPI: String
    
    let windSpeedHeading: String = Localized.windSpeed
    let windSpeedValue: String
    let humidityHeading: String = Localized.humidity
    let humidityValue: String
    let precipitationHeading: String = Localized.precipitation
    let precipitationValue: String
    let temperatureValue: String
    
    let weeklyForecastHeading: String = Localized.weeklyForecast
    let temperatureSwitchToggle: Bool
    
    var forecast: Forecast? = nil
    @Published var forecastProperties: [ForecastData] = []
    
    init(cityData: CitiesListData, temperatureSwitchToggle: Bool) {
        self.cityData = cityData
        self.properties = cityData.properties

        if temperatureSwitchToggle {
            self.temperatureValue = cityData.celciusTemperatureValue
        }else {
            self.temperatureValue = cityData.farenheitTemperatureValue
        }
        self.windSpeedValue = WindSpeed.getWindSpeedValue(windSpeed: properties.windSpeed)
        self.humidityValue = Humidity.getHumiditydValue(humidity: properties.relativeHumidity)
        self.precipitationValue = properties.dewpoint?.value?.description ?? ""
        self.weatherSummary = cityData.properties.textDescription ?? ""
        self.forecastAPI = cityData.forecastSearchData?.forecast ?? ""
        self.forecastHourlyAPI = cityData.forecastSearchData?.forecastHourly ?? ""
        self.temperatureSwitchToggle = temperatureSwitchToggle
    }
    
    func onAppear() {
        getWeeklyForecast()
        //getHourlyForeCast()
    }
    
    func onDisappear() {
    }

    func getHourlyForeCast() {
        guard let url = URL(string: forecastHourlyAPI) else {
            return
        }
        self.getWeatherForecast(url: url, completion: { result in
            NSLog("Forecast details: \(result)")
        })
    }
    
    func getTemperatureValue(temperature: Int, temperatureUnit: String) -> String {
        if temperatureSwitchToggle {
            let temperatureCelcius = Temperature.temperatureInCelsius(fahrenheit: temperature)
            return "\(temperatureCelcius) " + Localized.celcius
        }
        return "\(temperature) \(temperatureUnit)"
    }
    
    private func getWeeklyForecast() {
        guard let url = URL(string: forecastAPI) else {
            return
        }
        self.getWeatherForecast(url: url, completion: { result in })
    }
    
    /// Method to get weekly weather forecast from weather API
    ///
    /// - Parameters:
    ///   - url: The url to get weekly weather forecast of the selected city.
    ///   - completionHandler: used to notify result of the API action.
    func getWeatherForecast(url: URL, completion: @escaping (Bool) -> Void) {
        DataManager<Forecast>.fetch(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let data = response
                    self.forecastProperties = data.properties.periods
                    completion(true)
                case .failure(let error):
                    NSLog("Error getting Forecast details: \(error)")
                    completion(false)
                }
            }
        }
    }
}
