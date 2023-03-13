//
//  AppDelegate+appearance.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit

extension AppDelegate {
    func setAppearance() {
        setNavigationAppearance()
        setImageViewAppearance()
    }

    func setNavigationAppearance() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 22)
            ]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.shadowColor = .clear
            navBarAppearance.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().compactAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        } else {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().backgroundColor = .white
        }
        UINavigationBar.appearance().isTranslucent = false
    }

    func setImageViewAppearance() {
        UIImageView.appearance().contentMode = .scaleAspectFill
        UIImageView.appearance().clipsToBounds = true
    }
}
