//
//  productDetailModal.swift
//  Spacial OClock
//
//  Created by cqlios on 21/09/23.
//

//import Foundation
//
//// MARK: - productDetailModal
//struct productDetailModal: Codable {
//    let success: Bool?
//    let code: Int?
//    let message: String?
//    let body: productDetailModalBody?
//}
//
//// MARK: - productDetailModalBody
//struct productDetailModalBody: Codable {
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
//    let avgRating: String?
//    let images: []?
//    let reviews: []?
//    let ourMenu: []?

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
//        case avgRating = "avg_rating"
//        case images, reviews
//        case ourMenu = "our_menu"
//    }
//}
//
//// MARK: - Imaged
//struct Imaged: Codable {
//    let image: String?
//}
//
//// MARK: - OurMenud
//struct OurMenud: Codable {
//    let id: Int?
//    let name: String?
//    let isActive: Int?
//    let createdAt, updatedAt: String?
//    let offers: Offersd?
//    let menuProducts: [[MenuProductd]]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case isActive = "is_active"
//        case createdAt, updatedAt, offers
//        case menuProducts = "menu_products"
//    }
//}
//
//// MARK: - MenuProductd
//struct MenuProductd: Codable {
//    let id, restrorantBarID, menuID, cuisineID: Int?
//    let categoryID: Int?
//    let productName: String?
//    let price: Int?
//    let image, menuTypeName, categoryName: String?
//    let offerPercentage: Int?
//    let offeredPrice: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case restrorantBarID = "restrorant_bar_id"
//        case menuID = "menu_id"
//        case cuisineID = "cuisine_id"
//        case categoryID = "category_id"
//        case productName = "product_name"
//        case price, image
//        case menuTypeName = "menu_type_name"
//        case categoryName = "CategoryName"
//        case offerPercentage
//        case offeredPrice = "OfferedPrice"
//    }
//}
//
//// MARK: - Offersd
//struct Offersd: Codable {
//    let id, restrorantBarID: Int?
//    let offerName, description: String?
//    let menuID: Int?
//    let menuName: String?
//    let offerPrice: Int?
//    let openTime, closeTime, date: String?
//    let type, numberOfUserBook: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case restrorantBarID = "restrorant_bar_id"
//        case offerName = "offer_name"
//        case description
//        case menuID = "menu_id"
//        case menuName = "menu_name"
//        case offerPrice = "offer_price"
//        case openTime = "open_time"
//        case closeTime = "close_time"
//        case date, type
//        case numberOfUserBook = "number_of_user_book"
//    }
//}
//
//// MARK: - Reviewsd
//struct Reviewsd: Codable {
//    let id, userID, restrorantBarID, rating: Int?
//    let review, createdAt, updatedAt: String?
//    let user: User?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case restrorantBarID = "restrorant_bar_id"
//        case rating, review, createdAt, updatedAt, user
//    }
//}
//
//// MARK: - User
//struct User: Codable {
//    let id: Int?
//    let name, aboutMe, nickName, dob: String?
//    let gender: Int?
//    let email: String?
//    let type, role: Int?
//    let countryCode: String?
//    let phone: Int?
//    let password, socialID: String?
//    let socialType, otp: Int?
//    let deviceToken: String?
//    let deviceType: Int?
//    let selfieImage: String?
//    let isSelfieStatus, isOtpVerified: Int?
//    let image, verifyImage: String?
//    let isImageVerified: Int?
//    let location, latitude, longitude: String?
//    let loginTime: Int?
//    let notes, interests: String?
//    let status, loginStep, isCompleted, notificationStatus: Int?
//    let createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case aboutMe = "about_me"
//        case nickName = "nick_name"
//        case dob, gender, email, type, role
//        case countryCode = "country_code"
//        case phone, password
//        case socialID = "social_id"
//        case socialType = "social_type"
//        case otp
//        case deviceToken = "device_token"
//        case deviceType = "device_type"
//        case selfieImage = "selfie_image"
//        case isSelfieStatus = "is_selfie_status"
//        case isOtpVerified = "is_otp_verified"
//        case image
//        case verifyImage = "verify_image"
//        case isImageVerified = "is_image_verified"
//        case location, latitude, longitude
//        case loginTime = "login_time"
//        case notes, interests, status
//        case loginStep = "login_step"
//        case isCompleted = "is_completed"
//        case notificationStatus = "notification_status"
//        case createdAt, updatedAt
//    }
//}
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

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
    let id: Int?
    var name, location, country, state, totalBookings: String?
    let city, latitude, longitude: String?
    let userID: Int?
    let shortDescription: String?
    let status: Int?
    let openTime, closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage, commission: String?
    let isLiked: Int?
    var avgRating: String?
    let images: [Imaged]?
    let reviews: [Reviewsd]?
    let ourMenu: [OurMenud]?
    let offer_timings : [OfferTimingDetail]?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude, offer_timings
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
        case avgRating = "avg_rating"
        case images, reviews, totalBookings
        case ourMenu = "our_menu"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
        self.userID = try container.decodeIfPresent(Int.self, forKey: .userID)
        self.shortDescription = try container.decodeIfPresent(String.self, forKey: .shortDescription)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.openTime = try container.decodeIfPresent(String.self, forKey: .openTime)
        self.closeTime = try container.decodeIfPresent(String.self, forKey: .closeTime)
        self.type = try container.decodeIfPresent(Int.self, forKey: .type)
        self.categoryID = try container.decodeIfPresent(Int.self, forKey: .categoryID)
        self.cuisineID = try container.decodeIfPresent(Int.self, forKey: .cuisineID)
        self.themesRestrorantID = try container.decodeIfPresent(Int.self, forKey: .themesRestrorantID)
        self.isBlocked = try container.decodeIfPresent(Int.self, forKey: .isBlocked)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage)
        self.commission = try container.decodeIfPresent(String.self, forKey: .commission)
        self.isLiked = try container.decodeIfPresent(Int.self, forKey: .isLiked)
       // self.totalBookings = try container.decodeIfPresent(String.self, forKey: .totalBookings)
        if let value = try? container.decode(String.self, forKey: .totalBookings) {
            self.totalBookings = value
        }else if let value = try? container.decode(Int.self, forKey: .totalBookings) {
            self.totalBookings = "\(value)"
        }
        
//        self.avgRating = try container.decodeIfPresent(String.self, forKey: .avgRating)
        if let value = try? container.decode(String.self, forKey: .avgRating) {
            self.avgRating = value
        }else if let value = try? container.decode(Int.self, forKey: .avgRating) {
            self.avgRating = "\(value)"
        }
        self.images = try container.decodeIfPresent([Imaged].self, forKey: .images)
        self.reviews = try container.decodeIfPresent([Reviewsd].self, forKey: .reviews)
        self.ourMenu = try container.decodeIfPresent([OurMenud].self, forKey: .ourMenu)
        self.offer_timings = try container.decodeIfPresent([OfferTimingDetail].self, forKey: .offer_timings)
    }
}

// MARK: - OfferTimingDetail
struct OfferTimingDetail: Codable {
    let offer: String?
    let percentage, id, offerAvailable, slotsleft: Int?
    let restrorantBarID: Int?
    let description: String?
    let menuName: String?
    let menuID, offerID: Int?

    enum CodingKeys: String, CodingKey {
        case offer, percentage, id
        case offerAvailable = "offer_available"
        case slotsleft
        case restrorantBarID = "restrorant_bar_id"
        case description
        case menuName = "menu_name"
        case menuID = "menu_id"
        case offerID = "offer_id"
    }
}

// MARK: - Imaged
struct Imaged: Codable {
    let image: String?
}

// MARK: - OurMenud
struct OurMenud: Codable {
    let id: Int?
    let name: String?
    let isActive: Int?
    let createdAt, updatedAt: String?
    let offers: Offersd?
    let menuProducts: MenuProductd?

    enum CodingKeys: String, CodingKey {
        case id, name
        case isActive = "is_active"
        case createdAt, updatedAt, offers
        case menuProducts = "menu_products"
    }
}

// MARK: - MenuProductd
struct MenuProductd: Codable {
    let anurag: [Anurag]?
}

// MARK: - Anurag
struct Anurag: Codable {
    let id, restrorantBarID, menuID, cuisineID: Int?
    let categoryID: Int?
    let productName: String?
    let price: Int?
    let image, menuTypeName, categoryName: String?
    let offerPercentage: Int?
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

// MARK: - Offersd
struct Offersd: Codable {
    let id, restrorantBarID: Int?
    let offerName, description: String?
    let menuID: Int?
    let menuName: String?
    let offerPrice: Int?
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
}

// MARK: - Reviewsd
struct Reviewsd: Codable {
    var id, userID, restrorantBarID: Int?
    var review, createdAt, rating, updatedAt: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case rating, review, createdAt, updatedAt, user
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.userID = try container.decodeIfPresent(Int.self, forKey: .userID)
        self.restrorantBarID = try container.decodeIfPresent(Int.self, forKey: .restrorantBarID)
//        self.rating = try container.decodeIfPresent(Int.self, forKey: .rating)
        if let value  = try? container.decode(String.self, forKey: .rating) {
            rating = value
        } else if let value  = try? container.decode(Int.self, forKey: .rating) {
            rating = "\(value)"
        }
//        self.review = try container.decodeIfPresent(String.self, forKey: .review)
        if let value = try? container.decode(String.self, forKey: .review) {
            self.review = value
        }else if let value = try? container.decode(Int.self, forKey: .review) {
            self.review = "\(value)"
        }
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
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
