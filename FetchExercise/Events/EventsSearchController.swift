//
//  EventsSearchController.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/10/21.
//

import UIKit

class EventsSearchController: UISearchController {

    override func viewDidLoad() {
        super.viewDidLoad()

        obscuresBackgroundDuringPresentation = false
        hidesNavigationBarDuringPresentation = true
        searchBar.barTintColor = .white
        searchBar.tintColor = .white
        
        // SearchBar text
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.textColor = .white
        } else {
            let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideUISearchBar?.textColor = UIColor.white
        }
    }
}
