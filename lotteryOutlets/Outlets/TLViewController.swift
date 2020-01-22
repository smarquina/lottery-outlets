//
//  TLViewController.swift
//  lotteryOutlets
//
//  Created by Sergio Martín on 21/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import UIKit

class TLViewController: UIViewController {

    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor.TLColor.green, tintColor: .white, title: "Administraciones", preferredLargeTitle: false)
    }
}
