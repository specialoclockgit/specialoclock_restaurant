//
//  Socketmodel.swift
//  Spacial OClock
//
//  Created by cqlb on 28/09/23.
//


import Foundation

// MARK: - MessageList
struct  MessageListModel: Codable {
    let id, senderID, receiverID: Int?
    let roomID: String?
    let message: String?
    let messageType: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case roomID = "room_id"
        case message
        case messageType = "message_type"
        case createdAt, updatedAt
    }
}



typealias Welcome = [MessageListModel]
