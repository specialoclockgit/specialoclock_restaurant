//
//  MenuModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 16/08/23.

import Foundation

// MARK: - MenuListingModel
struct MenuListingModel: Codable {
    let success: Bool
    let code: Int
    let message: String
    let body: [MenuListingModelBody]
}

// MARK: - MenuListingModelBody
struct MenuListingModelBody: Codable {
    let id: Int
    let name: String
    let menuType, isActive: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case menuType = "menu_type"
        case isActive = "is_active"
        case createdAt, updatedAt
    }
}
