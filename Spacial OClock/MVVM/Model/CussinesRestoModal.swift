// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - CussinesRestoModal
struct CussinesRestoModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [CussinesRestoModalBody]?
}

// MARK: - CussinesRestoModalBody
struct CussinesRestoModalBody: Codable {
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
    let offers: [CuOffer]?

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
        case availableOffer, offerDescription, offerPercentage, offerOpenTime, offerCloseTime, offers
    }
}

// MARK: - CuOffer
struct CuOffer: Codable {
    let id, restrorantBarID: Int?
    let offerName, description: String?
    let menuID: Int?
    let menuName: String?
    let offerPrice: Int?
    let openTime, closeTime, date: String?
    let type, numberOfUserBook, totalBookings: Int?
    let offerTimings: [OfferTiming]?

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

// MARK: - OfferTiming
struct OfferTiming: Codable {
    let offer: String?
    let percentage, id: Int?
}
