//
//  productDetailModal.swift
//  Spacial OClock
//
//  Created by cqlios on 21/09/23.
//

import Foundation

// MARK: - productDetailModal
struct productDetailModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: productDetailModalBody?
}

// MARK: - productDetailModalBody
struct productDetailModalBody: Codable {
    let id, restrorantBarID, menuID, cuisineID: Int?
    let categoryID: Int?
    let productName: String?
    let price: Int?
    let image: String?
    let isLiked: Int?
    let restrorant: Restrorant?
    let cuisineCategory: CuisineCategory?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case menuID = "menu_id"
        case cuisineID = "cuisine_id"
        case categoryID = "category_id"
        case productName = "product_name"
        case price, image
        case isLiked = "is_liked"
        case restrorant
        case cuisineCategory = "cuisine_category"
    }
}

// MARK: - CuisineCategory
struct CuisineCategory: Codable {
    let id: Int?
    let name, image: String?
    let status: Int?
}

// MARK: - Restrorant
struct Restrorant: Codable {
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
    let restaurantImages: [String]?
    let reviews: [Review]?
    let offers: [Offer]?

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
        case restaurantImages = "restaurant_images"
        case reviews, offers
    }
}

// MARK: - Offer
struct Offer: Codable {
    let id, restrorantBarID: Int?
    let offerName, description: String?
    let menuID, offerPrice: Int?
    let openTime, closeTime: String?
    let type, numberOfUserBook: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case offerName = "offer_name"
        case description
        case menuID = "menu_id"
        case offerPrice = "offer_price"
        case openTime = "open_time"
        case closeTime = "close_time"
        case type
        case numberOfUserBook = "number_of_user_book"
    }
}

// MARK: - Review
struct Review: Codable {
    let id, userID, restrorantBarID, rating: Int?
    let review, createdAt, updatedAt: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case rating, review, createdAt, updatedAt, user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, aboutMe, nickName, dob: String?
    let gender: Int?
    let email: String?
    let type, role: Int?
    let countryCode: String?
    let phone: Int?
    let password, socialID: String?
    let socialType, otp: Int?
    let deviceToken: String?
    let deviceType: Int?
    let selfieImage: String?
    let isSelfieStatus, isOtpVerified: Int?
    let image, verifyImage: String?
    let isImageVerified: Int?
    let location, latitude, longitude: String?
    let loginTime: Int?
    let notes, interests: String?
    let status, loginStep, isCompleted, notificationStatus: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case aboutMe = "about_me"
        case nickName = "nick_name"
        case dob, gender, email, type, role
        case countryCode = "country_code"
        case phone, password
        case socialID = "social_id"
        case socialType = "social_type"
        case otp
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case selfieImage = "selfie_image"
        case isSelfieStatus = "is_selfie_status"
        case isOtpVerified = "is_otp_verified"
        case image
        case verifyImage = "verify_image"
        case isImageVerified = "is_image_verified"
        case location, latitude, longitude
        case loginTime = "login_time"
        case notes, interests, status
        case loginStep = "login_step"
        case isCompleted = "is_completed"
        case notificationStatus = "notification_status"
        case createdAt, updatedAt
    }
}

