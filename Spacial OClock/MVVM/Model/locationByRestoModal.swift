//
//  locationByRestoModal.swift
//  Spacial OClock
//
//  Created by cqlios on 28/09/23.
//

import Foundation

// MARK: - locationByRestoModal
struct locationByRestoModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: locationByRestoModalBody?
}

// MARK: - locationByRestoModalBody
struct locationByRestoModalBody: Codable {
    let location: [Locations]?
}

// MARK: - Locations
struct Locations: Codable {
    let id: Int?
    let country, state, city: String?
    let image: String?
    let restroCount: Int?
    let restrorants: [Restrorantee]?

    enum CodingKeys: String, CodingKey {
        case id, country, state, city, image
        case restroCount = "restro_count"
        case restrorants
    }
}

// MARK: - Restrorantee
struct Restrorantee: Codable {
    let id: Int?
    let name, location, country, state: String?
    let city, latitude, longitude: String?
    let userID: Int?
    let shortDescription: String?
    let status: Int?
    let openTime, closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage, commission: String?
    let isLiked: Int?
    let availableOffer, offerDescription, offerPercentage, offerOpenTime: String?
    let offerCloseTime: String?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude
        case userID = "user_id"
        case shortDescription = "short_description"
        case status
        case openTime = "open_time"
        case closeTime = "close_time"
        case type
        case categoryID = "category_id"
        case cuisineID = "cuisine_id"
        case themesRestrorantID = "themes_restrorant_id"
        case isBlocked = "is_blocked"
        case profileImage = "profile_image"
        case commission
        case isLiked = "is_liked"
        case availableOffer, offerDescription, offerPercentage, offerOpenTime, offerCloseTime
    }
}


