//
//  MenuModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 16/08/23.
//
import Foundation

// MARK: - MenuListingModel
struct MenuListingModel: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [MenuListingModelBody]?
}

// MARK: - MenuListingModelBody
struct MenuListingModelBody: Codable {
    let id: Int?
    let name: String?
    let isActive: Bool?
    let createdAt, updatedAt: String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, name
        case isActive = "is_active"
        case createdAt, updatedAt
    }
}


