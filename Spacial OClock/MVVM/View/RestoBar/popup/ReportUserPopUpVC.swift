//
//  ReportUserPopUpVC.swift
//  Spacial OClock
//
//  Created by cqlios on 30/10/23.
//

import UIKit

class ReportUserPopUpVC: UIViewController {
    var callBack : (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickNo(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onClickYes(_ sender: UIButton) {
        self.dismiss(animated: true)
        callBack?()
    }
    
    

}
