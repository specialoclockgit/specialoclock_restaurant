//
//  VerifypopUpVC.swift
//  Special O'Clock
//
//  Created by cql197 on 16/06/23.
//

import UIKit

class VerifypopUpVC: UIViewController {

    //MARK: - Variables
    var callBack: (()->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnOk(_ sender: UIButton) {
        self.dismiss(animated: true)
        callBack?()
    }
    
}
