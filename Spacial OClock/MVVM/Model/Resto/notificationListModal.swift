//
//  notificationListModal.swift
//  Spacial OClock
//
//  Created by cqlios on 24/10/23.
//

import Foundation

// MARK: - notificationListModal
struct notificationListModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [notificationListModalBody]?
}

// MARK: - notificationListModalBody
struct notificationListModalBody: Codable {
    let id, userFrom, userTo: Int?
    let message: String?
    let type: Int?
    let createdAt, updatedAt: String?
    let userName: String?
    let userImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userFrom = "user_from"
        case userTo = "user_to"
        case message, type, createdAt, updatedAt, userName, userImage
    }
}
