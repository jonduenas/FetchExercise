//
//  EventsDataSource.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

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
        
        cell.updateCell(with: events[indexPath.row])
        
        return cell
    }
}
