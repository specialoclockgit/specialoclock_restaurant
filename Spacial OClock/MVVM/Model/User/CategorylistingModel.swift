//
//  CategorylistingModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 11/08/23.
//
import Foundation

// MARK: - CategoryListingModel
struct CategoryListingModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: [CategoryListingModelBody]
}

// MARK: - Body
struct CategoryListingModelBody: Codable {
    var id: Int
    var title, image, description: String
    var status: Int
}
