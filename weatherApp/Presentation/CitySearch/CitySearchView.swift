//
//  CitySearchView.swift
//  weatherApp
//
//  Created by Khaled Bohout on 22/03/2023.
//

import UIKit

class CitySearchView: BaseView {
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .appSilver
        textField.makeRoundedCorner(cornerRadius: 8)
        textField.placeholder = "Search in cities.."
        textField.textColor = .appMainText
        textField.setLeftPaddingPoints(5)
        textField.setRightPaddingPoints(5)
        return textField
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func setupView() {
        super.setupView()
        addSubview(searchTextField)
        searchTextField.anchor(.leading(leadingAnchor, constant: 10),
                               .trailing(trailingAnchor, constant: 10),
                               .top(topAnchor),
                               .height(40))
        addSubview(tableView)
        tableView.anchor(.leading(leadingAnchor),
                         .trailing(trailingAnchor),
                         .top(searchTextField.bottomAnchor),
                         .bottom(bottomAnchor))
    }

    func setDelegates(_ delegate: Any) {
        tableView.delegate = delegate as? UITableViewDelegate
        tableView.dataSource = delegate as? UITableViewDataSource
    }
}
