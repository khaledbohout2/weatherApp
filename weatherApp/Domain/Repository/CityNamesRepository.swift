//
//  CityNamesRepository.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

protocol CityNamesRepositoryDelegate {
    func loadCitiesNames() -> AnyPublisher<[String], Error>
}
