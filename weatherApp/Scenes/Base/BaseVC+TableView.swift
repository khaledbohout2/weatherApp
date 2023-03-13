//
//  BaseVC+TableView.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

@objc protocol RefreshDelegate: AnyObject {
    func refresh()
}

class TableView: BaseView {

    weak var refreshDelegate: RefreshDelegate?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.refreshControl = refreshControl
        return tableView
    }()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(refreshDelegate, action: #selector(refreshDelegate?.refresh), for: .valueChanged)
        return refreshControl
    }()

    lazy var noContentLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.isHidden = true
        return label
    }()

    override func setupView() {
        addSubview(tableView)
        tableView.fillSuperviewSafeArea()
        addSubview(noContentLbl)
        noContentLbl.centerInSuperview()
    }

    func setDelegates(_ delegate: Any) {
        tableView.delegate = delegate as? UITableViewDelegate
        tableView.dataSource = delegate as? UITableViewDataSource
        refreshDelegate = delegate as? RefreshDelegate
    }
}

