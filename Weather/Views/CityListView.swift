//
//  CityListView.swift
//  Weather
//
//  Created by Shah, Dhruv on 7/29/22.
//

import SwiftUI

struct CityListView : View {
    
    @ObservedObject var viewModel: CityListViewModel
    @State var isPresentingModal: Bool = false
    
    //@State private var isToggle : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top){
                BackgroundView()
                LazyVStack {
                    Text(viewModel.screenTitle)
                        .font(.title)
                        .foregroundColor(.white)
                    ScrollView {
                        ForEach(viewModel.citiesListData, id: \.city) { citiData in
                            NavigationLink(destination: CityForecastView(viewModel: CityForecastViewModel(cityData: citiData, temperatureSwitchToggle: viewModel.temperatureSwitchToggle))) {
                                HStack {
                                    Text(citiData.city)
                                    Spacer()
                                    AsyncImage(url: URL(string: citiData.icon)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.clear
                                    }
                                    .frame(width: 30, height: 30, alignment: .trailing)
                                    .cornerRadius(5)
                                
                                    Text(viewModel.temperatureSwitchToggle ? citiData.celciusTemperatureValue : citiData.farenheitTemperatureValue)
                                        .frame(alignment: .trailing)
                                }
                                .padding(15)
                                .foregroundColor(Color.white)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(15)
                            }
                      }

                    }
                    HStack {
                        Toggle(isOn: $viewModel.temperatureSwitchToggle){
                            Text(Localized.temperatureUnitHeading)
                                .font(.system(size: 14))
                                .foregroundColor(Color.white)
                              }
                    }
                    .frame(width: 100, alignment: .trailing)
               }
                .padding(10)
            }
            .navigationBarItems(trailing: addButton)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear() {
            viewModel.onDisappear()
        }
    }
    
    private var addButton: some View {
        Button(action: {
            self.isPresentingModal = true
        }) {
            Image(systemName: "plus.circle.fill")
            .font(.title)
            .tint(Color.white)
        }.sheet(isPresented: $isPresentingModal) {
            Text(Localized.placeholderAddNewCity)
                .font(.headline)
        }
    }
    
}

struct BackgroundView: View {
    var body: some View {
        let colorScheme = [Color(red: 27/255, green: 56/255, blue: 147/255),
                           Color(red: 46/255, green: 64/255, blue: 83/255)]
        
        let gradient = Gradient(colors: colorScheme)
        let linearGradient = LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
        
        let background = Rectangle()
            .fill(linearGradient)
            .blur(radius: 200, opaque: true)
            .edgesIgnoringSafeArea(.all)
        
        return background
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(viewModel: CityListViewModel())
    }
}
