//
//  WeatherDetailsViewModel.swift
//  weatherApp
//
//  Created by Khaled Bohout on 24/03/2023.
//

import Foundation
import Combine

enum WeatherDetailsViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(WeatherDetailsViewModelError)
}

enum WeatherDetailsViewModelError: Error, Equatable {
    case weatherFetch
    case weatherSave
}

class WeatherDetailsViewModel {

    private var getCityWeatherUseCase: GetCityWeatherUseCase?
    @Published private(set) var state: WeatherDetailsViewModelState = .loading
    @Published var weatherInfo: WeatherInfo?
    private var cancellables = Set<AnyCancellable>()
    var city: String?

    init(getCityWeatherUseCase: GetCityWeatherUseCase,
         city: String) {
        self.getCityWeatherUseCase = getCityWeatherUseCase
        self.city = city
    }

    init(weather: WeatherInfo) {
        self.weatherInfo = weather
        self.state = .finishedLoading
    }

    func getWeatherInfo() {
        guard let city = city else {return}
        state = .loading
        getCityWeatherUseCase?.perform()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .finishedLoading
                    break
                case .failure(_):
                    self?.state = .error(.weatherFetch)
                }
            }, receiveValue: { [weak self] weatherInfo in
                self?.state = .finishedLoading
                self?.weatherInfo = weatherInfo
                let city = City(name: city, weatherInfo: [weatherInfo])
                self?.updateCity(city: city)
            }).store(in: &self.cancellables)
    }

    func updateCity(city: City) {
        let updateCityUseCase = UpdateCityUseCase(weatherRepository: WeatherRepository(network: Network(), coreDataManager: CoreDataManager(modelName: "weatherApp")), city: city)
        updateCityUseCase.perform()
    }

}
