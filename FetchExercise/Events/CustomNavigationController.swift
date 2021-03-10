//
//  CustomNavigationController.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/10/21.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = #colorLiteral(red: 0.009025877342, green: 0.2521837652, blue: 0.4460360408, alpha: 1)
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.tintColor = .white
    }
}
