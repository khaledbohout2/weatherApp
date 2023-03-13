//
//  CityCell.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

class CityCell: UITableViewCell {

    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .appBase100
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
}
