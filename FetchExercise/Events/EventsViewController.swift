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
    var dataSource: EventsDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        loadEvents()
    }
    
    private func loadEvents() {
        mobileService = MobileService()
        mobileService?.fetchEvents(page: 1, completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let events):
                DispatchQueue.main.async {
                    self?.dataSource = EventsDataSource(events: events)
                    self?.tableView.dataSource = self?.dataSource
                    self?.tableView.reloadData()
                }
            }
        })
    }
}

extension EventsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let event = dataSource?.events[indexPath.row] {
            coordinator?.showDetails(event)
        }
    }
}
