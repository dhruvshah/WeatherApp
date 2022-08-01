//
//  CityForecastView.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/30/22.
//

import SwiftUI

struct CityForecastView: View {
    @ObservedObject var viewModel: CityForecastViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            BackgroundView()
            ScrollView{
                VStack {
                    CurrentWeatherView(viewModel: viewModel)
                    Spacer()
                }
                HStack {
                    DailyWeatherView(viewModel: viewModel)
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 10)
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear() {
            viewModel.onDisappear()
        }
    }
}

struct CityForecastView_Previews: PreviewProvider {
    static var previews: some View {
        let currentCondition = CurrentCondition(textDescription: "", temperature: Temperature(value: 20, unitCode: "°C"), windSpeed: WindSpeed(value: 5, unitCode: "km/hr"), relativeHumidity: Humidity(value: 12.8))
        let cityData = CitiesListData(city: "Cupertino, USA", celciusTemperatureValue: "23 °C",farenheitTemperatureValue: "52 °F", icon: "", properties: currentCondition, forecastSearchData: nil)
        CityForecastView(viewModel: CityForecastViewModel(cityData: cityData))
    }
}
