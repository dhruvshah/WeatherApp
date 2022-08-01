//
//  CityListViewModel.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/29/22.
//

import SwiftUI
import CoreLocation
import Foundation

final class CityListViewModel: ObservableObject{
        
    let screenTitle = Localized.weather
    let cities:[String]  = ["Cupertino, USA", "Denver, USA", "Chicago, USA", "New York, USA", "London, UK"]
    
    var currentConditions: CurrentData? = nil
    var currentCondition: CurrentCondition? = nil
    var forecast: Forecast? = nil
    var cityForecastSearchData: CityForecastSearchData? = nil
    @Published var citiesListData: [CitiesListData] = []
    var temperatureValue: Double?
    
    init() {
       
    }
    
    func onAppear() {
        getLocationCoordinates()
    }
    
    func onDisappear() {
        
    }
    
    func getLocationCoordinates() {
        for city in cities {
            getCoordinates(city) {  location in
                let locationUrl = APIEndpoint().locationUrl(latitude: location.latitude, longitude: location.longitude)
                self.getLocation(url: locationUrl, city: city, completionHandler: {_ in})
            }
        }
    }
    
    func getCoordinates(_ address: String,completion:@escaping((CLLocationCoordinate2D) -> ())){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {  return }
            completion(location.coordinate)
        }
    }
    
    func getLocation(url: URL, city: String, completionHandler: @escaping (Bool) -> Void) {
        DataManager<LocationData>.fetch(url: url) { [weak self] result in
            switch result {
            case .success(let response):
                let data = response
                let stations = data.properties.observationStations
                let forecastUrlString = data.properties.forecast
                let forecastHourlyUrlString = data.properties.forecastHourly
            
                self?.cityForecastSearchData = CityForecastSearchData(forecast: forecastUrlString, forecastHourly: forecastHourlyUrlString)
                
                completionHandler(true)
                guard let url = URL(string: stations) else {
                    return
                }
                self?.getStation(url: url, city: city, completion: {_ in})
            case .failure:
                NSLog("Error getting Location from City: \(city)")
                completionHandler(false)
            }
        }
    }
    
    func getStation(url: URL, city: String, completion: @escaping (Bool) -> Void) {
        DataManager<Stations>.fetch(url: url) { result in
            switch result {
            case .success(let response):
                let data = response
                let observationStation = data.features.first?.properties.stationIdentifier ?? ""
                let url = APIEndpoint().currentWeatherUrl(observationStation: observationStation)
                self.getCurrentWeatherData(url: url, city: city, completion: {_ in})
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func getCurrentWeatherData(url: URL, city: String, completion: @escaping (Bool) -> Void) {
        DataManager<CurrentData>.fetch(url: url) { result in
            switch result {
            case .success(let response):
                let data = response
                self.currentCondition = data.properties
                
                self.updateCitiesList(data: data.properties, city: city, completion: {_ in self.citiesListData = self.citiesListData.sorted { $0.city < $1.city } })
                completion(true)
            case .failure(let error):
                NSLog("Error getting Forecast details: \(error)")
                completion(false)
            }
        }
    }
    
    func updateCitiesList(data: CurrentCondition, city: String, completion: @escaping (Bool) -> Void){
        DispatchQueue.main.async {
            guard let celciusValue = data.temperature.value else {
                return
            }
            let celciusTemperatureValue = Temperature.getTemperatureValue(temperature: data.temperature)
            let farenheitValue = Temperature.temperatureInFahrenheit(celcius:celciusValue)
            let farenheitTemperatureValue = Temperature.getTemperatureValue(temperature: Temperature(value: Double(farenheitValue), unitCode: TemperatureUnit.farenheit.rawValue))
            let citiesListData = CitiesListData(city: city,
                                                celciusTemperatureValue:celciusTemperatureValue,
                                                farenheitTemperatureValue: farenheitTemperatureValue,
                                                icon: data.icon ?? "",
                                                properties: data,
                                                forecastSearchData: self.cityForecastSearchData)
            self.citiesListData.append(citiesListData)
            completion(true)
        }
    }

}

