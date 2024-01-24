//
//  getSlotsModal.swift
//  Spacial OClock
//
//  Created by cqlios on 09/10/23.
//

import Foundation

// MARK: - getSlotsModal
struct getSlotsModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: getSlotsModalBody?
}

// MARK: - getSlotsModalBody
struct getSlotsModalBody: Codable {
    let offer: Offered?
    let timeSlots: [TimeSlot]?
}

// MARK: - Offered
struct Offered: Codable {
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
        //self.numberOfUserBook = try container.decodeIfPresent(Int.self, forKey: .numberOfUserBook)
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

// MARK: - TimeSlot
struct TimeSlot: Codable {
    let id: Int?
    let startTime, endTime: String?
    let offered: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case startTime = "start_time"
        case endTime = "end_time"
        case offered
    }
}
