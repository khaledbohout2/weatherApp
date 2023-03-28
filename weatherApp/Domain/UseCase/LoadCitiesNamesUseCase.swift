//
//  loadCitiesNamesUseCase.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

final class LoadCitiesNamesUseCase {

    private let cityNamesRepository: CityNamesRepositoryDelegate

    init(cityNamesRepository: CityNamesRepositoryDelegate) {
        self.cityNamesRepository = cityNamesRepository
    }

    func perform() -> AnyPublisher<[String], Error> {
        cityNamesRepository.loadCitiesNames()
    }

}
