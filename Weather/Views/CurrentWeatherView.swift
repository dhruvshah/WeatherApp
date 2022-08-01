//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/31/22.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: CityForecastViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.cityData.city)
                .font(.system(size: 20))
                .foregroundColor(Color.white)
                .frame(alignment: .top)
            Text(viewModel.temperatureValue)
                .font(.system(size: 150))
                .fontWeight(.ultraLight)
                .foregroundColor(Color.white)
                .frame(alignment: .top)
            Text(viewModel.weatherSummary)
                .font(.headline)
                .foregroundColor(Color.white)
                .fontWeight(.medium)
            
            AsyncImage(url: URL(string: viewModel.properties.icon ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.clear
            }
            .frame(width: 80, height: 80)
            .cornerRadius(10)
            
            HStack {
                Text(viewModel.windSpeedHeading)
                Text(viewModel.windSpeedValue)
                }.padding(.bottom, 1)
                .foregroundColor(Color.white)
                .font(.caption)
            
            HStack {
                Text(viewModel.humidityHeading)
                Text(viewModel.humidityValue)
                }.padding(.bottom, 1)
                .foregroundColor(Color.white)
                .font(.caption)
            
            HStack {
                Text(viewModel.precipitationHeading)
                Text(viewModel.properties.dewpoint?.value?.description ?? "")
                }.padding(.bottom, 1)
                .foregroundColor(Color.white)
                .font(.caption)
            
            Text(viewModel.weeklyForecastHeading)
                .foregroundColor(Color.white)
                .padding(.top, 10)
            Spacer()
        }
    }
}
