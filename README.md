# Weather App

A simple iOS weather application built using SwiftUI, allowing users to check the current weather conditions for a specific city or their current location.

## Features

- **Search by City**: Look up weather information by entering a city name.
- **Current Location**: Get weather details based on your current location.
- **Weather Display**: Shows current temperature, weather description, and weather icon.
- **Quick Access**: Saves the last searched city for easy access when the app restarts.

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. **Clone this repository**:

    ```bash
    git clone https://github.com/yourusername/weather-app.git
    ```

2. **Open the project**:

    - Open `WeatherApp.xcodeproj` in Xcode.

3. **API Key Setup**:

    - Obtain an API key from [OpenWeatherMap](https://openweathermap.org/).
    - In `NetworkService.swift`, replace `YOUR_API_KEY_HERE` with your OpenWeatherMap API key.

4. **Run the app**:

    - Build and run the application on your iOS device or simulator.

## Configuration

To use this application, you need to configure an API key from OpenWeatherMap:

1. **Sign Up**:
   - Register for a free account at [OpenWeatherMap](https://openweathermap.org/).
2. **Generate an API Key**:
   - Access your account dashboard and generate an API key.
3. **Update the Code**:
   - Replace `YOUR_API_KEY_HERE` in `NetworkService.swift` with your generated API key.

## Architecture

This project uses the MVVM (Model-View-ViewModel) architecture pattern and is built with SwiftUI for a clean, maintainable codebase.

## Dependencies

- The project is implemented using native iOS frameworks and does not rely on any external dependencies.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
