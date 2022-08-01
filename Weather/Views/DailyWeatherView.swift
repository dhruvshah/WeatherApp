//
//  DailyWeatherView.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/31/22.
//

import SwiftUI
import Combine

struct DailyWeatherView: View {
    @ObservedObject var viewModel: CityForecastViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(viewModel.forecastProperties, id: \.name) { data in
                HStack(alignment:.center) {
                    Text(data.name)
                        .foregroundColor(Color.white)
                    Spacer()
                    AsyncImage(url: URL(string: data.icon)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.clear
                    }
                    .frame(width: 30, height: 30)
                    .cornerRadius(8)
                    Text(viewModel.getTemperatureValue(temperature: data.temperature, temperatureUnit: data.temperatureUnit))
                        .foregroundColor(Color.white)
                        .frame(alignment: .trailing)
                    Divider()
                        .foregroundColor(Color.black)
                }
                .padding(12)
                .background(.blue.opacity(0.3))

            }
            .cornerRadius(5)
        }
    }
}
