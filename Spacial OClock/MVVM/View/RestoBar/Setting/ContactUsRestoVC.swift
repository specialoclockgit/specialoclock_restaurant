//
//  ContactUsRestoVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit
import IQKeyboardManagerSwift

class ContactUsRestoVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tfEmail : UITextField!
    @IBOutlet weak var tfName: CustomTextField!
    @IBOutlet weak var txtVW: IQTextView!
    
    //    MARK: - VARIABLE
    var viewmodel = AuthViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        view.hideKeyboardWhenTappedAround()
        tfEmail.keyboardType = .emailAddress
        // Do any additional setup after loading the view.
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmit(_ sender: Any) {
        self.viewmodel.contactUsApiCall(name: tfName.text ?? "", email: tfEmail.text ?? "", message: txtVW.text ?? "") {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
