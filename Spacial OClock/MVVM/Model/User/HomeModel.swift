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
    let openTime: String?
    let closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage: String?
    let commission: String?
    let avgRating: Int?
    let offers: [TimeSlotoffer]?
    var offerTimings: [OfferTiminghome]?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude
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
    }
}

// MARK: - OfferTiminghome
struct OfferTiminghome: Codable {
    let offer: String?
    let percentage, is_fifty: Int?
    let id: Int?
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
    let isBlocked: Int?
    let profileImage, commission, offerDescription, offerPercentage: String?
    let isLiked: Int?
    let distance: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude
        case userID = "user_id"
        case shortDescription = "short_description"
        case status
        case openTime = "open_time"
        case closeTime = "close_time"
        case type, offerDescription, offerPercentage
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
