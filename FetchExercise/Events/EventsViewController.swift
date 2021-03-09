//
//  EventsViewController.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

class EventsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: EventsCoodinator?
    var mobileService: MobileService_Protocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileService = MobileService()
        mobileService?.events(completion: { result in
            switch result {
            case .success(let events):
                print("Downloaded \(events.count) events")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

