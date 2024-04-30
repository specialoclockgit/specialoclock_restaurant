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
    var nearby_restaurants: [NearbyRestaurant]?
    var all_bars_restos, highily_rated_bars_restos: [AllBarsResto]?
}

// MARK: - AllBarsResto
struct AllBarsResto: Codable {
    let id: Int?
    let name: String?
    let location: String?
    let country: String?
    let state, city: String?
    let latitude, longitude: String?
    let userID: Int?
    let shortDescription: String?
    let status: Int?
    let openTime,disable_dates: String?
    let closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage: String?
    let commission: String?
    let avgRating: Int?
    let offers: [TimeSlotoffer]?
    var offerTimings: [OfferTiminghome]?
    var time_slots: [TimeSlotoffer]?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude,disable_dates,time_slots
        case userID = "user_id"
        case shortDescription = "short_description"
        case status,offers
        case offerTimings = "offer_timings"
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
        self.time_slots = try container.decodeIfPresent([TimeSlotoffer].self, forKey: .time_slots)
        self.offers = try container.decodeIfPresent([TimeSlotoffer].self, forKey: .offers)
        self.offerTimings = try container.decodeIfPresent([OfferTiminghome].self, forKey: .offerTimings)
        self.openTime = try container.decodeIfPresent(String.self, forKey: .openTime)
        self.closeTime = try container.decodeIfPresent(String.self, forKey: .closeTime)
        self.type = try container.decodeIfPresent(Int.self, forKey: .type)
        self.categoryID = try container.decodeIfPresent(Int.self, forKey: .categoryID)
        self.cuisineID = try container.decodeIfPresent(Int.self, forKey: .cuisineID)
        self.themesRestrorantID = try container.decodeIfPresent(Int.self, forKey: .themesRestrorantID)
        self.isBlocked = try container.decodeIfPresent(Int.self, forKey: .isBlocked)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage)
        self.commission = try container.decodeIfPresent(String.self, forKey: .commission)
        self.avgRating = try container.decodeIfPresent(Int.self, forKey: .avgRating)
        self.disable_dates = try container.decodeIfPresent(String.self, forKey: .disable_dates)
    }
}

// MARK: - OfferTiminghome
struct OfferTiminghome: Codable {
    let percentage,offer: String?
    let  is_fifty: Int?
    let id: Int?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let string = try? container.decodeIfPresent(String.self, forKey: .percentage){
            self.percentage = string
        }else if let Int = try? container.decodeIfPresent(Int.self, forKey: .percentage){
            self.percentage = Int.description
        }else {
            self.percentage = nil
        }
        
        self.offer = try container.decodeIfPresent(String.self, forKey: .offer)
        self.is_fifty = try container.decodeIfPresent(Int.self, forKey: .is_fifty)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
}

// MARK: - Theme
struct ThemeData: Codable {
    var id: Int?
    var productName, image: String?
    var restroCount: Int?
    var barCount: Int?
    var restrorant: [CuisineRestrorant]?

    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case image
        case restroCount = "restro_count"
        case barCount = "bar_count"
        case restrorant
    }
}

// MARK: - NearbyRestaurant
struct NearbyRestaurant: Codable {
    let id: Int?
    let name, location, country: String?
    let state: String?
    let city: String?
    let latitude, longitude: String?
    let userID: Int?
    let shortDescription: String?
    let status: Int?
    let openTime, closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked, offer_available: Int?
    let profileImage, commission, offerDescription, offerPercentage: String?
    let isLiked: Int?
    let distance: Double?
    let offer_timings : [OfferTiminghome]?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude,offer_timings
        case userID = "user_id"
        case shortDescription = "short_description"
        case status
        case openTime = "open_time"
        case closeTime = "close_time"
        case type, offerDescription, offerPercentage, offer_available
        case categoryID = "category_id"
        case cuisineID = "cuisine_id"
        case themesRestrorantID = "themes_restrorant_id"
        case isBlocked = "is_blocked"
        case profileImage = "profile_image"
        case commission
        case isLiked = "is_liked"
        case distance
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
    var userID,offer_available: Int?
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
        case status, offer_available
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
    var country, state, city,locality_area: String?
    var image: String?
    var restroCount: Int?
    var restrorants: [LocationRestrorant]?

    enum CodingKeys: String, CodingKey {
        case id, country, state, city, image, locality_area
        case restroCount = "restro_count"
        case restrorants
    }
}

// MARK: - LocationRestrorant
struct LocationRestrorant: Codable {
    var id: Int?
    var name, location, country, shortDescription: String?
    var openTime, closeTime: String?
    var type, categoryID, themesRestrorantID, isBlocked,offer_available: Int?
    var profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country
        case shortDescription = "short_description"
        case openTime = "open_time"
        case closeTime = "close_time"
        case type,offer_available
        case categoryID = "category_id"
        case themesRestrorantID = "themes_restrorant_id"
        case isBlocked = "is_blocked"
        case profileImage = "profile_image"
    }
}
