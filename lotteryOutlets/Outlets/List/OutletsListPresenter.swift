//
//  OutletsListPresenter.swift
//  lotteryOutlets
//
//  Created by Sergio Martín on 17/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import Foundation
import UIKit

protocol OutletsListPresenterProtocol {
    func fetchData(successHandler: @escaping () -> Void, errorHandler: @escaping (_ error: Error) -> Void)
    func clearData()
    func getData() -> [Outlet]
    func setData(_ outlets: [Outlet])
}

class OutletsListPresenter: NSObject, OutletsListPresenterProtocol {

    private var currentOutlets: [Outlet] = [] {
        didSet {
            NotificationCenter.default.post(name: .RefreshListView, object: nil)
        }
    }
    private var fetchedOutlets: [Outlet] = []

    /// Fetch from server current outlets
    /// - Parameters:
    ///   - successHandler: Handler for success response decoding
    ///   - errorHandler: Handler for errror response decoding
    func fetchData(successHandler: @escaping () -> Void, errorHandler: @escaping (_ error: Error) -> Void) {
        NetworkManager.sharedInstance.listOutlets(
            successHandler: { (outlets) in
                self.setData(outlets)
                successHandler() //Refresh table
        },
            errorHandler: { (error, validationMessages) in
                self.clearData()
                errorHandler(error)
        })
    }

    /// Set new Outlets data
    /// - Parameter outlets: outlets array
    func setData(_ outlets: [Outlet]) {
        self.fetchedOutlets = outlets
        self.currentOutlets = outlets
    }

    /// Clear current outlets
    func clearData() {
        self.currentOutlets = self.fetchedOutlets
    }


    /// Get current outlets
    func getData() -> [Outlet] {
        return self.currentOutlets
    }

    func filterData(_ searchedString: String) {
        self.currentOutlets = self.fetchedOutlets.filter{
            let searchedCity = ($0.city ?? "")
                .lowercased()
                .contains(searchedString.lowercased())

            let searchedProvince = ($0.province ?? "")
                .lowercased()
                .contains(searchedString.lowercased())

            return searchedCity || searchedProvince
        }
    }
}

extension OutletsListPresenter: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //At least 1 because of the empty cell
        return  self.currentOutlets.isEmpty ? 1 : self.currentOutlets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell

        if self.currentOutlets.isEmpty {
            cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.EmptyListCell.rawValue, for: indexPath)
        } else {
            let outletCell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.OutletListCell.rawValue, for: indexPath) as! OutletCell
            let data = self.currentOutlets[indexPath.row]

            if let urlPhoto = data.urlPhoto {
                outletCell.outletImage.kf.setImage(with: URL.init(string: urlPhoto))
            } else {
                outletCell.outletImage.image = UIImage.init(named: "no_administraciones")
            }

            outletCell.outletTitle.text = data.name
            outletCell.outletAddress.text = data.city ?? ""

            if let province = data.province {
                outletCell.outletAddress.text! += " (\(province))"
            }
            cell = outletCell
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.currentOutlets.isEmpty
            ? tableView.bounds.size.height/2
            : UITableView.automaticDimension
    }
}



/// Cell image class used in table
class OutletCell: UITableViewCell {
    @IBOutlet var outletImage: UIImageView!
    @IBOutlet var outletTitle: UILabel!
    @IBOutlet var outletAddress: UILabel!
}

enum CellsIdentifiers: String {
    case OutletListCell = "OutletListCellIdentifier"
    case EmptyListCell = "EmptyListCellIdentifier"
}
