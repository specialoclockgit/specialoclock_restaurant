//
//  helpandFaqModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 10/08/23.
//

import Foundation

// MARK: - HelpandFAQModel
struct HelpandFAQModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: [HelpandFAQModelBody]
}

// MARK: - Body
struct HelpandFAQModelBody: Codable {
    var id: Int
    var question, answer: String
}
