//
//  CityHistoryCell.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import UIKit

class CityHistoryCell: UITableViewCell {

    lazy var dateLbl: UILabel = {
        let label = UILabel()
        label.textColor = .appBase100
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    lazy var weatherLbl: UILabel = {
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
        accessoryType = .detailDisclosureButton

        contentView.addSubview(dateLbl)
        dateLbl.anchor(.leading(contentView.leadingAnchor, constant: 14),
                       .top(contentView.topAnchor, constant: 15),
                       .trailing(contentView.trailingAnchor, constant: 20))

        contentView.addSubview(weatherLbl)
        weatherLbl.anchor(.leading(contentView.leadingAnchor, constant: 10),
                          .trailing(contentView.trailingAnchor, constant: 10),
                          .top(dateLbl.bottomAnchor, constant: 10),
                          .bottom(contentView.bottomAnchor, constant: 10))
    }

    func displayDate(text: String) {
        dateLbl.text = text
    }

    func displayWeather(weather: String) {
        weatherLbl.text = weather
    }

}
