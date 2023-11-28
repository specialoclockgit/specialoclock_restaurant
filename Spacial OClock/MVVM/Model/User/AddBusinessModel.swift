//
//  AddBusinessModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 11/08/23.
//

//import Foundation
//
//// MARK: - AddbusinessModel
//struct AddbusinessModel: Codable {
//    var success: Bool
//    var code: Int
//    var message: String
//    var body: AddbusinessModelBody
//}
//
//// MARK: - Body
//struct AddbusinessModelBody: Codable {
//    var addBar: AddBar
//
//    enum CodingKeys: String, CodingKey {
//        case addBar = "add_bar"
//    }
//}
//
//// MARK: - AddBar
//struct AddBar: Codable {
//    var status, isBlocked, id: Int
//    var name, type, location, openTime: String
//    var closeTime, categoryID, themesRestrorantID, shortDescription: String
//    var userID: Int
//
//    enum CodingKeys: String, CodingKey {
//        case status
//        case isBlocked = "is_blocked"
//        case id, name, type, location
//        case openTime = "open_time"
//        case closeTime = "close_time"
//        case categoryID = "category_id"
//        case themesRestrorantID = "themes_restrorant_id"
//        case shortDescription = "short_description"
//        case userID = "user_id"
//    }
//}

import Foundation

// MARK: - AddbusinessModel
struct AddbusinessModel: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: AddbusinessModelBody?
}

// MARK: - AddbusinessModelBody
struct AddbusinessModelBody: Codable {
    let addRestaurant: AddRestaurant?

    enum CodingKeys: String, CodingKey {
        case addRestaurant = "add_restaurant"
    }
}

// MARK: - AddRestaurant
struct AddRestaurant: Codable {
    let status, isBlocked, id: Int?
    let name, type, profileImage, location: String?
    let openTime, closeTime, themesRestrorantID, shortDescription: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case status
        case isBlocked = "is_blocked"
        case id, name, type
        case profileImage = "profile_image"
        case location
        case openTime = "open_time"
        case closeTime = "close_time"
        case themesRestrorantID = "themes_restrorant_id"
        case shortDescription = "short_description"
        case userID = "user_id"
    }
}
