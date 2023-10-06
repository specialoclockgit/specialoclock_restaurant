//
//  menuProductModal.swift
//  Spacial OClock
//
//  Created by cqlios on 06/10/23.
//

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
    let offerdetails: Offer?
    let categories: [Categorys]?
}

// MARK: - Categorys
struct Categorys: Codable {
    let id: Int?
    let title, image, description: String?
    let status: Int?
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    let id, restrorantBarID, menuID, cuisineID: Int?
    let categoryID: Int?
    let productName: String?
    let price: Int?
    let image, menuTypeName: String?
    let offer: Offer?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case menuID = "menu_id"
        case cuisineID = "cuisine_id"
        case categoryID = "category_id"
        case productName = "product_name"
        case price, image
        case menuTypeName = "menu_type_name"
        case offer
    }
}

// MARK: - Offer
struct Offer: Codable {
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
