//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Maddy on 9/19/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter city name", text: $viewModel.cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.searchWeather()
                }) {
                    Text("Search")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    viewModel.fetchWeatherForCurrentLocation()
                }) {
                    Text("Use Current Location")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let weatherData = viewModel.weatherData {
                    WeatherDetailView(weatherData: weatherData)
                }
                
                if viewModel.errorMessage != nil {
                    Button("Show Error") {
                        showAlert = true
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Weather App")
            .overlay(
                Group {
                    if showAlert {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .overlay(
                                AlertView(
                                    title: "Error",
                                    message: viewModel.errorMessage ?? "An unknown error occurred",
                                    buttonTitle: "OK"
                                ) {
                                    showAlert = false
                                    viewModel.errorMessage = nil
                                }
                            )
                    }
                }
            )
        }
        .onAppear {
            viewModel.loadLastSearchedCity()
        }
    }
}

struct WeatherDetailView: View {
    let weatherData: WeatherData
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherData.icon)@2x.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            
            Text("\(Int(weatherData.temperature))°C")
                .font(.system(size: 50, weight: .bold))
            
            Text(weatherData.description.capitalized)
                .font(.title2)
        }
    }
}
