//
//  TermsandconditionModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 08/08/23.
//


import Foundation

// MARK: - TermsconditionModel
struct TermsconditionModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: TermsconditionModelBody
}

// MARK: - Body
struct TermsconditionModelBody: Codable {
    var title, description: String
}


