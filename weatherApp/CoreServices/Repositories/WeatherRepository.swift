//
//  CitiesRepository.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import Foundation

protocol WeatherRepositoryDelegate: AnyObject {
    func autocomplete(text: String) -> AFResult<[City]>
    func getCities() -> [City]
    func getCityWeather(city: String) -> AFResult<WeatherResponse>
}

class WeatherRepository: WeatherRepositoryDelegate {

    private var network: NetworkProtocol
    private var coreDataManager: CoreDataManager

    init(network: NetworkProtocol,
         coreDataManager: CoreDataManager) {
        self.network = network
        self.coreDataManager = coreDataManager
    }

    func autocomplete(text: String) -> AFResult<[City]> {
        let route = CitiesNetworkRouter.autocomplete(text: text)
        return network.request(route)
    }

    func getCities() -> [City] {
        do {
            return try coreDataManager.getAllCities()
        } catch {
            return []
        }
    }

    func getCityWeather(city: String) -> AFResult<WeatherResponse> {
        let route = CitiesNetworkRouter.getCityWeather(city: city)
        return network.request(route)
    }

}
