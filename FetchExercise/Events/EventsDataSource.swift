//
//  EventsDataSource.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit
import SDWebImage

class EventsDataSource: NSObject, UITableViewDataSource {
    var events = [Event]()
    
    init(events: [Event]) {
        self.events = events
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath) as! EventCell
        
        if let imageURL = events[indexPath.row].images[.huge] {
            cell.eventImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.eventImageView.sd_setImage(with: URL(string: imageURL))
        } else {
            if #available(iOS 13.0, *) {
                cell.eventImageView.image = UIImage(systemName: "photo.on.rectangle")
            }
        }
        
        cell.updateCell(with: events[indexPath.row])
        
        return cell
    }
}
