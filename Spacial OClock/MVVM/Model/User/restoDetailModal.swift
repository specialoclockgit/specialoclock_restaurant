//
//  restoDetailModal.swift
//  Spacial OClock
//
//  Created by cqlios on 04/10/23.
//

import Foundation

// MARK: - restoDetailModal
struct restoDetailModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: restoDetailModalBody?
}

// MARK: - restoDetailModalBody
struct restoDetailModalBody: Codable {
    let id: Int?
    let name, location, country, state: String?
    let city, latitude, longitude: String?
    let userID: Int?
    let shortDescription: String?
    let status: Int?
    let openTime, closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage, commission, avgRating: String?
    let images: [String]?
    let reviews: [Reviews]?
    let ourMenu: [OurMenu]?

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
        case avgRating = "avg_rating"
        case images, reviews
        case ourMenu = "our_menu"
    }
}

// MARK: - OurMenu
struct OurMenu: Codable {
    let id: Int?
    let name: String?
    let isActive: Int?
    let createdAt, updatedAt: String?
    let offers: Offers?
    let menuProducts: [[MenuProduct]]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case isActive = "is_active"
        case createdAt, updatedAt, offers
        case menuProducts = "menu_products"
    }
}

// MARK: - MenuProduct
struct MenuProduct: Codable {
    let id, restrorantBarID, menuID, cuisineID: Int?
    let categoryID: Int?
    let productName: String?
    let price: Int?
    let image, menuTypeName, categoryName: String?
    let offerPercentage: String?
    let offeredPrice: String?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case menuID = "menu_id"
        case cuisineID = "cuisine_id"
        case categoryID = "category_id"
        case productName = "product_name"
        case price, image
        case menuTypeName = "menu_type_name"
        case categoryName = "CategoryName"
        case offerPercentage
        case offeredPrice = "OfferedPrice"
    }
}

// MARK: - Offers
struct Offers: Codable {
    let id, restrorantBarID: Int?
    let offerName, description: String?
    let menuID: Int?
    let menuName: String?
    let offerPrice: String?
    let openTime, closeTime, date: String?
    let type, numberOfUserBook: Int?

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
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.restrorantBarID = try container.decodeIfPresent(Int.self, forKey: .restrorantBarID)
        self.offerName = try container.decodeIfPresent(String.self, forKey: .offerName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.menuID = try container.decodeIfPresent(Int.self, forKey: .menuID)
        self.menuName = try container.decodeIfPresent(String.self, forKey: .menuName)
        self.offerPrice = try container.decodeIfPresent(String.self, forKey: .offerPrice)
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
        
    }
}

// MARK: - Reviews
struct Reviews: Codable {
    let id, userID, restrorantBarID, rating: Int?
    let review, createdAt, updatedAt: String?
    let user: Userdd?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case rating, review, createdAt, updatedAt, user
    }
}

// MARK: - Userdd
struct Userdd: Codable {
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

