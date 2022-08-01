//
//  Strings.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/31/22.
//

import Foundation

public class Localized {
    public static var weather = NSLocalizedString("Weather", comment: "")
    public static let temperatureUnitHeading = NSLocalizedString("°C / °F", comment: "")
    public static let celcius = NSLocalizedString("°C", comment: "")
    public static let farenheit = NSLocalizedString("°F", comment: "")
    public static let placeholderAddNewCity = NSLocalizedString("PlaceHolder To Add New City", comment: "")
    
    public static let windSpeed = NSLocalizedString("WIND SPEED: ", comment: "")
    public static let humidity = NSLocalizedString("HUMIDITY: ", comment: "")
    public static let precipitation = NSLocalizedString("PRECIPITATION: ", comment: "")
    public static let weeklyForecast = NSLocalizedString("Weekly Forecast", comment: "")
    public static let kmPerHour = NSLocalizedString("km/hr", comment: "")
    
    public static let networkError = NSLocalizedString("The NWS API may be experiencing an interruption - please try again.", comment: "")
    public static let noNetworkError = NSLocalizedString("The network is currently unavailable, please check your wifi or data connection.", comment: "")
    public static let otherError = NSLocalizedString("An unexpected error has occurred. Please wait and try again.", comment: "")
    public static let noDataError = NSLocalizedString("Please check your selection; the National Weather Service cannot retrieve its data.", comment: "")
}
