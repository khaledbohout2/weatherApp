//
//  City.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import Foundation

// MARK: - City
struct City: Codable {
    let name: String
    let weatherInfo: [WeatherInfo]
}

