//
//  RestoVerificationAlertVC.swift
//  Spacial OClock
//
//  Created by cql211 on 07/07/23.
//

import UIKit

class RestoVerificationAlertVC: UIViewController {
    
    //MARK: - Variables
    var callBack: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Button Action
    @IBAction func btnOk(_ sender: UIButton) {
        self.dismiss(animated: true)
        callBack?()
    }
}

