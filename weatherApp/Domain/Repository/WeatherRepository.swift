//
//  WeatherRepository.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

protocol WeatherRepositoryDelegate: AnyObject {
    func loadCities() -> AnyPublisher<[City], Error>
    func getCityWeather(city: String) -> AFResult<WeatherResponse>
    func getCityHistory(city: String) -> AnyPublisher<[WeatherInfo], Error>
    func updateCity(city: City) throws
}
