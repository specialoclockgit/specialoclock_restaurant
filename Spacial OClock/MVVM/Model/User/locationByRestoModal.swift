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
    let body: [locationByRestoModalBody]?
}

// MARK: - locationByRestoModalBody
struct locationByRestoModalBody: Codable {
    let id: Int?
    let name, location: String?
    let country: Countrys?
    let state, city, latitude, longitude: String?
    let countryCode, mobile: String?
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
    let offers: [Offerv]?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude
        case countryCode = "country_code"
        case mobile
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

enum Countrys: String, Codable {
    case countryIndia = "India"
    case india = "india"
}

// MARK: - Offerv
struct Offerv: Codable {
    let id, restrorantBarID: Int?
    let offerName, description: String?
    let menuID: Int?
    let menuName: String?
    let offerPrice: Int?
    let openTime, closeTime, date: String?
    let type, numberOfUserBook, totalBookings: Int?
    let offerTimings: [OfferTimingd]?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case offerName = "offer_name"
        case description
        case menuID = "menu_id"
        case menuName = "menu_name"
        case offerPrice = "offer_price"
        case openTime = "open_time"
        case closeTime = "close_time"
        case date, type
        case numberOfUserBook = "number_of_user_book"
        case totalBookings = "total_bookings"
        case offerTimings = "offer_timings"
    }
}

// MARK: - OfferTimingd
struct OfferTimingd: Codable {
    let offer: String?
    let percentage, id: Int?
}

