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

    private var citiesRepository: CitiesRepositoryDelegate
    @Published var cities = [City]()
    @Published private(set) var state: CitySelectorViewModelState = .loading

    init(citiesRepository: CitiesRepositoryDelegate) {
        self.citiesRepository = citiesRepository
        getCities()
    }

    func getCities() {

    }
}