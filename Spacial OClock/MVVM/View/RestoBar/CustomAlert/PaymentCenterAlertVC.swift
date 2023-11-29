//
//  PaymentCenterAlertVC.swift
//  Spacial OClock
//
//  Created by cql211 on 07/07/23.
//

import UIKit

class PaymentCenterAlertVC: UIViewController {
    
    //MARK: - VARIABELS
    var callback : (()->())?
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Button Action
    @IBAction func btnDoneAct(_ sender : UIButton){
        self.dismiss(animated: true) {
            self.callback?()
        }
    }

}
