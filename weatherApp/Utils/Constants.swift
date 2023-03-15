//
//  Constants.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

class Constants {
#if DEBUG
    static let isUsingTestEnv = true
#else
    static let isUsingTestEnv = false
#endif

    static var link: String {

        if isUsingTestEnv {
            return "api.openweathermap.org" // test
        } else {
            return "api.openweathermap.org" // production
        }
    }

    static var baseUrl: String {
        return "https://\(link)/data/2.5"
    }

    static var aPiKey = "f5cb0b965ea1564c50c6f1b74534d823"
}
