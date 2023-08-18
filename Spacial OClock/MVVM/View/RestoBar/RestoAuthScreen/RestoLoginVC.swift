//
//  RestoLoginVC.swift
//  Spacial OClock
//
//  Created by cql211 on 07/07/23.
//

import UIKit

class RestoLoginVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPassword: CustomTextField!
    
    //MARK: - VARIABLES
    var viewmodel = AuthViewModel()
    var swipeGesture = UISwipeGestureRecognizer()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = "mini@gmail.com"
        txtPassword.text = "123456"
        initialLoad()
       
    }
   
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton){
        //SceneDelegate().RestoHome()
    }

    @IBAction func btnSignIn(_ sender: UIButton){
        self.viewmodel.loginApicall(email: txtEmail.text ?? "", password: txtPassword.text ?? "", device_type: 1) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewController.RestoTabBarVC)as! RestoTabBarVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
    
    @IBAction func btnSignUp(_ sender: UIButton){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ViewController.RestoSignUPVC)as! RestoSignUPVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnForgotPassword(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: ViewController.RestoForgotpassVC)as! RestoForgotpassVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @IBAction func btnEyeAct(_ sender : UIButton){
        sender.isSelected == false ? (txtPassword.isSecureTextEntry = false) : (txtPassword.isSecureTextEntry = true)
        sender.isSelected = !sender.isSelected
    }
}

extension RestoLoginVC{
    func initialLoad(){
        view.hideKeyboardWhenTappedAround()
        //MARK: Set user Default value
        UserDefaults.standard.set(0, forKey: "status")
        UserDefaults.standard.set("Restaurant 01", forKey: "name")
        //MARK: Outlets Design
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 40
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
