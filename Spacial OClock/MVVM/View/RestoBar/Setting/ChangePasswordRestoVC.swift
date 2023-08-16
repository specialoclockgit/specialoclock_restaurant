//
//  ChangePasswordRestoVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit

class ChangePasswordRestoVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tfoldPassword: CustomTextField!
    @IBOutlet weak var tfNewPass : UITextField!
    @IBOutlet weak var tfConfirmPass : UITextField!
    //MARK: VARIABLE
    var viewmodel = AuthViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        view.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Button Action
    @IBAction func btnUpdate(_ sender: Any) {
        self.viewmodel.changePasswordapicall(oldpassword: tfoldPassword.text ?? "", newpassword: tfNewPass.text ?? "", confirmpassword: tfConfirmPass.text ?? "") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEyeAct(_ sender : UIButton){
        if sender.tag == 0 {
            sender.isSelected == false ? (tfNewPass.isSecureTextEntry = false) : (tfNewPass.isSecureTextEntry = true)
            sender.isSelected = !sender.isSelected
        }else if sender.tag == 1 {
            sender.isSelected == false ? (tfConfirmPass.isSecureTextEntry = false) : (tfConfirmPass.isSecureTextEntry = true)
            sender.isSelected = !sender.isSelected
        }
    }
}
