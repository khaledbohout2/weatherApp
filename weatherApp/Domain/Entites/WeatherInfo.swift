//
//  WeatherInfo.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation

struct WeatherInfo: Codable {
    let windSpeed: Int
    let WeatherDescription: String
    var temp: Int
    let humidity: Int
    let iconID: String
    var date: String

    init(windSpeed: Int, WeatherDescription: String, temp: Int, humidity: Int, iconID: String, date: String){
        self.windSpeed = windSpeed
        self.WeatherDescription = WeatherDescription
        self.temp = temp
        self.humidity = humidity
        self.iconID = iconID
        self.date = date
    }

    init(weatherResponse: WeatherResponse){
        self.windSpeed = Int(weatherResponse.wind.speed)
        self.WeatherDescription = weatherResponse.weather[0].description
        self.temp = Int(weatherResponse.main.temp)
        self.humidity = Int(weatherResponse.main.humidity)
        self.iconID = weatherResponse.weather[0].icon
        self.date = Date().toString() ?? ""
    }

}

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let humidity: Double
}

// MARK: - Weather
struct Weather: Codable {
    let description: String
    let icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}
