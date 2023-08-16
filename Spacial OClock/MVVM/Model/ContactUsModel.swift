//
//  ContactUsModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 10/08/23.
//

import Foundation

// MARK: - ContactUsModel
struct ContactUsModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: ContactUsModelBody
}

// MARK: - Body
struct ContactUsModelBody: Codable {
    var status, id: Int
    var name, email, message: String
}
