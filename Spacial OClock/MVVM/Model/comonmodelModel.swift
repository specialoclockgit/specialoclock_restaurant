//
//  DeleteAccountModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 08/08/23.
//
import Foundation

// MARK: - DeleteAccountModel
struct comonmodelModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: comonmodelModelBody
}

// MARK: - Body
struct comonmodelModelBody: Codable {
}
