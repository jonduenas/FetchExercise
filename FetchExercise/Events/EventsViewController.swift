//
//  EventsViewController.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import UIKit

class EventsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = EventsSearchController(searchResultsController: nil)
    
    weak var coordinator: EventsCoodinator?
    var mobileService: MobileService_Protocol = MobileService()
    var alertPresenter: AlertPresenter_Proto = AlertPresenter()
    var dataSource: EventsDataSource?
    var favorites = Favorites()
    var activityIndicator: UIActivityIndicatorView!
    var isFetchInProgress: Bool = false
    var isFiltering: Bool = false {
        didSet {
            dataSource?.isFiltering = isFiltering
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        configureSearchBar()
        configureActivityIndicator()
        tableView.delegate = self
        loadEvents()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: .reload, object: nil)
    }
    
    @objc private func reloadTableData() {
        tableView.reloadData()
    }
    
    private func configureActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator = view.activityIndicator(style: .large, center: view.center)
        } else {
            activityIndicator = view.activityIndicator(style: .gray, center: view.center)
        }
        
        view.addSubview(activityIndicator)
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Events"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.isActive = false
    }
    
    private func loadEvents() {
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        setState(loading: true)
        
        mobileService.fetchEvents(page: 1, query: nil, ids: nil, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self.alertPresenter.present(from: self,
                                                title: "Unexpected Error",
                                                message: "There was an error loading events: \(error.localizedDescription)",
                                                dismissButtonTitle: "OK")
                    self.isFetchInProgress = false
                }
            case .success(let events):
                DispatchQueue.main.async {
                    print("Successfully loaded events")
                    self.dataSource = EventsDataSource(events: events, favorites: self.favorites)
                    self.isFetchInProgress = false
                    self.setState(loading: false)
                    self.tableView.dataSource = self.dataSource
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    private func filterContentForSearchText(_ searchText: String, category: SearchCategory? = .all) {
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        setState(loading: true)
        isFiltering = true
        
        var categoryIDs = [Int]()
        if category == .favorites {
            categoryIDs = favorites.getFavorites()
        }
        
        mobileService.fetchEvents(page: 1, query: searchText, ids: categoryIDs, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self.alertPresenter.present(from: self,
                                                title: "Unexpected Error",
                                                message: "There was an error loading events: \(error.localizedDescription)",
                                                dismissButtonTitle: "OK")
                    self.isFetchInProgress = false
                }
            case .success(let filteredEvents):
                DispatchQueue.main.async {
                    print("Successfully loaded filtered events")
                    self.isFetchInProgress = false
                    self.dataSource?.filteredEvents = filteredEvents
                    self.setState(loading: false)
                    self.tableView.reloadData()
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
        
        let event: Event?
        if isFiltering {
            event = dataSource?.filteredEvents[indexPath.row]
        } else {
            event = dataSource?.events[indexPath.row]
        }
        
        if let _event = event {
            coordinator?.showDetails(_event, favorites: favorites)
        }
    }
}

extension EventsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.count == 0 && isFiltering == true {
            isFiltering = false
        }
    }
}

extension EventsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchController.searchBar.text!.count > 0 else { return }
        
        filterContentForSearchText(searchBar.text!)
    }
}

extension Notification.Name {
    static let reload = Notification.Name("reload")
}
