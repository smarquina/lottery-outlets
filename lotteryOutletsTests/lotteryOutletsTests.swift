//
//  lotteryOutletsTests.swift
//  lotteryOutletsTests
//
//  Created by Sergio Martín on 17/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import XCTest
@testable import lotteryOutlets

class lotteryOutletsTests: XCTestCase {

    private var outletsPresenter: MockOutletsList!

    override func setUp() {
        super.setUp()

        self.outletsPresenter = MockOutletsList.init()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testOutlets() {

        self.outletsPresenter.fetchData(successHandler: {
            XCTAssertTrue(self.outletsPresenter.getData().count == 14)
        }, errorHandler: { (error) in
            XCTAssert(!self.outletsPresenter.getData().isEmpty, error.localizedDescription)
        })

        let buOutlets = self.testFilter("Bu")
        XCTAssertTrue(buOutlets.count == 3)
        XCTAssertTrue(buOutlets.first!.name == "demo")

        let arandaOutlet = buOutlets.first(where: {$0.city == "Aranda de Duero"})
        XCTAssertTrue(arandaOutlet != nil)
        XCTAssertTrue(arandaOutlet!.name == "23Arandadeduero")
        XCTAssertTrue(arandaOutlet!.identifier == "23arandadeduero")
        XCTAssertTrue(arandaOutlet!.enabled)
        XCTAssertTrue(arandaOutlet!.address == "C/ LA PALOMA Nº8 ENTREPLANTA 3")
        XCTAssertTrue(arandaOutlet!.zipCode == "09003")

        let alicanteOutlets = self.testFilter("Alicante")
        XCTAssertTrue(alicanteOutlets.count == 2)

        XCTAssertTrue(self.outletsPresenter.getData().count == 14)
    }

    private func testFilter(_ filter: String) -> [Outlet] {
        self.outletsPresenter.filterData(filter)
        let currentOutlets = self.outletsPresenter.getData()
        self.outletsPresenter.clearData()

        return currentOutlets
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
