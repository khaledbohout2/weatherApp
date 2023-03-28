//
//  WeatherNetworkRouter.swift
//  weatherApp
//
//  Created by Khaled Bohout on 14/03/2023.
//


import Alamofire

enum WeatherNetworkRouter: URLRequestConvertible {
    case getCityWeather(city: String)

    var method: HTTPMethod {
        switch self {
        case .getCityWeather:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .getCityWeather(let city):
            return ["q": city, "appid": Constants.aPiKey]
        }
    }

    var url: URL {
        return URL(string: "\(Constants.baseUrl)/")!
            .appendingPathComponent(path)
    }

    var path: String {
        switch self {
        case .getCityWeather:
            return "/weather"
        }
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }

}
