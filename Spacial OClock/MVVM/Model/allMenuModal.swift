//
//  allMenuModal.swift
//  Spacial OClock
//
//  Created by cqlios on 31/10/23.
//

import Foundation

// MARK: - allMenuModal
struct allMenuModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: [allMenuModalBody]?
}

// MARK: - allMenuModalBody
struct allMenuModalBody: Codable {
    let id, restoBarID: Int?
    let image, createdAt, updatedAt: String?
    let baseurl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case restoBarID = "resto_bar_id"
        case image, createdAt, updatedAt, baseurl
    }
}

