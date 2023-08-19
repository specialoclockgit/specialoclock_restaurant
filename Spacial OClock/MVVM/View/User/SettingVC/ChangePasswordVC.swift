//
//  ChangePasswordVC.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var txtOldPassword: CustomTextField!
    @IBOutlet weak var txtNewPassword: CustomTextField!
    @IBOutlet weak var txtConfirmPassword: CustomTextField!
    @IBOutlet weak var btnEyeOP : UIButton!
    
    var viewmodel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnEyeOP.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Actions
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        self.viewmodel.changePasswordapicall(oldpassword: txtOldPassword.text ?? "", newpassword: txtNewPassword.text ?? "", confirmpassword: txtConfirmPassword.text ?? "") {
            self.navigationController?.popViewController(animated: true)
        }
    }
     
    @IBAction func btnEyeAct (_ sender : UIButton){
        if sender .tag == 1 {
            sender.isSelected == false ? (txtNewPassword.isSecureTextEntry = false) : (txtNewPassword.isSecureTextEntry = true)
            sender.isSelected = !sender.isSelected
        }else if sender.tag == 2 {
            sender.isSelected == false ? (txtConfirmPassword.isSecureTextEntry = false) : (txtConfirmPassword.isSecureTextEntry = true)
            sender.isSelected = !sender.isSelected
        }
    }
}
