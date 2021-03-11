//
//  EventDetailsViewController.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit
import SDWebImage

class EventDetailsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    weak var coordinator: EventsCoodinator?
    var event: Event?
    var favorites: Favorites?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let event = event else {
            print("Error loading event")
            return
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fave", style: .plain, target: self, action: #selector(didTapFavorite(_:)))
        setFaveImage()
        
        updateLabels(for: event)
        updateImageView(for: event)
    }
    
    private func updateImageView(for event: Event) {
        imageView.layer.cornerRadius = 10
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        var placeholderImage: UIImage?
        if #available(iOS 13.0, *) {
            placeholderImage = UIImage(systemName: "photo.on.rectangle")
        }
        if let imageURL = event.images[.huge] {
            imageView.sd_setImage(with: URL(string: imageURL))
        } else {
            imageView.sd_imageIndicator = nil
            imageView.contentMode = .center
            imageView.image = placeholderImage
        }
    }
    
    private func updateLabels(for event: Event) {
        headerLabel.text = event.shortTitle
        
        switch event.dateTimeLocal {
        case .tbd:
            dateLabel.text = "TBD"
        case .dateTime(date: let date, time: let time):
            dateLabel.text = "\(date) - \(time)"
        }
        
        cityLabel.text = "\(event.city), \(event.state)"
    }
    
    private func toggleFavorite() {
        guard let faves = favorites, let event = event else { return }
        
        if faves.contains(event) {
            faves.remove(event)
        } else {
            faves.add(event)
        }
        
        setFaveImage()
    }
    
    private func setFaveImage() {
        guard let faves = favorites, let event = event else { return }
        
        let notFaveImage = "star"
        
        if #available(iOS 13.0, *) {
            let image = faves.contains(event) ? UIImage(systemName: "star.fill") : UIImage(systemName: notFaveImage)
            navigationItem.rightBarButtonItem?.image = image
        } else {
            let image = faves.contains(event) ? UIImage(named: "star_fill") : UIImage(named: notFaveImage)
            navigationItem.rightBarButtonItem?.image = image
        }
    }
    
    @objc func didTapFavorite(_ barButton: UIBarButtonItem) {
        toggleFavorite()
    }
}
