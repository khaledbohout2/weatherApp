//
//  CityHistoryVC+TableViewDelegate.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import UIKit

extension CityHistoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weathers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityHistoryCell = tableView.forceDequeueCell(identifier: CityHistoryCell.identifier)
        cell.displayDate(text: viewModel.weathers[indexPath.row].date)
        cell.displayWeather(weather: viewModel.weathers[indexPath.row].WeatherDescription + ",  \(viewModel.weathers[indexPath.row].temp)")
        return cell
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        coordinator.weatherDetails(weather: viewModel.weathers[indexPath.row])
    }

}
