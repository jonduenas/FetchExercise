//
//  EventData.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import Foundation

struct EventData: Codable {
    let id: Int
    let title: String
    let url: String
    let datetimeLocal: String
    let timeTbd: Bool
    let venue: Venue
    let performers: [Performer]
    
    struct Venue: Codable {
        let id: Int
        let city: String
        let state: String
        let country: String
        let address: String
        let extendedAddress: String?
        let name: String
        let url: String
    }

    struct Performer: Codable {
        let id: Int
        let name: String
        let url: String
        let image: String
        let images: [String: String]
    }
}
