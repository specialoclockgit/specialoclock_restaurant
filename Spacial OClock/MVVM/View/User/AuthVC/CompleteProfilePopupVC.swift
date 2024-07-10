//
//  CompleteProfilePopupVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 10/07/24.
//

import UIKit

class CompleteProfilePopupVC: UIViewController {
    var callBack: (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnOkAction(_ sender: UIButton){
        self.dismiss(animated: true) {
            self.callBack?()
        }
    }

}
