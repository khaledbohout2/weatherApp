//
//  UITableView+forceDequeueCell.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

extension UITableView {
    func forceDequeueCell<T: UITableViewCell>(identifier: String) -> T {
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
