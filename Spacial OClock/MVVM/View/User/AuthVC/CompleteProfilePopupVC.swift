//
//  CompleteProfilePopupVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 10/07/24.
//

import UIKit

class CompleteProfilePopupVC: UIViewController {
    var callBack: (()->())?
    @IBOutlet weak var titlelbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titlelbl.font = accessibilityHint == "Home" ? UIFont.boldSystemFont(ofSize: 20.0) : UIFont.systemFont(ofSize: 16.0, weight: .medium)
        titlelbl.text = accessibilityHint == "Home" ? "Please complete your profile for better experience" : "To streamline the payment process for the admin commission per booking, please add a payment card. This will ensure that the commission is automatically deducted on a monthly basis."
    }
    
    @IBAction func btnOkAction(_ sender: UIButton){
        self.dismiss(animated: true) {
            self.callBack?()
        }
    }

}
