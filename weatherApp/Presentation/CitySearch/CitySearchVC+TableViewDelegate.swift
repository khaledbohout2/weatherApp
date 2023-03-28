//
//  CitySearchVC+TableViewDelegate.swift
//  weatherApp
//
//  Created by Khaled Bohout on 14/03/2023.
//

import UIKit

extension CitySearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CitySearchCell = tableView.forceDequeueCell(identifier: CitySearchCell.identifier)
        cell.displayTitle(text: viewModel.filteredNames[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.weatherDetails(city: viewModel.filteredNames[indexPath.row])
    }

}
