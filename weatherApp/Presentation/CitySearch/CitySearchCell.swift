//
//  CitySearchCell.swift
//  weatherApp
//
//  Created by Khaled Bohout on 14/03/2023.
//

import UIKit

class CitySearchCell: UITableViewCell {

    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
        contentView.addSubview(titleLbl)

        titleLbl.anchor(.leading(contentView.leadingAnchor, constant: 14),
                        .top(contentView.topAnchor, constant: 15),
                        .bottom(contentView.bottomAnchor, constant: 15),
                        .trailing(contentView.trailingAnchor, constant: 20))
    }

    func displayTitle(text: String) {
        titleLbl.text = text
    }

}
