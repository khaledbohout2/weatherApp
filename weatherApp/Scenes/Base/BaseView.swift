//
//  BaseView.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupAppearance()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func setupAppearance() {
        backgroundColor = .white
    }

    func setupView() {}
}
