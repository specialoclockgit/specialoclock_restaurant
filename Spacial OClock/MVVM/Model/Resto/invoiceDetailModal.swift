//
//  invoiceDetailModal.swift
//  Spacial OClock
//
//  Created by cqlios on 24/10/23.
//

import Foundation

// MARK: - invoiceDetailModal
struct invoiceDetailModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: invoiceDetailModalBody?
}

// MARK: - invoiceDetailModalBody
struct invoiceDetailModalBody: Codable {
    let barResto: BarResto?
    let invoice: Invoice?
    let bookings: [Booking]?

    enum CodingKeys: String, CodingKey {
        case barResto = "bar_resto"
        case invoice, bookings
    }
}

// MARK: - BarResto
struct BarResto: Codable {
    let id: Int?
    let name, location, country, state: String?
    let city, latitude, longitude: String?
    let userID: Int?
    let shortDescription: String?
    let status, offerAvailable: Int?
    let openTime, closeTime: String?
    let type, categoryID, cuisineID, themesRestrorantID: Int?
    let isBlocked: Int?
    let profileImage, commission: String?

    enum CodingKeys: String, CodingKey {
        case id, name, location, country, state, city, latitude, longitude
        case userID = "user_id"
        case shortDescription = "short_description"
        case status
        case offerAvailable = "offer_available"
        case openTime = "open_time"
        case closeTime = "close_time"
        case type
        case categoryID = "category_id"
        case cuisineID = "cuisine_id"
        case themesRestrorantID = "themes_restrorant_id"
        case isBlocked = "is_blocked"
        case profileImage = "profile_image"
        case commission
    }
}

// MARK: - Booking
struct Booking: Codable {
    let id, userID, restrorantBarID: Int?
    let bookingDate, bookingSlot: String?
    let slotID: Int?
    let bookingID, cancelationReason, invoiceNumber, bookingAmount: String?
    let numberOfPeople, status, slotesFull: Int?
    let availableSlotes: String?
    let offerID: Int?
    let createdAt, updatedAt: String?

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
        case createdAt, updatedAt
    }
}

// MARK: - Invoice
struct Invoice: Codable {
    let id: Int?
    let invoiceNumber, startDate, endDate, amount: String?
    let time: String?
    let restoBarID, status: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case invoiceNumber = "invoice_number"
        case startDate = "start_date"
        case endDate = "end_date"
        case amount, time
        case restoBarID = "resto_bar_id"
        case status, createdAt, updatedAt
    }
}
