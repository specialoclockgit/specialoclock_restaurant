//
//  UITextFiedl.swift
//  Spacial OClock
//
//  Created by cql211 on 30/06/23.
//

import Foundation
import UIKit
extension UITextField{
    func setupRightImage(imageName:String , width : Int , height : Int){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 15, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        imageView.image?.withTintColor(.black)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 30, width: 45, height: 40))
        imageContainerView.addSubview(imageView)
        self.rightView = imageContainerView
        self.rightViewMode = .always
        self.tintColor = .gray
    }
    func setupRightIcon(imageName:String , width : Int , height : Int , y : Int){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 15, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        imageView.image?.withTintColor(.black)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: y, width: 40, height: 40))
        imageContainerView.addSubview(imageView)
        self.rightView = imageContainerView
        self.rightViewMode = .always
        self.tintColor = .gray
    }
}
