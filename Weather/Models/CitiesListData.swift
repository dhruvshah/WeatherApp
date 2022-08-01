//
//  CitiesData.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import Foundation

struct CitiesListData {
    let city: String
    let celciusTemperatureValue: String
    let farenheitTemperatureValue: String
    let icon: String
    let properties: CurrentCondition
    let forecastSearchData: CityForecastSearchData?
}
