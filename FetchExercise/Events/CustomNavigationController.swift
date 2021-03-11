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

        let backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        navigationBar.barTintColor = backgroundColor
        navigationBar.tintColor = .white
        navigationBar.barStyle = .black
        
        if #available(iOS 13.0, *) {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithTransparentBackground()
            coloredAppearance.backgroundColor = backgroundColor
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

            let button = UIBarButtonItemAppearance(style: .plain)
            button.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            coloredAppearance.buttonAppearance = button

            let done = UIBarButtonItemAppearance(style: .done)
            done.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            coloredAppearance.doneButtonAppearance = done
            
            navigationBar.standardAppearance = coloredAppearance
            navigationBar.scrollEdgeAppearance = coloredAppearance
        }
    }
}
