//
//  String.swift
//  Spacial OClock
//
//  Created by cql211 on 15/07/23.
//

import Foundation
import UIKit
import SDWebImage
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
    var isValidemail: Bool {
        let emailRegex = try? NSRegularExpression(pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}\\s*$")
        let range = NSRange(location: 0, length: self.count)
        return emailRegex?.firstMatch(in: self, options: [], range: range) != nil
    }
    
    var containsValidCharacter: Bool {
      guard self != "" else { return true }
      let hexSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")
      let newSet = CharacterSet(charactersIn: self)
      return hexSet.isSuperset(of: newSet)
    }
    
    func length() -> Int {
        return count
    }

}
