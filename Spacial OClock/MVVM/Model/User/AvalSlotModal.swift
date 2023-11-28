//
//  AvalSlotModal.swift
//  Spacial OClock
//
//  Created by cqlios on 12/10/23.
//

import Foundation

// MARK: - AvalSlotModal
struct AvalSlotModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: AvalSlotModalBody?
}

// MARK: - AvalSlotModalBody
struct AvalSlotModalBody: Codable {
    let availableSlots: Int?

    enum CodingKeys: String, CodingKey {
        case availableSlots = "available_slots"
    }
}
