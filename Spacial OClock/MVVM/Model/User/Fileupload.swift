//
//  FileUploadModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 08/08/23.
//

import Foundation

// MARK: - FileuploadModel
struct FileuploadModel: Codable {
    var status: Bool
    var code: Int
    var message: String
    var body: [FileuploadModelBody]
}

// MARK: - Body
struct FileuploadModelBody: Codable {
    var image, thumbnail, fileName, folder: String
    var file_type: String

    enum CodingKeys: String, CodingKey {
        case image, thumbnail, fileName, folder
        case file_type
    }
    
}

extension Collection where Iterator.Element == [String:Any] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:Any]],
           let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
           let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}


