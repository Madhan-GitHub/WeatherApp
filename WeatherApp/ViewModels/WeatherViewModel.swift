//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Maddy on 9/19/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var weatherData: WeatherData?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let locationManager = LocationManager()
    
    init() {
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.fetchWeatherForLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            .store(in: &cancellables)
        
        locationManager.$error
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.errorMessage = error.localizedDescription
            }
            .store(in: &cancellables)
    }
    
    func searchWeather() {
        guard !cityName.isEmpty else {
            errorMessage = "Please enter a city name"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        NetworkService.shared.fetchWeather(for: cityName) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weatherData):
                    self?.weatherData = weatherData
                    self?.saveLastSearchedCity()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchWeatherForCurrentLocation() {
        locationManager.requestLocation()
    }
    
    private func fetchWeatherForLocation(latitude: Double, longitude: Double) {
        isLoading = true
        errorMessage = nil
        
        NetworkService.shared.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weatherData):
                    self?.weatherData = weatherData
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func saveLastSearchedCity() {
        UserDefaults.standard.set(cityName, forKey: "lastSearchedCity")
    }
    
    func loadLastSearchedCity() {
        if let lastCity = UserDefaults.standard.string(forKey: "lastSearchedCity") {
            cityName = lastCity
            searchWeather()
        }
    }
}
