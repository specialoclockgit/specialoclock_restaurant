//
//  createReviewModal.swift
//  Spacial OClock
//
//  Created by cqlios on 03/10/23.
//

import Foundation

// MARK: - createReviewModal
struct createReviewModal: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: createReviewModalBody?
}

// MARK: - createReviewModalBody
struct createReviewModalBody: Codable {
    let createRating: CreateRating?

    enum CodingKeys: String, CodingKey {
        case createRating = "create_rating"
    }
}

// MARK: - CreateRating
struct CreateRating: Codable {
    let id, userID: Int?
    let restrorantBarID, rating, review, updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restrorantBarID = "restrorant_bar_id"
        case rating, review, updatedAt, createdAt
    }
}

