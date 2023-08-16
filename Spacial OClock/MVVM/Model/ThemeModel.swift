//
//  ThemeModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 11/08/23.
//
import Foundation

// MARK: - ThemeModel
struct ThemeModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: [ThemeModelBody]
}

// MARK: - Body
struct ThemeModelBody: Codable {
    var id: Int
    var productName: String
    var price: Int
    var image: String
    var status: Int

    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case price, image, status
    }
}
