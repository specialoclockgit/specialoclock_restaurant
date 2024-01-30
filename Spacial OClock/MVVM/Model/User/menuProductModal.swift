//
//  menuProductModal.swift
//  Spacial OClock
//
//  Created by cqlios on 06/10/23.
//

//import Foundation
//
//// MARK: - menuProductModal
//struct menuProductModal: Codable {
//    let success: Bool?
//    let code: Int?
//    let message: String?
//    let body: menuProductModalBody?
//}
//
//// MARK: - menuProductModalBody
//struct menuProductModalBody: Codable {
//    let offerdetails: Offer?
//    let categories: [Categorys]?
//}
//
//// MARK: - Categorys
//struct Categorys: Codable {
//    let id: Int?
//    let title, image, description: String?
//    let status: Int?
//    let products: [Product]?
//}
//
//// MARK: - Product
//struct Product: Codable {
//    let id, restrorantBarID, menuID, cuisineID: Int?
//    let categoryID: Int?
//    let productName: String?
//    let price: Int?
//    let image, menuTypeName: String?
//    let offer: Offer?
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
//        case offer
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
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - menuProductModal
struct menuProductModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: menuProductModalBody?
}

// MARK: - menuProductModalBody
struct menuProductModalBody: Codable {
    let offerdetails: Offerdetails?
    let products: [Product]?
}

// MARK: - Offerdetails
struct Offerdetails: Codable {
    var id, restrorantBarID: Int?
    var offerName, description: String?
    var menuID: Int?
    var menuName: String?
    var productID, offerPrice, actualPrice, discountedPrice: Int?
    var openTime, closeTime, date: String?
    var type, numberOfUserBook, numberOfUserPerBooking, totalBookings: Int?
    var offerTimings: String?
    var status: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case offerName = "offer_name"
        case description
        case menuID = "menu_id"
        case menuName = "menu_name"
        case productID = "product_id"
        case offerPrice = "offer_price"
        case actualPrice = "actual_price"
        case discountedPrice = "discounted_price"
        case openTime = "open_time"
        case closeTime = "close_time"
        case date, type
        case numberOfUserBook = "number_of_user_book"
        case numberOfUserPerBooking = "number_of_user_per_booking"
        case totalBookings = "total_bookings"
        case offerTimings = "offer_timings"
        case status
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.restrorantBarID = try container.decodeIfPresent(Int.self, forKey: .restrorantBarID)
        self.offerName = try container.decodeIfPresent(String.self, forKey: .offerName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.menuID = try container.decodeIfPresent(Int.self, forKey: .menuID)
        self.menuName = try container.decodeIfPresent(String.self, forKey: .menuName)
        self.productID = try container.decodeIfPresent(Int.self, forKey: .productID)
        self.offerPrice = try container.decodeIfPresent(Int.self, forKey: .offerPrice)
        self.actualPrice = try container.decodeIfPresent(Int.self, forKey: .actualPrice)
        self.discountedPrice = try container.decodeIfPresent(Int.self, forKey: .discountedPrice)
        self.openTime = try container.decodeIfPresent(String.self, forKey: .openTime)
        self.closeTime = try container.decodeIfPresent(String.self, forKey: .closeTime)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.type = try container.decodeIfPresent(Int.self, forKey: .type)
        //self.numberOfUserBook = try container.decodeIfPresent(Int.self, forKey: .numberOfUserBook)
        if let val = try? container.decodeIfPresent(Int.self, forKey: .numberOfUserBook){
            self.numberOfUserBook = val
        }else if let val =  try? container.decodeIfPresent(String.self, forKey: .numberOfUserBook){
            self.numberOfUserBook = Int(val)
        }else {
            self.numberOfUserBook = nil
        }
        
        
       // self.numberOfUserPerBooking = try container.decodeIfPresent(Int.self, forKey: .numberOfUserPerBooking)
        
        if let val = try? container.decodeIfPresent(Int.self, forKey: .numberOfUserPerBooking){
            self.numberOfUserPerBooking = val
        }else if let val =  try? container.decodeIfPresent(String.self, forKey: .numberOfUserPerBooking){
            self.numberOfUserPerBooking = Int(val)
        } else {
            self.numberOfUserPerBooking = nil
        }
        
        self.totalBookings = try container.decodeIfPresent(Int.self, forKey: .totalBookings)
        self.offerTimings = try container.decodeIfPresent(String.self, forKey: .offerTimings)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
    }
}

// MARK: - Product
struct Product: Codable {
    let id, restrorantBarID, menuID, cuisineID: Int?
    let categoryID: Int?
    let productName: String?
    let price,discounted_price: Int?
    let image, menuTypeName: String?
    let offerPercentage,actual_price: Int?
    
    enum CodingKeys: String, CodingKey {
        case id,discounted_price,actual_price
        case restrorantBarID = "restrorant_bar_id"
        case menuID = "menu_id"
        case cuisineID = "cuisine_id"
        case categoryID = "category_id"
        case productName = "product_name"
        case price, image
        case menuTypeName = "menu_type_name"
        case offerPercentage
    }
}

