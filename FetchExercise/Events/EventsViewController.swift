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
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        configureActivityIndicator()
        tableView.delegate = self
        
        setState(loading: true)
        loadEvents()
    }
    
    private func configureActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator = view.activityIndicator(style: .large, center: view.center)
        } else {
            activityIndicator = view.activityIndicator(style: .gray, center: view.center)
        }
        
        view.addSubview(activityIndicator)
    }
    
    private func loadEvents() {
        mobileService = MobileService()
        mobileService?.fetchEvents(page: 1, completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let events):
                DispatchQueue.main.async {
                    self?.setState(loading: false)
                    self?.dataSource = EventsDataSource(events: events)
                    self?.tableView.dataSource = self?.dataSource
                    self?.tableView.reloadData()
                }
            }
        })
    }
    
    private func setState(loading: Bool) {
        tableView.isHidden = loading
        
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
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
