//
//  MockedData.swift
//  FetchExercise
//
//  Created by Jon Duenas on 3/12/21.
//

import Foundation

public final class MockedData {
    public static let mockJSON: URL = Bundle(for: MockedData.self).url(forResource: "MockEvent", withExtension: "json")!
}
