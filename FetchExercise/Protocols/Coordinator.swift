//
//  Coordinator.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
