//
//  URLRequestConvertible.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import Foundation
import Alamofire

protocol URLRequestConvertible: Alamofire.URLRequestConvertible {
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}
