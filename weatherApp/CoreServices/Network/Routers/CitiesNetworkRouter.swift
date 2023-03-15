//
//  CitiesNetworkRouter.swift
//  weatherApp
//
//  Created by Khaled Bohout on 14/03/2023.
//


import Alamofire

enum CitiesNetworkRouter: URLRequestConvertible {
    case getForcast(city: String)
    case autocomplete(text: String)
    case getCityWeather(city: String)

    var method: HTTPMethod {
        switch self {
        case .getForcast:
            return .get
        case .autocomplete:
            return .get
        case .getCityWeather:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .getForcast(let city):
            return ["key": Constants.aPiKey, "q": city, "days": "3"]
        case .autocomplete(let text):
            return ["key": Constants.aPiKey, "q": text]
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
        case .getForcast:
            return "forecast.json"
        case .autocomplete:
            return "search.json"
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
