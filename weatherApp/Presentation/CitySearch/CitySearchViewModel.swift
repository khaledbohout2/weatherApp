//
//  CitySearchViewModel.swift
//  weatherApp
//
//  Created by Khaled Bohout on 14/03/2023.
//

import Foundation
import Combine

enum CitySearchViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(CitySearchViewModelError)
}

enum CitySearchViewModelError: Error, Equatable {
    case citiesFetch
}

final class CitySearchViewModel: ObservableObject {

    private var loadCitiesNamesUseCase: LoadCitiesNamesUseCase
    @Published var citiyNames = [String]()
    @Published var filteredNames = [String]()
    @Published private(set) var state: CitySelectorViewModelState = .loading
    private var cancellables = Set<AnyCancellable>()

    init(loadCitiesNamesUseCase: LoadCitiesNamesUseCase) {
        self.loadCitiesNamesUseCase = loadCitiesNamesUseCase
    }

    func getCities() {
        state = .loading
        loadCitiesNamesUseCase.perform()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .finishedLoading
                    break
                case .failure(_):
                    self?.state = .error(.citiesFetch)
                }
            }, receiveValue: { [weak self] citiyNames in
                self?.state = .finishedLoading
                self?.citiyNames = citiyNames
            }).store(in: &self.cancellables)
    }

    func search(query: String?) {
        guard let query = query,
              query.count != 0 else {
            filteredNames = citiyNames
            return
        }
        filteredNames = citiyNames.filter { $0.contains(query) }
    }

}
