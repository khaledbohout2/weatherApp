//
//  CitySelectorVC.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import Combine
import UIKit

class CitySelectorVC: BaseVC<TableView> {

    var viewModel: CitySelectorViewModel
    var coordinator: MainCoordinator
    private var repository: WeatherRepositoryDelegate
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: CitySelectorViewModel,
         repository: WeatherRepositoryDelegate,
         coordinator: MainCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setDelegates(self)
        bindViewModel()
    }

    func stateValueHandler() -> (CitySelectorViewModelState) -> Void {
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

        viewModel.$cities
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cities in
                self?.mainView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

}
