//
//  UITableViewCell+identifier.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
