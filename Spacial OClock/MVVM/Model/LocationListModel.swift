//
//  LocationListModel.swift
//  Spacial OClock
//
//  Created by cqlios1 on 29/08/23.
//

import Foundation

// MARK: - LocationList
struct LocationList: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [LocationListBody]?
}

// MARK: - Body
struct LocationListBody: Codable {
    var country: String?
    var states: [State]?
}

// MARK: - State
struct State: Codable {
    var state: String?
    var cities: [City]?
}

// MARK: - City
struct City: Codable {
    var city: String?
    var location: [Location]?
}

// MARK: - Location
struct Location: Codable {
    var name: String?
}
