//
//  currentPastModal.swift
//  Spacial OClock
//
//  Created by cqlios on 09/10/23.
//

import Foundation

// MARK: - currentPastModal
struct currentPastModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [currentPastModalBody]?
}

// MARK: - BocurrentPastModalBodydy
struct currentPastModalBody: Codable {
    let id, userID, restrorantBarID: Int?
    let bookingDate, bookingSlot: String?
    let slotID: Int?
    let bookingID: String?
    let numberOfPeople, status, offerID: Int?
    let createdAt, updatedAt, restoImage, restoName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case bookingDate = "booking_date"
        case bookingSlot = "booking_slot"
        case slotID = "slot_id"
        case bookingID = "booking_id"
        case numberOfPeople = "number_of_people"
        case status
        case offerID = "offer_id"
        case createdAt, updatedAt, restoImage, restoName
    }
}

