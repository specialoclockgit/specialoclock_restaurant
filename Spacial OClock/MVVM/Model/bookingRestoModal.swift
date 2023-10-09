//
//  bookingRestoModal.swift
//  Spacial OClock
//
//  Created by cqlios on 09/10/23.
//

import Foundation

// MARK: - bookingRestoModal
struct bookingRestoModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: bookingRestoModalBody?
}

// MARK: - bookingRestoModalBody
struct bookingRestoModalBody: Codable {
    let createBooking: CreateBooking?
}

// MARK: - CreateBooking
struct CreateBooking: Codable {
    let status: Int?
    let createdAt, updatedAt: AtedAt?
    let id, userID: Int?
    let bookingID, restrorantBarID, bookingDate, bookingSlot: String?
    let numberOfPeople, offerID, slotID: String?

    enum CodingKeys: String, CodingKey {
        case status, createdAt, updatedAt, id
        case userID = "user_id"
        case bookingID = "booking_id"
        case restrorantBarID = "restrorant_bar_id"
        case bookingDate = "booking_date"
        case bookingSlot = "booking_slot"
        case numberOfPeople = "number_of_people"
        case offerID = "offer_id"
        case slotID = "slot_id"
    }
}

// MARK: - AtedAt
struct AtedAt: Codable {
    let val: String?
}
