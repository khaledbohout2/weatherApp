//
//  GetCityWeatherUseCase.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

final class GetCityWeatherUseCase {

    private let weatherRepository: WeatherRepository
    private let city: String

    init(weatherRepository: WeatherRepository,
         city: String) {
        self.weatherRepository = weatherRepository
        self.city = city
    }

    func perform() -> AnyPublisher<WeatherInfo, Error> {
        return weatherRepository.getCityWeather(city: city).map { weatherResponse in
            WeatherInfo(weatherResponse: weatherResponse)
        }.map { weatherInfo in
            var weather = weatherInfo
            weather.temp -= Int(273.15)
            return weather
        }.eraseToAnyPublisher()
    }

}
