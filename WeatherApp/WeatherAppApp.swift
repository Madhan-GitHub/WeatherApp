//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Maddy on 9/19/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: viewModel)
        }
    }
}
