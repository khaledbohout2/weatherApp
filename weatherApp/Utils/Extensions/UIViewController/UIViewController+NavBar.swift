//
//  UIViewController+NavBar.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

extension UIViewController {
    func addShareNavButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "share"), for: .normal)
        let menuBarItem = UIBarButtonItem(customView: button)
        var topParent: UIViewController = self
        while topParent.parent != nil,
              String(describing: type(of: topParent.parent!.self))
                != String(describing: UINavigationController.self) {
            topParent = topParent.parent!
        }
        topParent.navigationItem.rightBarButtonItem = menuBarItem
        return button
    }

    func setLeftNavTitle(_ title: String) {
        let label = UILabel()
        label.text = title
        label.textColor = .appBase100
        label.font = .systemFont(ofSize: 25)
        var topParent: UIViewController = self
        while topParent.parent != nil,
              String(describing: type(of: topParent.parent!.self))
                != String(describing: UINavigationController.self) {
            topParent = topParent.parent!
        }
        topParent.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    func setCenterNavTitle(_ title: String) {
        var topParent: UIViewController = self
        while topParent.parent != nil,
              String(describing: type(of: topParent.parent!.self))
                != String(describing: UINavigationController.self) {
            topParent = topParent.parent!
        }
        topParent.title = title
    }
}
