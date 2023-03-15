//
//  City.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import Foundation

// MARK: - City
struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let humidity: Int
}

// MARK: - Weather
struct Weather: Codable {
    let description: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}

// MARK: - City
struct City: Codable {
    let name: String
    let weatherInfo: [WeatherInfo]
}

// MARK: - City
struct WeatherInfo: Codable {
    let windSpeed: Double
    let WeatherDescription: String
    let temp: Double
    let humidity: Double
}
