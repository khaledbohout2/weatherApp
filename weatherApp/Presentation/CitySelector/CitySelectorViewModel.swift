//
//  CitySelectorViewModel.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import Foundation
import Combine

enum CitySelectorViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(CitySelectorViewModelError)
}

enum CitySelectorViewModelError: Error, Equatable {
    case citiesFetch
}

final class CitySelectorViewModel: ObservableObject {

    private var loadCitiesUseCase: LoadCitiesUseCase
    @Published var cities = [City]()
    @Published private(set) var state: CitySelectorViewModelState = .loading
    private var cancellables = Set<AnyCancellable>()

    init(loadCitiesUseCase: LoadCitiesUseCase) {
        self.loadCitiesUseCase = loadCitiesUseCase
    }

    func getCities() {
        state = .loading
        loadCitiesUseCase.perform()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .finishedLoading
                    break
                case .failure(_):
                    self?.state = .error(.citiesFetch)
                }
            },
                  receiveValue: { [weak self] cities in
                self?.state = .finishedLoading
                self?.cities = cities
            })
            .store(in: &self.cancellables)
    }

}
