//
//  MobileService.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import Foundation

protocol MobileService_Protocol {
    func fetchEvents(page: Int, query: String?, ids: [Int]?, completion: @escaping (Result<[Event], Error>) -> Void)
}

class MobileService: MobileService_Protocol {
    private let jsonDecoder: JSONDecoder
    private let sessionManager: URLSession
    let api_clientSecret = "6f5039b5ce58f24602b7d26450f0c74c3c1c4f8738c5e752a29bdde2e2548f62"
    let api_clientID = "MjE1ODQ0MDN8MTYxNTMyNTUwOC45ODI4ODA0"
    let api_endpoint = URL(string: "https://api.seatgeek.com/2")!
    
    init(sessionManager: URLSession = URLSession.shared) {
        self.sessionManager = sessionManager
        self.jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchEvents(page: Int, query: String?, ids: [Int]?, completion: @escaping (Result<[Event], Error>) -> Void) {
        let urlRequest = URLRequest(url: api_endpoint.appendingPathComponent(apiResource.events.rawValue))
        
        var parameters: [String: String] = [
            "client_id": api_clientID,
            "page": "\(page)",
            "per_page": "20"
        ]
        
        if let query = query, query != "" {
            let queryString = query.lowercased().replacingOccurrences(of: " ", with: "+")
            parameters["q"] = queryString
        }
        
        if let ids = ids, !ids.isEmpty {
            var idsString = ""
            for id in ids {
                idsString.append("\(id),")
            }
            let finalString = idsString.dropLast()
            parameters["id"] = String(finalString)
        }
        
        let encodedRequest = urlRequest.encode(with: parameters)
        
        sessionManager.dataTask(with: encodedRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let eventsList = try self.jsonDecoder.decode(EventsList.self, from: data)
                    let events = self.parse(eventsList)
                    completion(.success(events))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    private func parse(_ eventList: EventsList) -> [Event] {
        eventList.events.map { eventData -> Event in
            let images = eventData.performers.first?.images ?? [:]
            var imageDictionary = [ImageSize: String]()
            for image in images {
                guard let imageSize = ImageSize(rawValue: image.key) else { continue }
                imageDictionary[imageSize] = image.value
            }
            
            var eventDateTime: EventDateTime
            if eventData.timeTbd == false {
                if let date = eventData.datetimeLocal.convertToDate() {
                    let dateString = date.convertDateToString()
                    let timeString = date.convertTimeToString()
                    eventDateTime = .dateTime(date: dateString, time: timeString)
                } else {
                    eventDateTime = .tbd
                }
            } else {
                eventDateTime = .tbd
            }
            
            return Event(id: eventData.id,
                         title: eventData.title,
                         shortTitle: eventData.shortTitle,
                         url: URL(string: eventData.url)!,
                         images: imageDictionary,
                         dateTimeLocal: eventDateTime,
                         city: eventData.venue.city,
                         state: eventData.venue.state,
                         country: eventData.venue.country)
        }
    }
}

enum apiResource: String {
    case events, performers, venues
}

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: self)
    }
}

extension Date {
    func convertTimeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: self)
    }
}
