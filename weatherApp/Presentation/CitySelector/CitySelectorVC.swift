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
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: CitySelectorViewModel,
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
        mainView.tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
        mainView.setDelegates(self)
        bindViewModel()
        viewModel.getCities()
        addPlusNavButton().addTarget { [weak self] in
            self?.coordinator.citySearch()
        }
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
