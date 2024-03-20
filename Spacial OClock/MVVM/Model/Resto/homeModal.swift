//
//  homeModal.swift
//  Spacial OClock
//
//  Created by cqlios on 28/11/23.
//

import Foundation

// MARK: - homeModal
struct homeModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: homeModalBody?
}

// MARK: - homeModalBody
struct homeModalBody: Codable {
    let count: Int?
    let rows: [Rows]?
}

// MARK: - Rows
struct Rows: Codable {
    var id, userID, restrorantBarID: Int?
        var bookingDate, bookingSlot: String?
        var slotID: Int?
        var bookingID, cancelationReason, invoiceNumber, bookingAmount: String?
        var numberOfPeople, status, slotesFull: Int?
        var availableSlotes ,offer_discount: String?
        var offerID: Int?
        var createdAt, updatedAt, offerName: String?
        var user: User?
        var restrorant: Restrorant?

        enum CodingKeys: String, CodingKey {
            case id,offer_discount
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
            case createdAt, updatedAt, offerName, user, restrorant
        }
}

// MARK: - Userd
struct Userd: Codable {
    let image, name: String?
    let id: Int?
}
