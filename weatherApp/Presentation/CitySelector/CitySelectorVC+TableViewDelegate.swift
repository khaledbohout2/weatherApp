//
//  CitySelectorVC+TableViewDelegate.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

extension CitySelectorVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityCell = tableView.forceDequeueCell(identifier: CityCell.identifier)
        cell.displayTitle(text: viewModel.cities[indexPath.row].name)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.weatherDetails(city: viewModel.cities[indexPath.row].name)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        coordinator.cityHistory(city: viewModel.cities[indexPath.row].name)
    }

}
