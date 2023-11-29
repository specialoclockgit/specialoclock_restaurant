//
//  rstoCurrentModal.swift
//  Spacial OClock
//
//  Created by cqlios on 29/11/23.
//

import Foundation

// MARK: - rstoCurrentModal
struct rstoCurrentModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [rstoCurrentModalBody]?
}

// MARK: - rstoCurrentModalBody
struct rstoCurrentModalBody: Codable {
    let id, userID, restrorantBarID: Int?
    let bookingDate, bookingSlot: String?
    let slotID: Int?
    let bookingID, cancelationReason, invoiceNumber, bookingAmount: String?
    let numberOfPeople, status, slotesFull: Int?
    let availableSlotes: String?
    let offerID: Int?
    let createdAt, updatedAt, userImage, userName: String?

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
        case createdAt, updatedAt, userImage, userName
    }
}

