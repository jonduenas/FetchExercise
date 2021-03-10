//
//  EventsCoordinator.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

class EventsCoodinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = EventsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetails(_ event: Event) {
        let vc = EventDetailsViewController.instantiate()
        vc.coordinator = self
        vc.event = event
        navigationController.pushViewController(vc, animated: true)
    }
}
