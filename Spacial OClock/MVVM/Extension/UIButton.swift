//
//  UIButton.swift
//  Spacial OClock
//
//  Created by cql211 on 03/07/23.
//

import Foundation
import UIKit
extension UIButton{
    func btnShadow(cornerRadius : CGFloat , shadowColor : UIColor , opacity : Float , x : Int , y : Int){
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: x, height: y)
    }
}
