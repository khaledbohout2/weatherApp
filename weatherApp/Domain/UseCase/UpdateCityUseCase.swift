//
//  updateCityUseCase.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

final class UpdateCityUseCase {

    private let weatherRepository: WeatherRepositoryDelegate
    private let city: City

    init(weatherRepository: WeatherRepositoryDelegate,
         city: City) {
        self.weatherRepository = weatherRepository
        self.city = city
    }

    func perform() {
        try? weatherRepository.updateCity(city: city)
    }

}
