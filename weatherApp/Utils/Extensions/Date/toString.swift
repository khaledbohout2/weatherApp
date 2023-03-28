//
//  toString.swift
//  weatherApp
//
//  Created by Khaled Bohout on 25/03/2023.
//

import Foundation
extension Date{
    func toString(format: String? = "MM.dd.yyyy - HH:mm") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
