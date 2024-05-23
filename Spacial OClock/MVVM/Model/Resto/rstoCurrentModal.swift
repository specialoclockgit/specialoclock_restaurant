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
    var restroType: Int?
    var offer: Offer?
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
        case createdAt, updatedAt, userImage, userName, restroType, offer
    }
}

// MARK: - Offer
struct Offer: Codable {
    var id, restrorantBarID: Int?
    var offerName, offerApplicable, description: String?
    var menuID: Int?
    var menuName: String?
    var productID: Int?
    var offerPrice, actualPrice, discountedPrice: String?
    var ageRestriction: Int?
    var openTime, closeTime, date: String?
    var type, numberOfUserBook, numberOfUserPerBooking, totalBookings: Int?
    var offerTimings: String?
    var status: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarID = "restrorant_bar_id"
        case offerName = "offer_name"
        case offerApplicable = "offer_applicable"
        case description
        case menuID = "menu_id"
        case menuName = "menu_name"
        case productID = "product_id"
        case offerPrice = "offer_price"
        case actualPrice = "actual_price"
        case discountedPrice = "discounted_price"
        case ageRestriction = "age_restriction"
        case openTime = "open_time"
        case closeTime = "close_time"
        case date, type
        case numberOfUserBook = "number_of_user_book"
        case numberOfUserPerBooking = "number_of_user_per_booking"
        case totalBookings = "total_bookings"
        case offerTimings = "offer_timings"
        case status
    }
}
