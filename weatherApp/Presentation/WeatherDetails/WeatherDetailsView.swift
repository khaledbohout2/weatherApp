//
//  WeatherDetailsView.swift
//  weatherApp
//
//  Created by Khaled Bohout on 24/03/2023.
//

import UIKit

class WeatherDetailsView: BaseView {

    lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()

    lazy var weatherIcon: UIImageView = {
        let image = UIImageView()
        return image
    }()

    lazy var descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Description: "
        return lbl
    }()

    lazy var descriptionValueLbl: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    lazy var tempLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Temp: "
        return lbl
    }()

    lazy var tempValueLbl: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    lazy var humadityLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Humadity: "
        return lbl
    }()

    lazy var humadityValueLbl: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    lazy var windSpeedLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "WindSpeed: "
        return lbl
    }()

    lazy var windSpeedValueLbl: UILabel = {
        let lbl = UILabel()
        return lbl
    }()


    override func setupView() {
        super.setupView()
        addSubview(dateLbl)
        dateLbl.anchor(.leading(leadingAnchor, constant: 10),
                       .trailing(trailingAnchor, constant: 10),
                       .top(topAnchor, constant: 10))

        addSubview(weatherIcon)
        weatherIcon.anchor(.leading(leadingAnchor, constant: 20),
                           .width(50),
                           .height(50),
                           .top(dateLbl.bottomAnchor, constant: 10))

        addSubview(descriptionLbl)
        descriptionLbl.anchor(.leading(leadingAnchor, constant: 10),
                              .top(weatherIcon.bottomAnchor, constant: 10))

        addSubview(descriptionValueLbl)
        descriptionValueLbl.anchor(.leading(descriptionLbl.trailingAnchor),
                                   .centerY(descriptionLbl.centerYAnchor))

        addSubview(tempLbl)
        tempLbl.anchor(.leading(leadingAnchor, constant: 10),
                       .top(descriptionLbl.bottomAnchor, constant: 10))

        addSubview(tempValueLbl)
        tempValueLbl.anchor(.leading(tempLbl.trailingAnchor),
                            .centerY(tempLbl.centerYAnchor))

        addSubview(humadityLbl)
        humadityLbl.anchor(.leading(leadingAnchor, constant: 10),
                           .top(tempLbl.bottomAnchor, constant: 10))

        addSubview(humadityValueLbl)
        humadityValueLbl.anchor(.leading(humadityLbl.trailingAnchor),
                                .centerY(humadityLbl.centerYAnchor))

        addSubview(windSpeedLbl)
        windSpeedLbl.anchor(.leading(leadingAnchor, constant: 10),
                            .top(humadityLbl.bottomAnchor, constant: 10))

        addSubview(windSpeedValueLbl)
        windSpeedValueLbl.anchor(.leading(windSpeedLbl.trailingAnchor, constant: 10),
                                 .centerY(windSpeedLbl.centerYAnchor))

    }
}
