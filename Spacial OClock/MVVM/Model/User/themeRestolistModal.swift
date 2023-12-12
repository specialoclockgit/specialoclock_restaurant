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
    let city, latitude, longitude: String?
    let userID: Int?
    let shortDescription: String?
    let status: Int?
    let bodyOpenTime, bodyCloseTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage, commission: String?
    let isLiked: Int?
    let availableOffer, offerDescription, offerPercentage, openTime: String?
    let closeTime: String?
    let avgRating :Int?
    let offers: [CuOffer]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude
        case userID = "user_id"
        case shortDescription = "short_description"
        case status
        case bodyOpenTime = "open_time"
        case bodyCloseTime = "close_time"
        case type
        case avgRating = ""
        case categoryID = "category_id"
        case cuisineID = "cuisine_id"
        case themesRestrorantID = "themes_restrorant_id"
        case isBlocked = "is_blocked"
        case profileImage = "profile_image"
        case commission
        case isLiked = "is_liked"
        case availableOffer, offerDescription, offerPercentage, openTime, closeTime, offers
    }
}
