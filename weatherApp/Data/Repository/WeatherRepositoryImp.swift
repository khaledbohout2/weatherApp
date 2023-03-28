//
//  WeatherRepositoryImp.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

class WeatherRepository: WeatherRepositoryDelegate {

    private var network: NetworkProtocol
    private var coreDataManager: CoreDataManager

    init(network: NetworkProtocol,
         coreDataManager: CoreDataManager) {
        self.network = network
        self.coreDataManager = coreDataManager
    }

    func loadCities() -> AnyPublisher<[City], Error> {
        do {
            return try coreDataManager.getAllCities()
        } catch {
            return Fail(error: LoadingFileError.failedReadingContent).eraseToAnyPublisher()
        }
    }

    func updateCity(city: City) throws {
        do {
            try coreDataManager.update(city: city)
        } catch {
            throw CitySelectorViewModelError.citiesFetch
        }
    }

    func getCityWeather(city: String) -> AFResult<WeatherResponse> {
        let route = WeatherAPIService(network: network)
        return route.getCityWeather(city: city)
    }

    func getCityHistory(city: String) -> AnyPublisher<[WeatherInfo], Error> {
        return coreDataManager.getCityHistory(cityName: city)
    }

}
