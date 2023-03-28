//
//  WeatherDetailsVC.swift
//  weatherApp
//
//  Created by Khaled Bohout on 24/03/2023.
//

import Foundation
import Combine

class WeatherDetailsVC: BaseVC<WeatherDetailsView> {

    var viewModel: WeatherDetailsViewModel
    var coordinator: MainCoordinator
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: WeatherDetailsViewModel,
         coordinator: MainCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.getWeatherInfo()
    }

    func stateValueHandler() -> (WeatherDetailsViewModelState) -> Void {
        return { [weak self] state in
            switch state {
            case .loading:
                self?.startLoading()
            case .finishedLoading:
                self?.stopLoading()
            case .error(let error):
                self?.stopLoading()
                self?.showSelfDismissingAlert(error.localizedDescription)
            }
        }
    }

    private func bindViewModel() {
        let stateValueHandler = stateValueHandler()

        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &cancellables)

        viewModel.$weatherInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weatherInfo in
                self?.mainView.dateLbl.text = "weather information for \(self?.viewModel.city ?? "") received on " + (Date().toString() ?? "")
                self?.mainView.descriptionValueLbl.text = weatherInfo?.WeatherDescription
                self?.mainView.tempValueLbl.text = "\(weatherInfo?.temp ?? 0)C"
                self?.mainView.humadityValueLbl.text = "\(weatherInfo?.humidity ?? 0)%"
                self?.mainView.windSpeedValueLbl.text = "\(weatherInfo?.windSpeed ?? 0)kmh"
                self?.mainView.weatherIcon.load(with: "\(Constants.link)/img/w/\(weatherInfo?.iconID ?? "").png")
            }
            .store(in: &cancellables)
    }

}
