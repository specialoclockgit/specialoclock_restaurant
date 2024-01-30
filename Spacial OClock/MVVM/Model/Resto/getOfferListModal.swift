

import Foundation

// MARK: - getOfferListModal
struct getOfferListModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [getOfferListModalBody]?
}

// MARK: - getOfferListModalBody
struct getOfferListModalBody: Codable {
    var id, restrorantBarID: Int?
    var offerName, description: String?
    var menuID: Int?
    var menuName: String?
    var productID, offerPrice, actualPrice, discountedPrice: Int?
    var openTime, closeTime, date: String?
    var type, numberOfUserBook, numberOfUserPerBooking, totalBookings: Int?
    var offerTimings: String?
    var status: Int?
    let products: [offerProduct]?
    
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
        case products
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
        if let val = try? container.decodeIfPresent(Int.self, forKey: .numberOfUserBook){
            self.numberOfUserBook = val
        }else if let val =  try? container.decodeIfPresent(String.self, forKey: .numberOfUserBook){
            self.numberOfUserBook = Int(val)
        }else {
            self.numberOfUserBook = nil
        }
        self.totalBookings = try container.decodeIfPresent(Int.self, forKey: .totalBookings)
        self.offerTimings = try container.decodeIfPresent(String.self, forKey: .offerTimings)
        self.products = try container.decodeIfPresent([offerProduct].self, forKey: .products)
    }
}

// MARK: - offerProduct
struct offerProduct: Codable {
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
