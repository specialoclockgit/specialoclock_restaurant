//
//  paymentModal.swift
//  Spacial OClock
//
//  Created by cqlios on 07/11/23.
//

import Foundation

// MARK: - paymentModal
struct paymentModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: paymentModalBody?
}

// MARK: - paymentModalBody
struct paymentModalBody: Codable {
    let paymentIntent, ephemeralKey, customer, stripePublishKey: String?

    enum CodingKeys: String, CodingKey {
        case paymentIntent, ephemeralKey, customer
        case stripePublishKey = "stripe_publish_key"
    }
}

