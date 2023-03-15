//
//  CityNamesRepository.swift
//  weatherApp
//
//  Created by Khaled Bohout on 15/03/2023.
//

import Foundation
import Combine

protocol CityNamesRepositoryDelegate {
    func loadCities() -> AnyPublisher<[String], Error>
}

struct CityNamesRepository: CityNamesRepositoryDelegate {

    private let fileName: String
    private let fileType: String
    private let jsonFile: LoadLocalFile
    init(fileName: String, fileType: String) {
        self.fileName = fileName
        self.fileType = fileType
        self.jsonFile = LoadLocalFile(fileName: fileName, fileType: fileType)
    }

    func loadCities() -> AnyPublisher<[String], Error> {
        jsonFile.loadCodable(of: [String].self)
    }

}

