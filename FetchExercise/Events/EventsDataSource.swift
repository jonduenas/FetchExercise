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
    var filteredEvents = [Event]()
    var isFiltering: Bool = false
    
    init(events: [Event]) {
        self.events = events
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredEvents.count
        }
        
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath) as! EventCell
        
        let event: Event
        if isFiltering {
            event = filteredEvents[indexPath.row]
        } else {
            event = events[indexPath.row]
        }
        
        if let imageURL = event.images[.huge] {
            cell.eventImageView.contentMode = .scaleAspectFill
            cell.eventImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.eventImageView.sd_setImage(with: URL(string: imageURL))
        } else {
            if #available(iOS 13.0, *) {
                cell.eventImageView.image = UIImage(systemName: "photo.on.rectangle")
                cell.eventImageView.contentMode = .scaleAspectFit
            }
        }
        
        cell.updateCell(with: event)
        
        return cell
    }
}
