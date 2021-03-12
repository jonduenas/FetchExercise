//
//  Favorites.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/11/21.
//

import Foundation

class Favorites {
    private var events: Set<Int>
    private let saveKey = "Favorites"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
                self.events = decoded
                return
            }
        }
        
        self.events = []
    }
    
    func contains(_ event: Event) -> Bool {
        events.contains(event.id)
    }
    
    func add(_ event: Event) {
        events.insert(event.id)
        save()
    }
    
    func remove(_ event: Event) {
        events.remove(event.id)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func getFavorites() -> [Int] {
        return Array(events)
    }
}
