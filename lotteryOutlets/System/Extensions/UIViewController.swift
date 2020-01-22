//
//  UIViewController.swift
//  lotteryOutlets
//
//  Created by Sergio Martín on 21/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgoundColor

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title

        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }

    /// Shows an alert with only a cancel button that dismisses itself.
    ///
    /// - Parameters:
    ///   - title: The title to show.
    ///   - message: The content of the message displayed.
    func showSimpleMessage(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message:message,
                                      preferredStyle: .alert)
        self.present(alert, animated: true)
    }
}
