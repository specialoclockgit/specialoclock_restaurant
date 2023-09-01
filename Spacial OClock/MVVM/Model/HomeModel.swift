//
//  HomeModel.swift
//  Spacial OClock
//
//  Created by cqlios1 on 30/08/23.
//

import Foundation

// MARK: - HomeList
//struct HomeListModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: HomeListBody?
//}
//
//// MARK: - Body
//struct HomeListBody: Codable {
//    var location: [HomeListLocation]?
//    var cuisine: [Cuisine]?
//}
//
//// MARK: - Cuisine
//struct Cuisine: Codable {
//    var id: Int?
//    var name: String?
//    var status: Int?
//    var image: String?
//    var restroCount: Int?
//    var restrorants: [CuisineRestrorant]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, status, image
//        case restroCount = "restro_count"
//        case restrorants
//    }
//}
//
//// MARK: - CuisineRestrorant
//struct CuisineRestrorant: Codable {
//    var id: Int?
//    var name, location, country, state: String?
//    var city, latitude, longitude: String?
//    var userID: Int?
//    var shortDescription: String?
//    var status: Int?
//    var openTime, closeTime: String?
//    var type, categoryID, cuisineID, themesRestrorantID: Int?
//    var isBlocked: Int?
//    var profileImage: String?
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
//    }
//}
//
//// MARK: - Location
//struct HomeListLocation: Codable {
//    var id: Int?
//    var country, state, city, localityArea: String?
//    var image: String?
//    var restrorants: [LocationRestrorant]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, country, state, city
//        case localityArea = "locality_area"
//        case image, restrorants
//    }
//}
//
//// MARK: - LocationRestrorant
//struct LocationRestrorant: Codable {
//    var id: Int?
//    var name, location, country, shortDescription: String?
//    var openTime, closeTime: String?
//    var type, categoryID, themesRestrorantID, isBlocked: Int?
//    var profileImage: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, location, country
//        case shortDescription = "short_description"
//        case openTime = "open_time"
//        case closeTime = "close_time"
//        case type
//        case categoryID = "category_id"
//        case themesRestrorantID = "themes_restrorant_id"
//        case isBlocked = "is_blocked"
//        case profileImage = "profile_image"
//    }
//}


// MARK: - HomeList
struct HomeListModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: HomeListBody?
}

// MARK: - Body
struct HomeListBody: Codable {
    var location: [HomeListLocation]?
    var cuisine: [Cuisine]?
    var theme: [ThemeData]?
    var banners: [Banner]?
    var category: [Category]?
}

// MARK: - Theme
struct ThemeData: Codable {
    var id: Int?
    var productName, image: String?
    var restroCount: Int?
    var barCount: Int?
    var restrorants: [CuisineRestrorant]?

    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case image
        case restroCount = "restro_count"
        case barCount = "bar_count"
        case restrorants
    }
}


// MARK: - Category
struct Category: Codable {
    var id: Int?
    var title, description: String?
    var status: Int?
    var image: String?
    var clubCount: Int?
    var clubs: [CuisineRestrorant]?

    enum CodingKeys: String, CodingKey {
        case id, title, description, status, image
        case clubCount = "club_count"
        case clubs
    }
}

// MARK: - Banner vc]
struct Banner: Codable {
    var id: Int?
    var title, image, description: String?
    var isBlocked, status: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, image, description
        case isBlocked = "is_blocked"
        case status
    }
}

// MARK: - Cuisine
struct Cuisine: Codable {
    var id: Int?
    var name: String?
    var status: Int?
    var image: String?
    var restroCount: Int?
    var restrorants: [CuisineRestrorant]?

    enum CodingKeys: String, CodingKey {
        case id, name, status, image
        case restroCount = "restro_count"
        case restrorants
    }
}

// MARK: - CuisineRestrorant
struct CuisineRestrorant: Codable {
    var id: Int?
    var name, location, country, state: String?
    var city, latitude, longitude: String?
    var userID: Int?
    var shortDescription: String?
    var status: Int?
    var openTime, closeTime: String?
    var type, categoryID, cuisineID, themesRestrorantID: Int?
    var isBlocked: Int?
    var profileImage: String?

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
    }
}

// MARK: - Location
struct HomeListLocation: Codable {
    var id: Int?
    var country, state, city: String?
    var image: String?
    var restroCount: Int?
    var restrorants: [LocationRestrorant]?

    enum CodingKeys: String, CodingKey {
        case id, country, state, city, image
        case restroCount = "restro_count"
        case restrorants
    }
}

// MARK: - LocationRestrorant
struct LocationRestrorant: Codable {
    var id: Int?
    var name, location, country, shortDescription: String?
    var openTime, closeTime: String?
    var type, categoryID, themesRestrorantID, isBlocked: Int?
    var profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country
        case shortDescription = "short_description"
        case openTime = "open_time"
        case closeTime = "close_time"
        case type
        case categoryID = "category_id"
        case themesRestrorantID = "themes_restrorant_id"
        case isBlocked = "is_blocked"
        case profileImage = "profile_image"
    }
}
