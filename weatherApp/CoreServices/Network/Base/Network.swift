//
//  Network.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import Foundation
import Alamofire
import Combine

typealias AFResult<T> = Future<T,Error>

protocol NetworkProtocol {
    func request<T>(_ request: URLRequestConvertible) -> AFResult<T> where T: Codable
    func cancelAllRequests()
}

class Network: RequestInterceptor {

#if DEBUG
    fileprivate let willPrint = true
#else
    fileprivate let willPrint = false
#endif

    fileprivate let networkMiddleware = NetworkMiddleware()

    fileprivate lazy var manager: Session = networkMiddleware.sessionManager

    func cancelAllRequests() {
        manager.session.getAllTasks { tasks in tasks.forEach { $0.cancel() } }
    }
}

extension Network: NetworkProtocol {
    func request<T>(_ request: URLRequestConvertible) -> AFResult<T> where T: Codable {
        return Future<T,Error> { promise in
            self.manager.request(request)
                .validate()
                .responseDecodable(of: T.self) { (response) in
                    if self.willPrint {
                        debugPrint("=======DEBUG=NETWORK=============Request URL")
                        debugPrint(response.request?.url?.absoluteString as Any)
                        debugPrint("=======DEBUG=NETWORK=============Request RESPONSE")
                        debugPrint(response)
                    }
                    switch response.result {
                    case .failure(let error):
                        promise(.failure(error))
                        break
                    case .success(let data):
                        promise(.success(data))
                        break
                    }
                }
        }
    }
}

fileprivate extension NSError {
    class func create(description: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
