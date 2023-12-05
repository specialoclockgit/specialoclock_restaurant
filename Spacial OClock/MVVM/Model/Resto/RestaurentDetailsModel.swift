//
//  restaurentDetails.swift
//  Spacial OClock
//
//  Created by cqlpc on 23/08/23.
//

import Foundation

// MARK: - RestaurentDetailsModel
struct RestaurentDetailsModel: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: RestaurentDetailsModelBody?
}

// MARK: - RestaurentDetailsModelBody
struct RestaurentDetailsModelBody: Codable {
    let id: Int?
    let name, location, country, state: String?
    let city, latitude, longitude, countryCode: String?
    let mobile: String?
    let userID: Int?
    let shortDescription: String?
    let status, offerAvailable: Int?
    let openTime, closeTime: String?
    let type, categoryID: Int?
    let cuisineID: String?
    let themesRestrorantID, isBlocked: Int?
    let profileImage, commission: String?
    let avgRating, bookingsCount: Int?
    let restaurantImages: [RestaurantImage]?
    let reviews: [Review]?
    let themesRestrorant: ThemesRestrorant?
    let cuisineNames: [CuisineName]?

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
        case avgRating = "avg_rating"
        case bookingsCount
        case restaurantImages = "restaurant_images"
        case reviews
        case themesRestrorant = "themes_restrorant"
        case cuisineNames = "cuisine_names"
    }
}

// MARK: - CuisineName
struct CuisineName: Codable {
    let id: Int?
    let name, image: String?
    let status: Int?
}

// MARK: - RestaurantImaged
struct RestaurantImage: Codable {
    let id: Int?
    let image: String?
}

// MARK: - Review
struct Review: Codable {
    let id, userID, restrorantBarID: Int?
    let rating, review, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case rating, review, createdAt, updatedAt
    }
}

// MARK: - ThemesRestrorant
struct ThemesRestrorant: Codable {
    let productName: String?

    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
    }
}
