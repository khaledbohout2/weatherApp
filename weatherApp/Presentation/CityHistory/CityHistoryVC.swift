//
//  CityHistoryVC.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Combine
import UIKit

class CityHistoryVC: BaseVC<TableView> {

    var viewModel: CityHistoryVCViewModel
    var coordinator: MainCoordinator
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: CityHistoryVCViewModel,
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
        mainView.tableView.register(CityHistoryCell.self, forCellReuseIdentifier: CityHistoryCell.identifier)
        mainView.setDelegates(self)
        bindViewModel()
        addPlusNavButton().addTarget { [weak self] in
            self?.coordinator.citySearch()
        }
    }

    func stateValueHandler() -> (CityHistoryVCViewModelState) -> Void {
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

        viewModel.$weathers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weathers in
                self?.mainView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

}
