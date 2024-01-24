//
//  themeRestolistModal.swift
//  Spacial OClock
//
//  Created by cqlios on 27/09/23.
//

//import Foundation
//
//// MARK: - themeRestolistModal
//struct themeRestolistModal: Codable {
//    let success: Bool?
//    let code: Int?
//    let message: String?
//    let body: [themeRestolistModalBody]?
//}
//
//// MARK: - themeRestolistModalBody
//struct themeRestolistModalBody: Codable {
//    let id: Int?
//    let name, location, country, state: String?
//    let city, latitude, longitude: String?
//    let userID: Int?
//    let shortDescription: String?
//    let status: Int?
//    let openTime, closeTime: String?
//    let type, categoryID, cuisineID, themesRestrorantID: Int?
//    let isBlocked: Int?
//    let profileImage, commission: String?
//    let isLiked: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, location, country, state, city, latitude, longitude
//        case userID = "user_id"
//        case shortDescription = "short_description"
//        case status
//        case openTime = "open_time"
//        case closeTime = "close_time"
//        case type
//        case categoryID = "category_id"
//        case cuisineID = "cuisine_id"
//        case themesRestrorantID = "themes_restrorant_id"
//        case isBlocked = "is_blocked"
//        case profileImage = "profile_image"
//        case commission
//        case isLiked = "is_liked"
//    }
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - themeRestolistModal
struct themeRestolistModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [themeRestolistModalBody]?
}

// MARK: - themeRestolistModalBody
struct themeRestolistModalBody: Codable {
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
    let avgRating: Int?
    let timeSlots: [TimeSlotoffer]?

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
        case availableOffer, offerDescription, offerPercentage, offerOpenTime, offerCloseTime
        case avgRating = "avg_rating"
        case timeSlots = "time_slots"
    }
}

// MARK: - TimeSlotoffer
struct TimeSlotoffer: Codable {
    let id, restrorantBarID, menuID, offerID: Int?
    let startTime, endTime: String?
    let isFifty: Int?
    let offer: OfferFetch?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case menuID = "menu_id"
        case offerID = "offer_id"
        case startTime = "start_time"
        case endTime = "end_time"
        case isFifty = "is_fifty"
        case offer
    }
}

// MARK: - OfferFetch
struct OfferFetch: Codable {
    let id, restrorantBarID: Int?
    let offerName, description: String?
    let menuID: Int?
    let menuName: String?
    let offerPrice: Int?
    let openTime, closeTime, date: String?
    var type, numberOfUserBook, totalBookings, status: Int?

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
        case status
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.restrorantBarID = try container.decodeIfPresent(Int.self, forKey: .restrorantBarID)
        self.offerName = try container.decodeIfPresent(String.self, forKey: .offerName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.menuID = try container.decodeIfPresent(Int.self, forKey: .menuID)
        self.menuName = try container.decodeIfPresent(String.self, forKey: .menuName)
        self.offerPrice = try container.decodeIfPresent(Int.self, forKey: .offerPrice)
        self.openTime = try container.decodeIfPresent(String.self, forKey: .openTime)
        self.closeTime = try container.decodeIfPresent(String.self, forKey: .closeTime)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.type = try container.decodeIfPresent(Int.self, forKey: .type)
       // self.numberOfUserBook = try container.decodeIfPresent(Int.self, forKey: .numberOfUserBook)
        
        if let val = try? container.decodeIfPresent(Int.self, forKey: .numberOfUserBook){
            self.numberOfUserBook = val
        }else if let val =  try? container.decodeIfPresent(String.self, forKey: .numberOfUserBook){
            self.numberOfUserBook = Int(val)
        }else {
            self.numberOfUserBook = nil
        }
        
       // self.totalBookings = try container.decodeIfPresent(Int.self, forKey: .totalBookings)
        if let val = try? container.decodeIfPresent(Int.self, forKey: .totalBookings){
            self.totalBookings = val
        }else if let val =  try? container.decodeIfPresent(String.self, forKey: .totalBookings){
            self.totalBookings = Int(val)
        }else {
            self.totalBookings = nil
        }
        
        
        
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
    }
}
