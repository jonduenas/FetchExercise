//
//  Event.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import Foundation

struct Event {
    let id: Int
    let title: String
    let shortTitle: String
    let url: URL
    let images: [ImageSize: String]
    let dateTimeLocal: EventDateTime
    let city: String
    let state: String
    let country: String
    let isFavorite: Bool = false
}

enum EventDateTime {
    case tbd
    case dateTime(date: String, time: String)
}

enum ImageSize: String {
    case large, huge, small, medium
}
