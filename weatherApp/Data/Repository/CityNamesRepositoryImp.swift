//
//  CityNamesRepositoryImp.swift
//  weatherApp
//
//  Created by Khaled Bohout on 28/03/2023.
//

import Foundation
import Combine

struct CityNamesRepository: CityNamesRepositoryDelegate {

    private let fileName: String
    private let fileType: String
    private let jsonFile: LoadLocalFile
    init(fileName: String, fileType: String) {
        self.fileName = fileName
        self.fileType = fileType
        self.jsonFile = LoadLocalFile(fileName: fileName, fileType: fileType)
    }

    func loadCitiesNames() -> AnyPublisher<[String], Error> {
        jsonFile.loadCodable(of: [String].self)
    }

}

