//
//  EventCell.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let reuseIdentifier = String(describing: EventCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventImageView.layer.cornerRadius = 10
    }
    
    func updateCell(with event: Event) {
        nameLabel.text = event.shortTitle
        cityLabel.text = "\(event.city), \(event.state)"
        
        switch event.dateTimeLocal {
        case .tbd:
            dateLabel.text = "TBD"
            timeLabel.isHidden = true
        case .dateTime(date: let date, time: let time):
            dateLabel.text = date
            timeLabel.text = time
            timeLabel.isHidden = false
        }
    }
}
