//
//  GetCityHistoryUseCase.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

final class GetCityHistoryUseCase {

    private let weatherRepository: WeatherRepository
    private let city: String

    init(weatherRepository: WeatherRepository,
         city: String) {
        self.weatherRepository = weatherRepository
        self.city = city
    }

    func perform() -> AnyPublisher<[WeatherInfo], Error> {
        return weatherRepository.getCityHistory(city: city)
    }

}

