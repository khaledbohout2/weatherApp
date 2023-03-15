//
//  AppDelegate.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        let coordinator = MainCoordinator(navigationController: navController)
        coordinator.start()
        window?.makeKeyAndVisible()

        return true
    }

}

