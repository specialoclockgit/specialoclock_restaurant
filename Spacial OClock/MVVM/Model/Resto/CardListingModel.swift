//
//  cardListtingModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 22/08/23.
//
import Foundation

// MARK: - CardListingModel
struct CardListingModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [CardListingModelBody]?
}

// MARK: - CardListingModelBody
struct CardListingModelBody: Codable {
    var id: Int?
    var nameOnCard: String?
    var cardNumber: Int?
    var expiryDate: String?
    var cvv: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nameOnCard = "name_on_card"
        case cardNumber = "card_number"
        case expiryDate = "expiry_date"
        case cvv
    }
}
