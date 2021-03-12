//
//  EventCell.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var faveImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let reuseIdentifier = String(describing: EventCell.self)
    var eventIsFave: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureImageViews()
    }
    
    func updateCell(with event: Event) {
        nameLabel.text = event.shortTitle
        cityLabel.text = "\(event.city), \(event.state)"
        
        faveImageView.isHidden = !eventIsFave
        
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
    
    func configureImageViews() {
        eventImageView.layer.cornerRadius = 10
        faveImageView.layer.shadowColor = UIColor.black.cgColor
        faveImageView.layer.shadowOpacity = 0.3
        faveImageView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        faveImageView.layer.shadowRadius = 2
    }
}
