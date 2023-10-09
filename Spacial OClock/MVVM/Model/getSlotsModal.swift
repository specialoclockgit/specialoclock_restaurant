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

// MARK: - TimeSlot
struct TimeSlot: Codable {
    let startTime, endTime: String?
    let offered: Int?

    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case endTime = "end_time"
        case offered
    }
}

