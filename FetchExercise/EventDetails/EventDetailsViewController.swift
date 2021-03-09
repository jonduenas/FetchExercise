//
//  EventDetailsViewController.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

class EventDetailsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var coordinator: EventsCoodinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
