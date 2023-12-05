//
//  EditRestaurentModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 23/08/23.
//


import Foundation

// MARK: - EditRestaurentModel
struct EditRestaurentModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: EditRestaurentModelBody?
}

// MARK: - Body
struct EditRestaurentModelBody: Codable {
    var id: Int?
    var name, location: String?
    var userID: Int?
    var shortDescription: String?
    var status: Int?
    var openTime, closeTime: String?
    var type, categoryID, cuisineID, themesRestrorantID: Int?
    var isBlocked: Int?
    var profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, location
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
    }
}
