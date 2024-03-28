//
//  LoginVC.swift
//  Special O'Clock
//
//  Created by cql99 on 15/06/23.
//

import UIKit

class LoginVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var btnRemember: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPassword: CustomTextField!
    
    //MARK: - VARIABLES
    var viewmodel = AuthViewModel()
    var swipeGesture = UISwipeGestureRecognizer()
    var selectStatus = Int()
    var restoselctStatus = Int()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        txtEmail.keyboardType = .emailAddress
        UserDefaults.standard.setValue(true, forKey: "AppInstalled")
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.hideKeyboardWhenTappedAround()
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 40
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        txtEmail.text = UserDefaults.standard.value(forKey: "loginEmail") as? String ?? ""
        txtPassword.text = UserDefaults.standard.value(forKey: "loginPassword") as? String ?? ""
        btnRemember.isSelected = UserDefaults.standard.value(forKey: "rememberMe") as? Bool ?? false
      //  txtEmail.keyboardType = .alphabet
        
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

    @IBAction func btnSignIn(_ sender: UIButton){
        self.viewmodel.loginApicall(email: txtEmail.text ?? "", password: txtPassword.text ?? "", device_type: 2, role: 0, timeZone: TimeZone.current.identifier) {
            if self.btnRemember.isSelected == true {
                UserDefaults.standard.set(self.txtEmail.text!, forKey: "loginEmail")
                UserDefaults.standard.set(self.txtPassword.text!, forKey: "loginPassword")
                UserDefaults.standard.set(true, forKey: "rememberMe")
            } else {
                UserDefaults.standard.set("", forKey: "loginEmail")
                UserDefaults.standard.set("", forKey: "loginPassword")
                UserDefaults.standard.set(false, forKey: "rememberMe")
            }

            if Store.userDetails?.role == 1{
                if Store.userDetails?.isOtpVerified == 1 {
                   Store.autoLogin = true
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                    CommonUtilities.shared.showAlert(message: "Login successfully", isSuccess: .success)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else {
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                   CommonUtilities.shared.showAlert(message: "Please verify otp", isSuccess: .error)
                   self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
                if Store.userDetails?.isOtpVerified != 1{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC")as! VerificationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if Store.userDetails?.isCompleted != 1{
                    let vc = storyBoard.instantiateViewController(withIdentifier: "restoCreateVC")as! restoCreateVC
                    vc.btnCheckStatus = self.restoselctStatus
                    if self.restoselctStatus == 1{
                        vc.heading = "Restaurant Profile"
                        vc.name = "Restaurant Name"
                        UserDefaults.standard.set("Restaurant", forKey: "name")
                    }else{
                        vc.heading = "Pub & Bar Profile"
                        vc.name = "Bar/Club Name"
                        UserDefaults.standard.set("Bar", forKey: "name")
                    }
                    UserDefaults.standard.set(self.restoselctStatus, forKey: "status")
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if Store.userDetails?.is_approved == 0{
                    CommonUtilities.shared.showAlert(message: "Your Business approval is pending from admin.", isSuccess: .error)
                }else {
                    let vc = storyBoard.instantiateViewController(withIdentifier: ViewController.RestoTabBarVC)as! RestoTabBarVC
                    Store.autoLogin = true
                    CommonUtilities.shared.showAlert(message: "Login successfully", isSuccess: .success)
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
    }
    
    @IBAction func btnSignUp(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUPVC")as! SignUPVC
        vc.selectStatus = self.selectStatus
        vc.restoselctStatus = self.restoselctStatus
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

    @IBAction func onClickRememberMe(_ sender: UIButton) {
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

extension LoginVC{
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
