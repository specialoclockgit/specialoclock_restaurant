//
//  File.swift
//  Spacial OClock
//
//  Created by cqlpc on 08/08/23.
//

import Foundation

// MARK: - ForgotpasswordModel
struct ForgotpasswordModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: ForgotpasswordModelBody
}

// MARK: - Body
struct ForgotpasswordModelBody: Codable {
}

