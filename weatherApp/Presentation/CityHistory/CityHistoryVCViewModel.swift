//
//  CityHistoryVCViewModel.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

enum CityHistoryVCViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(CityHistoryVCViewModelError)
}

enum CityHistoryVCViewModelError: Error, Equatable {
    case weathersFetch
}

final class CityHistoryVCViewModel: ObservableObject {

    private var weatherRepository: WeatherRepositoryDelegate
    private var city: String
    @Published var weathers = [WeatherInfo]()
    @Published private(set) var state: CityHistoryVCViewModelState = .loading
    private var cancellables = Set<AnyCancellable>()

    init(weatherRepository: WeatherRepositoryDelegate,
         city: String) {
        self.weatherRepository = weatherRepository
        self.city = city
        getWeathers()
    }

    func getWeathers() {
        state = .loading
        weatherRepository.getCityHistory(city: city)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .finishedLoading
                    break
                case .failure(_):
                    self?.state = .error(.weathersFetch)
                }
            },
                  receiveValue: { [weak self] weathers in
                self?.state = .finishedLoading
                self?.weathers = weathers
            })
            .store(in: &self.cancellables)
    }

}
