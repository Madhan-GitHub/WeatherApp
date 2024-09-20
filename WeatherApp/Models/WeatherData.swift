//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Maddy on 9/19/24.
//

import Foundation

struct WeatherData: Codable {
    let temperature: Double
    let description: String
    let icon: String
}

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
}
