//
//  RestoForgotpassVC.swift
//  Spacial OClock
//
//  Created by cql211 on 07/07/23.
//

import UIKit

class RestoForgotpassVC: UIViewController {
    @IBOutlet weak var tfEmail: CustomTextField!
    //    MARK: _ VARIABLE
    var viewmodel = AuthViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Actions
     @IBAction func btnSubmit(_ sender: UIButton){
//         self.viewmodel.ForgotPassword(email: tfEmail.text ?? "") {
//             self.navigationController?.popViewController(animated: true)
//         }
     }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
