//
//  MainCoordinator.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

final class MainCoordinator: Coordinator {

    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        citySelector()
    }

    func citySelector() {
        let weatherRepository = WeatherRepository(network: Network(), coreDataManager: CoreDataManager(modelName: "weatherApp"))
        let loadCitiesUseCase = LoadCitiesUseCase(weatherRepository: weatherRepository)
        let viewModel = CitySelectorViewModel(loadCitiesUseCase: loadCitiesUseCase)
        let newsVC = CitySelectorVC(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(newsVC, animated: false)
    }

    func citySearch() {
        let repository = CityNamesRepository(fileName: "citties", fileType: "json")
        let loadCitiesNamesUseCase = LoadCitiesNamesUseCase(cityNamesRepository: repository)
        let viewModel =  CitySearchViewModel(loadCitiesNamesUseCase: loadCitiesNamesUseCase)
        let citySearchVC = CitySearchVC(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(citySearchVC, animated: true)
    }

    func weatherDetails(city: String) {
        let weatherRepository = WeatherRepository(network: Network(), coreDataManager: CoreDataManager(modelName: "weatherApp"))
        let getCityWeatherUseCase = GetCityWeatherUseCase(weatherRepository: weatherRepository, city: city)
        let viewModel =  WeatherDetailsViewModel(getCityWeatherUseCase: getCityWeatherUseCase, city: city)
        let vCont = WeatherDetailsVC(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(vCont, animated: true)
    }

    func weatherDetails(weather: WeatherInfo) {
        let viewModel =  WeatherDetailsViewModel(weather: weather)
        let vCont = WeatherDetailsVC(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(vCont, animated: true)
    }

    func cityHistory(city: String) {
        let weatherRepo = WeatherRepository(network: Network(), coreDataManager: CoreDataManager(modelName: "weatherApp"))
        let viewModel =  CityHistoryVCViewModel(weatherRepository: weatherRepo, city: city)
        let vCont = CityHistoryVC(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(vCont, animated: true)
    }

}
