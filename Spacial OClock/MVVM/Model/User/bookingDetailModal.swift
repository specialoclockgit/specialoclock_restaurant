//
//  bookingDetailModal.swift
//  Spacial OClock
//
//  Created by cqlios on 11/10/23.
//

import Foundation

// MARK: - bookingDetailModal
struct bookingDetailModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: bookingDetailModalBody?
}

// MARK: - bookingDetailModalBody
struct bookingDetailModalBody: Codable {
    let id, userID, restrorantBarID: Int?
    let bookingDate, bookingSlot,booking_amount: String?
    let slotID: Int?
    let bookingID, cancelationReason: String?
    let numberOfPeople, status, offerID: Int?
    let createdAt, updatedAt, offerName, offerPercentage: String?
    let user: Userrr?
    var review: ReviewData?
    let restrorant: Restrorantd?
    var productsUnderOffer: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case id,review,booking_amount
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case bookingDate = "booking_date"
        case bookingSlot = "booking_slot"
        case slotID = "slot_id"
        case bookingID = "booking_id"
        case cancelationReason = "cancelation_reason"
        case numberOfPeople = "number_of_people"
        case status
        case offerID = "offer_id"
        case productsUnderOffer = "products_under_offer"
        case createdAt, updatedAt, offerName, offerPercentage, user, restrorant
    }
}

// MARK: - Restrorantd
struct Restrorantd: Codable {
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
    let avgRating: Int?
    let offers: [Offerc]?
    let products: [Productx]?

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
        case offers, products
    }
}

// MARK: - Offerc
struct Offerc: Codable {
    let id, restrorantBarID: Int?
    let offerName, description: String?
    let menuID: Int?
    let menuName: String?
    let offerPrice: Int?
    let openTime, closeTime, date: String?
    var type, numberOfUserBook, totalBookings: Int?

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
        case totalBookings = "total_bookings"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.restrorantBarID = try container.decodeIfPresent(Int.self, forKey: .restrorantBarID)
        self.offerName = try container.decodeIfPresent(String.self, forKey: .offerName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.menuID = try container.decodeIfPresent(Int.self, forKey: .menuID)
        self.menuName = try container.decodeIfPresent(String.self, forKey: .menuName)
        self.offerPrice = try container.decodeIfPresent(Int.self, forKey: .offerPrice)
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
        
        self.totalBookings = try container.decodeIfPresent(Int.self, forKey: .totalBookings)
    }
}

// MARK: - Productx
struct Productx: Codable {
    let id, restrorantBarID, menuID, cuisineID: Int?
    let categoryID: Int?
    let productName: String?
    let price: Int?
    let image, menuTypeName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case menuID = "menu_id"
        case cuisineID = "cuisine_id"
        case categoryID = "category_id"
        case productName = "product_name"
        case price, image
        case menuTypeName = "menu_type_name"
    }
}

// MARK: - Userrr
struct Userrr: Codable {
    let image, name, email, countryCode: String?
    let phone: Int?

    enum CodingKeys: String, CodingKey {
        case image, name, email
        case countryCode = "country_code"
        case phone
    }
}

