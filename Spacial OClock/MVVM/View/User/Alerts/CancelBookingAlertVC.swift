//
//  CancelBookingAlertVC.swift
//  Spacial OClock
//
//  Created by cql211 on 04/07/23.
//

import UIKit

class CancelBookingAlertVC: UIViewController {
    
    //MARK: Variables
    var callBack : (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: Button Action
    @IBAction func btnYesAct(_ sender : UIButton){
        self.dismiss(animated: true)
        callBack?()
    }
    @IBAction func btnNoAct(_ sender : UIButton){
        self.dismiss(animated: true)
    }
}
