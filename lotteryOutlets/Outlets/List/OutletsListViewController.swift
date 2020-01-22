//
//  OutletsListViewController.swift
//  lotteryOutlets
//
//  Created by Sergio Martín on 17/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import UIKit

class OutletsListViewController: TLViewController {

    @IBOutlet private weak var outletsTable: UITableView!
    @IBOutlet private weak var outletsCounterLabel: UILabel!
    @IBOutlet private weak var veilView: UIView!

    var presenter: OutletsListPresenter!

    //MARK: View' Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()

         NotificationCenter.default.addObserver(self, selector: #selector(self.VeilViewVisibility(_:)), name: .VisibilityVeilView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: .RefreshListView, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.post(name: .VisibilityVeilView, object: true)
        self.presenter.fetchData(
            successHandler: {
                NotificationCenter.default.post(name: .VisibilityVeilView, object: false)
        },
            errorHandler: { (error) in
                NotificationCenter.default.post(name: .VisibilityVeilView, object: false)
                self.showSimpleMessage(title: "Error", message: error.localizedDescription)
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: .VisibilityVeilView, object: nil)
        NotificationCenter.default.removeObserver(self, name: .RefreshListView, object: nil)
    }

    //MARK: Private [Method]
    private func setup() {
        self.presenter = OutletsListPresenter()
        outletsTable.dataSource = presenter
        outletsTable.delegate = presenter
    }

    /// Set visibility for veil view
    /// - Parameter notification: notification payload
    @objc private func VeilViewVisibility(_ notification:Notification) {
        self.veilView.isHidden = !((notification.object as? Bool) ?? false)
    }

    @objc private func reloadTable() {
        self.outletsCounterLabel.text = String(self.presenter.getData().count)
        self.outletsTable.reloadData()
    }

}

//MARK: - UISearchBarDelegate methods
extension OutletsListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.presenter.clearData()
        } else {
            self.presenter.filterData(searchText)
        }
    }

    // Asks the delegate if editing should begin in the specified search bar.
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        NotificationCenter.default.post(name: .VisibilityVeilView, object: true)
    }

    // Asks the delegate if editing should stop in the specified search bar.
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        NotificationCenter.default.post(name: .VisibilityVeilView, object: false)
    }
}
