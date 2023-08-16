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

// MARK: - Model
struct AddbusinessModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: AddbusinessModelBody
}

// MARK: - Body
struct AddbusinessModelBody: Codable {
    var addBar: AddBar

    enum CodingKeys: String, CodingKey {
        case addBar = "add_bar"
    }
}

// MARK: - AddBar
struct AddBar: Codable {
    var status, isBlocked, id: Int
    var name, type, profileImage, location: String
    var openTime, closeTime, categoryID, themesRestrorantID: String
    var shortDescription: String
    var userID: Int

    enum CodingKeys: String, CodingKey {
        case status
        case isBlocked = "is_blocked"
        case id, name, type
        case profileImage = "profile_image"
        case location
        case openTime = "open_time"
        case closeTime = "close_time"
        case categoryID = "category_id"
        case themesRestrorantID = "themes_restrorant_id"
        case shortDescription = "short_description"
        case userID = "user_id"
    }
}

