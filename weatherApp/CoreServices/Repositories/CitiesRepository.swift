//
//  CitiesRepository.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import Foundation

protocol CitiesRepositoryDelegate: AnyObject {
    func autocomplete(text: String) -> AFResult<[City]>
}

class CitiesRepository: CitiesRepositoryDelegate {
    private var network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }

    func autocomplete(text: String) -> AFResult<[City]> {
        let route = CitiesNetworkRouter.autocomplete(text: text)
        return network.request(route)
    }
}
