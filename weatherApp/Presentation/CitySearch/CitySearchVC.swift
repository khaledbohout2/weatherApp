//
//  CitySearchVC.swift
//  weatherApp
//
//  Created by Khaled Bohout on 14/03/2023.
//

import UIKit
import Combine

class CitySearchVC: BaseVC<CitySearchView> {

    var viewModel: CitySearchViewModel
    var coordinator: MainCoordinator
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: CitySearchViewModel,
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
        mainView.tableView.register(CitySearchCell.self, forCellReuseIdentifier: CitySearchCell.identifier)
        mainView.setDelegates(self)
        bindViewModel()
        viewModel.getCities()
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

        viewModel.$filteredNames
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cities in
                self?.mainView.tableView.reloadData()
            }.store(in: &cancellables)

        mainView.searchTextField.textPublisher
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] in
                self?.viewModel.search(query: $0)
            }
            .store(in: &cancellables)
    }

}


