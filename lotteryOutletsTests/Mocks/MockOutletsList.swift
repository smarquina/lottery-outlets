//
//  MockOutletsList.swift
//  lotteryOutletsTests
//
//  Created by Sergio Martín on 21/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import Foundation
@testable import lotteryOutlets

class MockOutletsList: OutletsListPresenter {

    /// Get outlets from mocked json file
    /// - Parameters:
    ///   - successHandler: Handler for success response decoding
    ///   - errorHandler: Handler for errror response decoding
    override func fetchData(successHandler: @escaping () -> Void, errorHandler: @escaping (_ error: Error) -> Void) {
        let url = Bundle(for: type(of: self)).url(forResource: "outlets", withExtension: "json")
        guard let jsonData = url else{return}
        guard let data = try? Data(contentsOf: jsonData) else { return }
        do {
            let outlets: [Outlet] = try JSONDecoder().decode([Outlet].self, from: data)
            self.setData(outlets)
            successHandler()
        }
        catch let error as NSError {
            errorHandler(error)
        }
    }
}
