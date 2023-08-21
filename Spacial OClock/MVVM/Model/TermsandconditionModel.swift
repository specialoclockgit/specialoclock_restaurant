//
//  TermsandconditionModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 08/08/23.
//


import Foundation

// MARK: - CMSModel
struct CMSModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: CMSBody?
}

// MARK: - CMSBody
struct CMSBody: Codable {
    var title, description: String?
}
