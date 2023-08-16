//
//  LoginVC.swift
//  Special O'Clock
//
//  Created by cql99 on 15/06/23.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPassword: CustomTextField!
    
    //MARK: - VARIABLES
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.hideKeyboardWhenTappedAround()
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 40
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
      //  txtEmail.keyboardType = .alphabet
        
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSignIn(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC")as! TabbarVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignUp(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUPVC")as! SignUPVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnForgotPassword(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC")as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnEyeAct(_ sender : UIButton){
         sender.isSelected == false ? ( txtPassword.isSecureTextEntry = false) : (txtPassword.isSecureTextEntry = true)
        sender.isSelected = !sender.isSelected
        
    }
    
//
//    @objc btnName(sender: UIButton){
//        let cell = cellForRow(at: IndexPath(row: sender.tag, section: 0)as! cellName
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            btn.setImage(UIImage(named: "imgName"), for: .normal)
//        }else{
//            btn.setImage(UIImage(named: "imgName"), for: .normal)
//        }
//    }
   
}

