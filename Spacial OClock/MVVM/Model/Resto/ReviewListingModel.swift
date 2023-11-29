//
//  ReviewListingModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 23/08/23.
//


import Foundation

// MARK: - EditRestaurentModel
struct ReviewListingModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ReviewListingModelBody]?
}

// MARK: - ReviewListingModelBody
struct ReviewListingModelBody: Codable {
    var id, userID, restrorantBarID, rating: Int?
    var review: String?
    var user: Userc?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case rating, review, user
    }
}

// MARK: - Userc
struct Userc: Codable {
    var id: Int?
    var name, image: String?
}
