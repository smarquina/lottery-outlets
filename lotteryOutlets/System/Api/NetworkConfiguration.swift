//
//  NetworkConfiguration.swift
//  lotteryOutlets
//
//  Created by Sergio Martín on 17/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import Foundation

struct NetworkConfiguration: Decodable {

    /// Hold for the unique instance of the class.
    static var instance: NetworkConfiguration = NetworkConfiguration.load()

    /// Property that holds all of the urls that the application should manage.
    let urls: ServerURLs

    let baseUrl: String

    /// Loads the associated data to this class
    ///
    /// - Returns: The information of the URLs itself.
    private static func load() -> NetworkConfiguration {
        let url = Bundle.main.url(forResource: String(describing: NetworkConfiguration.self), withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(NetworkConfiguration.self, from: data)
    }

    /// Set of all the associated URLs.
    struct ServerURLs: Decodable {

        let listOutlets: String

    }
}
