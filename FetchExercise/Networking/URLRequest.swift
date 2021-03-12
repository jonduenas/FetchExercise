//
//  URLRequest.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/9/21.
//

import Foundation

typealias Parameters = [String: String]

extension URLRequest {
    func encode(with parameters: Parameters?) -> URLRequest {
        guard let parameters = parameters else {
            return self
        }
        
        var encodedURLRequest = self
        
        if let url = self.url,
           let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
           !parameters.isEmpty {
            var newUrlComponents = urlComponents
            let sortedParameters = parameters.sorted { $0.key < $1.key }
            let queryItems = sortedParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            newUrlComponents.queryItems = queryItems
            encodedURLRequest.url = newUrlComponents.url
            return encodedURLRequest
        } else {
            return self
        }
    }
}
