//
//  favListModal.swift
//  Spacial OClock
//
//  Created by cqlios on 22/09/23.
//

import Foundation

// MARK: - favListModal
struct favListModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [favListModalBody]?
}

// MARK: - favListModalBody
struct favListModalBody: Codable {
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
    }
}
