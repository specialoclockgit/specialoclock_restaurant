//
//  commonModel.swift
//  Spacial OClock
//
//  Created by cqlka on 18/08/23.
//

import Foundation

// MARK: - CommonModel
struct CommonModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: CommonBody?
}

// MARK: - CommonBody
struct CommonBody: Codable {
}

