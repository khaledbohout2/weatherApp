//
//  loadCitiesUseCase.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

final class LoadCitiesUseCase {

    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func perform() -> AnyPublisher<[City], Error> {
        return weatherRepository.loadCities()
    }

}
