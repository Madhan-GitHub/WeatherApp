//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Maddy on 9/19/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let apiKey = "YOUR_API_KEY_HERE" // Replace with your actual API key
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric"
        performRequest(with: urlString, completion: completion)
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        performRequest(with: urlString, completion: completion)
    }
    
    private func performRequest(with urlString: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                let weatherData = WeatherData(temperature: weatherResponse.main.temp,
                                              description: weatherResponse.weather.first?.description ?? "",
                                              icon: weatherResponse.weather.first?.icon ?? "")
                completion(.success(weatherData))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
