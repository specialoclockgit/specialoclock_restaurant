//
//  fetchCategoryModal.swift
//  Spacial OClock
//
//  Created by cqlios on 07/11/23.
//

import Foundation

// MARK: - CategoryByRModal
struct CategoryByRModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [CategoryByRModalBody]?
}

// MARK: - CategoryByRModalBody
struct CategoryByRModalBody: Codable {
    let id: Int?
    let name, location, country, state: String?
    let city, latitude, longitude, countryCode: String?
    let mobile: String?
    let userID: Int?
    let shortDescription: String?
    let status, offerAvailable: Int?
    let openTime, closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage, commission: String?
    let isLiked: Int?
    let availableOffer, offerDescription, offerPercentage, offerOpenTime: String?
    let offerCloseTime: String?
    let avgrating : Int?
    let offers: [TimeSlotoffer]?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude
        case countryCode = "country_code"
        case mobile
        case avgrating = "avg_rating"
        case userID = "user_id"
        case shortDescription = "short_description"
        case status
        case offerAvailable = "offer_available"
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
        case availableOffer, offerDescription, offerPercentage, offerOpenTime, offerCloseTime, offers
    }
}
