//
//  UIView.swift
//  Spacial OClock
//
//  Created by cql211 on 29/06/23.
//

import Foundation
import UIKit
extension UIView{
    func cornerRadius(cornerRadius : CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners =  [.layerMaxXMinYCorner, .layerMinXMinYCorner]//[.layerMaxXMaxYCorner,
    }
    //View with Shadow
    func ViewShadow(cornerRadius : CGFloat , shadowColor : UIColor , x : Double , y : Double){
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner , .layerMinXMaxYCorner , .layerMinXMinYCorner]
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowOpacity = 1
    }
    //View Border
    func viewBorder(cornerRadius : CGFloat , borderWidth : CGFloat , borderColor : UIColor){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    //Change Backgound color of view
    func ChangebgColor(viewSelected : UIView , viewUnselected : UIView, viewUnselected2: UIView , labelSelected : UILabel , labelUnselected : UILabel , labelUnselecte2 : UILabel){
        viewSelected.backgroundColor = UIColor.systemGray5
        viewUnselected.backgroundColor = UIColor.white
        viewUnselected2.backgroundColor = UIColor.white
        labelSelected.backgroundColor = UIColor.white
        labelUnselected.backgroundColor = UIColor.systemGray5
        labelUnselecte2.backgroundColor = UIColor.systemGray5
    }
    
    // KeyboardDismiss
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
}
