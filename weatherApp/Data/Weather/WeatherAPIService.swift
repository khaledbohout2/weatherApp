//
//  WeatherAPIService.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Combine
import Foundation

protocol WeatherAPIServiceInterface {
    func getCityWeather(city: String) -> AnyPublisher<WeatherResponse, Error>
}

struct WeatherAPIService: WeatherAPIServiceInterface {

    private var network :NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getCityWeather(city: String) -> AnyPublisher<WeatherResponse, Error> {
        let route = WeatherNetworkRouter.getCityWeather(city: city)
        do {
            return network.request(route)
        }
    }

}
