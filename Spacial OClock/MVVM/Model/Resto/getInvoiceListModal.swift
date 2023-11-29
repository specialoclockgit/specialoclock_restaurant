//
//  getInvoiceListModal.swift
//  Spacial OClock
//
//  Created by cqlios on 23/10/23.
//

import Foundation

// MARK: - getInvoiceListModal
struct getInvoiceListModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [getInvoiceListModalBody]?
}

// MARK: - getInvoiceListModalBody
struct getInvoiceListModalBody: Codable {
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
