//
//  CuisineListingModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 11/08/23.
//
import Foundation

// MARK: - CuisineListingModel
struct CuisineListingModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: [CuisineListingModelBody]
}

// MARK: - Body
struct CuisineListingModelBody: Codable {
    var id: Int
    var name, image: String
    var status: Int
}
