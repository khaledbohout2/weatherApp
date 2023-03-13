//
//  UIViewController+toNavigation.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

extension UIViewController {
    func toNavigation() -> UINavigationController {
        let nav =  UINavigationController(rootViewController: self)
        return nav
    }
}
