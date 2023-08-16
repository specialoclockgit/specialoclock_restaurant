//
//  ForgotPasswordVC.swift
//  Special O'Clock
//
//  Created by cql197 on 16/06/23.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var tfEmail: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Actions
     @IBAction func btnSubmit(_ sender: UIButton){
         self.navigationController?.popViewController(animated: true)
     }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
