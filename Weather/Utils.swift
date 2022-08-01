//
//  Utils.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/31/22.
//

import Foundation

extension Temperature {
    static func getTemperatureValue(temperature: Temperature) -> String {
        let temperatureUnit = TemperatureUnit(rawValue: temperature.unitCode)
        var unitValue: String = ""
        switch temperatureUnit {
        case .celcius:
            unitValue = Localized.celcius
        case .farenheit:
            unitValue = Localized.farenheit
        default :
            break
        }
        guard let value = temperature.value else {
            return ""
        }
        let temperatureValue = "\(Int(round(value))) \(unitValue)"
        return temperatureValue
    }
    
    static func temperatureInFahrenheit(celcius: Double) -> Int {
          let fahrenheit = (celcius * 9.0) / 5.0 + 32.0
          return Int(fahrenheit)
    }
    
    static func temperatureInCelsius(fahrenheit: Int) -> Int {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
}

extension WindSpeed {
    static func getWindSpeedValue(windSpeed: WindSpeed) -> String {
        let windSpeedUnit = WindSpeedUnit(rawValue: windSpeed.unitCode)
        var unitValue: String = ""
        switch windSpeedUnit {
        case .kmPerHour:
            unitValue = Localized.kmPerHour
        default:
            break
        }
        guard let value = windSpeed.value else {
            return ""
        }
        let windSpeedValue = "\(Int(round(value))) \(unitValue)"
        return windSpeedValue
    }
}

extension Humidity {
    static func getHumiditydValue(humidity: Humidity) -> String {
        let unitValue: String = "%"
        guard let value = humidity.value else {
            return ""
        }
        let humidityValue = "\(Int(round(value))) \(unitValue)"
        return humidityValue
    }
}
