//
//  NetworkManager.swift
//  lotteryOutlets
//
//  Created by Sergio Martín on 20/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire
import SystemConfiguration


class NetworkManager {

    static var sharedInstance: NetworkManager = NetworkManager()

    private var networkConfiguration: NetworkConfiguration!
    private var sessionManager: SessionManager!

    /// Alias for the error handler
    typealias ErrorHandler = (_ error: Error, _ validationErrors: [String]?) -> Void

    private init () {
        self.networkConfiguration = NetworkConfiguration.instance
        self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }

    /// Request the login information for a concrete user.
    ///
    /// - Parameters:
    ///   - successHandler: Closure to execute when the request ends successfully.
    ///   - errorHandler: Closure to execute when the request finish with errors.
    func listOutlets(successHandler: @escaping ([Outlet]) -> Void, errorHandler: @escaping ErrorHandler) {
        let networkConfig = self.networkConfiguration!
        self.request(url: networkConfig.baseUrl + networkConfig.urls.listOutlets,
                     method: .get,
                     successHandler: successHandler,
                     errorHandler: errorHandler)
    }


    /// -Manage network requests
    /// - Parameters:
    ///   - url: url string
    ///   - method: http method
    ///   - parameters: parameters dictionary
    ///   - successHandler: Handler for success response decoding
    ///   - errorHandler: Handler for errror response decoding
    private func request<T: Decodable>(url: String,
                                       method: HTTPMethod,
                                       parameters: Parameters? = nil,
                                       successHandler: @escaping (T) -> Void,
                                       errorHandler: @escaping ErrorHandler) {

        self.sessionManager.request(url,
                                    method: method,
                                    parameters: parameters,
                                    encoding: URLEncoding.default)
            .validate(statusCode: [200])
            .responseDecodableObject(keyPath: nil,
                                     decoder: JSONDecoder(),
                                     completionHandler: { (response: DataResponse<T>) in
                                        switch response.result {
                                        case let .success(result):
                                            successHandler(result)
                                        case let .failure(error):
                                            errorHandler(error, [error.localizedDescription])

                                            //TODO: - manage NSURLErrorTimedOut if needed
                                        }
            })
    }

}
