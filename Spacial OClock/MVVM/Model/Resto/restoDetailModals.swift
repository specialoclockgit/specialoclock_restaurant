//
//  restoDetailModal.swift
//  Spacial OClock
//
//  Created by cqlios on 26/09/23.
//

//import Foundation
//
//// MARK: - restoDetailModal
//struct restoDetailModal: Codable {
//    let success: Bool?
//    let code: Int?
//    let message: String?
//    let body: restoDetailModalBody?
//}
//
//// MARK: - restoDetailModalBody
//struct restoDetailModalBody: Codable {
//    let id, userID, restrorantBarID: Int?
//    let bookingDate, bookingSlot, bookingID: String?
//    let numberOfPeople, status: Int?
//    let createdAt, updatedAt: String?
//    let user: Userr?
//    let restrorant: Restrorant?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case restrorantBarID = "restrorant_bar_id"
//        case bookingDate = "booking_date"
//        case bookingSlot = "booking_slot"
//        case bookingID = "booking_id"
//        case numberOfPeople = "number_of_people"
//        case status, createdAt, updatedAt, user, restrorant
//    }
//}
//
//// MARK: - Restrorant
//struct Restrorant: Codable {
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
//    let offers: [Offer]?
//    let products: [Productd]?
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
//        case commission, offers, products
//    }
//}
//
//// MARK: - Offer
//struct Offer: Codable {
//    let id, restrorantBarID: Int?
//    let offerName, description: String?
//    let menuID, offerPrice: Int?
//    let openTime, closeTime: String?
//    let type, numberOfUserBook: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case restrorantBarID = "restrorant_bar_id"
//        case offerName = "offer_name"
//        case description
//        case menuID = "menu_id"
//        case offerPrice = "offer_price"
//        case openTime = "open_time"
//        case closeTime = "close_time"
//        case type
//        case numberOfUserBook = "number_of_user_book"
//    }
//}
//
//// MARK: - Productd
//struct Productd: Codable {
//    let id, restrorantBarID, menuID, cuisineID: Int?
//    let categoryID: Int?
//    let productName: String?
//    let price: Int?
//    let image, menuTypeName: String?
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
//    }
//}
//
//// MARK: - User
//struct Userr: Codable {
//    let image, name, email, countryCode: String?
//    let phone: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case image, name, email
//        case countryCode = "country_code"
//        case phone
//    }
//}












// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

//import Foundation
//
//// MARK: - restoDetailModals
//struct restoDetailModals: Codable {
//    let success: Bool?
//    let code: Int?
//    let message: String?
//    let body: restoDetailModalsBody?
//}
//
//// MARK: - restoDetailModalsBody
//struct restoDetailModalsBody: Codable {
//    let id, userID, restrorantBarID: Int?
//    let bookingDate, bookingSlot: String?
//    let slotID: Int?
//    let bookingID, cancelationReason, invoiceNumber, bookingAmount: String?
//    let numberOfPeople, status, slotesFull: Int?
//    let availableSlotes: String?
//    let offerID: Int?
//    let createdAt, updatedAt, offerName, offerPercentage: String?
//    let user: Userr?
//    let restrorant: Restrorant?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case restrorantBarID = "restrorant_bar_id"
//        case bookingDate = "booking_date"
//        case bookingSlot = "booking_slot"
//        case slotID = "slot_id"
//        case bookingID = "booking_id"
//        case cancelationReason = "cancelation_reason"
//        case invoiceNumber = "invoice_number"
//        case bookingAmount = "booking_amount"
//        case numberOfPeople = "number_of_people"
//        case status
//        case slotesFull = "slotes_full"
//        case availableSlotes = "available_slotes"
//        case offerID = "offer_id"
//        case createdAt, updatedAt, offerName, offerPercentage, user, restrorant
//    }
//}
//
//// MARK: - Restrorant
//struct Restrorant: Codable {
//    let id: Int?
//    let name, location, country, state: String?
//    let city, latitude, longitude, countryCode: String?
//    let mobile: String?
//    let userID: Int?
//    let shortDescription: String?
//    let status, offerAvailable: Int?
//    let openTime, closeTime: String?
//    let type, categoryID, cuisineID, themesRestrorantID: Int?
//    let isBlocked: Int?
//    let profileImage, commission: String?
//    let avgRating: Int?
//    let offers: [Offer]?
//    let products: [Productdd]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, location, country, state, city, latitude, longitude
//        case countryCode = "country_code"
//        case mobile
//        case userID = "user_id"
//        case shortDescription = "short_description"
//        case status
//        case offerAvailable = "offer_available"
//        case openTime = "open_time"
//        case closeTime = "close_time"
//        case type
//        case categoryID = "category_id"
//        case cuisineID = "cuisine_id"
//        case themesRestrorantID = "themes_restrorant_id"
//        case isBlocked = "is_blocked"
//        case profileImage = "profile_image"
//        case commission
//        case avgRating = "avg_rating"
//        case offers, products
//    }
//}
//
//// MARK: - Offer
//struct Offer: Codable {
//    let id, restrorantBarID: Int?
//    let offerName, description: String?
//    let menuID: Int?
//    let menuName: String?
//    let offerPrice: Int?
//    let openTime, closeTime, date: String?
//    let type, numberOfUserBook, totalBookings: Int?
//    let offerTimings: String?
//    let status: Int?
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
//        case totalBookings = "total_bookings"
//        case offerTimings = "offer_timings"
//        case status
//    }
//}
//
//// MARK: - Productdd
//struct Productdd: Codable {
//    let id, restrorantBarID, menuID, cuisineID: Int?
//    let categoryID: Int?
//    let productName: String?
//    let price: Int?
//    let image, menuTypeName: String?
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
//    }
//}
//
//// MARK: - Userr
//struct Userr: Codable {
//    let image, name, email, countryCode: String?
//    let phone: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case image, name, email
//        case countryCode = "country_code"
//        case phone
//    }
//}






// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - restoDetailModals
struct restoDetailModals: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: restoDetailModalsBody?
}

// MARK: - restoDetailModalsBody
struct restoDetailModalsBody: Codable {
    let id, userID, restrorantBarID: Int?
    let bookingDate, bookingSlot: String?
    let slotID: Int?
    let bookingID, cancelationReason, invoiceNumber, bookingAmount: String?
    let numberOfPeople, status, slotesFull: Int?
    let availableSlotes: String?
    let offerID: Int?
    let createdAt, updatedAt, offerName, offerPercentage: String?
    let user: Userr?
    let restrorant: Restrorant?
    let productsUnderOffer: [ProductDetail]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case bookingDate = "booking_date"
        case bookingSlot = "booking_slot"
        case slotID = "slot_id"
        case bookingID = "booking_id"
        case cancelationReason = "cancelation_reason"
        case invoiceNumber = "invoice_number"
        case bookingAmount = "booking_amount"
        case numberOfPeople = "number_of_people"
        case status
        case slotesFull = "slotes_full"
        case availableSlotes = "available_slotes"
        case offerID = "offer_id"
        case createdAt, updatedAt, offerName, offerPercentage, user, restrorant
        case productsUnderOffer = "products_under_offer"
    }
}

// MARK: - ProductDetail
struct ProductDetail: Codable {
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

// MARK: - Restrorant
struct Restrorant: Codable {
    let id: Int?
    let name, location, country, state: String?
    let city, latitude, longitude, countryCode: String?
    let mobile: String?
    let userID: Int?
    let shortDescription: String?
    let status, offerAvailable: Int?
    let openTime, closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage, commission: String?
    let avgRating: Int?
    let offers: [Offerd]?
    let products: [ProductDetail]?

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
        case offers, products
    }
}

// MARK: - Offer
struct Offerd: Codable {
    let id, restrorantBarID: Int?
    let offerName, description: String?
    let menuID: Int?
    let menuName: String?
    let offerPrice: Int?
    let openTime, closeTime, date: String?
    let type, numberOfUserBook, totalBookings: Int?
    let offerTimings: String?
    let status: Int?

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
        case offerTimings = "offer_timings"
        case status
    }
}

// MARK: - Userr
struct Userr: Codable {
    let image, name, email, countryCode: String?
    let phone: Int?

    enum CodingKeys: String, CodingKey {
        case image, name, email
        case countryCode = "country_code"
        case phone
    }
}
