//
//  UILabel.swift
//  Spacial OClock
//
//  Created by cql211 on 29/06/23.
//

import Foundation
import UIKit
extension UILabel{
    func lblCornerRadius(cornerRadius : CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
extension UIView{
    func viewCornerRadius(cornerRadius : CGFloat){
        self.layer.cornerRadius = cornerRadius
    }
}
