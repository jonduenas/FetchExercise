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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

