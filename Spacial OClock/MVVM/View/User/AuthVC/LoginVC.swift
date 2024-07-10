//
//  LoginVC.swift
//  Special O'Clock
//
//  Created by cql99 on 15/06/23.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

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
    }
    
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
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
                    CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
                    Store.screenType = 1
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                    let navigationController = UINavigationController(rootViewController: tabVC)
                    navigationController.navigationBar.isHidden = true
                    navigationController.viewControllers = [tabVC]
                    UIApplication.shared.windows.first?.rootViewController = navigationController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    
                    
                }else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                    CommonUtilities.shared.showAlert(message: "Please verify the OTP", isSuccess: .error)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
                if Store.userDetails?.isOtpVerified != 1{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC")as! VerificationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if Store.userDetails?.isCompleted != 1{
                    let vc = storyBoard.instantiateViewController(withIdentifier: "restoCreateVC")as! restoCreateVC
                    vc.btnCheckStatus = self.restoselctStatus
                    if self.restoselctStatus == 1{
                        vc.heading = "Restaurant Profile"
                        vc.name = "Restaurant Name"
                        UserDefaults.standard.set("Restaurant", forKey: "name")
                    }else  if self.restoselctStatus == 2{
                        vc.heading = "Club Profile"
                        vc.name = "Club Name"
                        UserDefaults.standard.set("Club", forKey: "name")
                    }else {
                        vc.heading = "Bar Profile"
                        vc.name = "Bar Name"
                        UserDefaults.standard.set("Bar", forKey: "name")
                    }
                    UserDefaults.standard.set(self.restoselctStatus, forKey: "status")
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if Store.userDetails?.is_approved == 0{
                    CommonUtilities.shared.showAlert(message: "Your business account approval is pending. You will be notified once the process is complete.", isSuccess: .error)
                } else {
                    CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
                    let tabVC = storyBoard.instantiateViewController(withIdentifier: ViewController.RestoTabBarVC) as! RestoTabBarVC
                    let navigationController = UINavigationController(rootViewController: tabVC)
                    navigationController.navigationBar.isHidden = true
                    navigationController.viewControllers = [tabVC]
                    UIApplication.shared.windows.first?.rootViewController = navigationController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
        }
    }
    
    @IBAction func btnSignUp(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUPVC")as! SignUPVC
        vc.selectStatus = self.selectStatus
        vc.restoselctStatus = self.restoselctStatus
        vc.isFromSocial = false
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
    
    @IBAction func googleSiginAction(_ sender: UIButton){
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { results, error in
            guard error == nil else { return }
            
            self.viewmodel.checkSocialExistAPI(socialId: results?.user.userID ?? "", socialType: 2) { [weak self] response in
                guard let self = self else { return }
                if response?.code == 410 {
                    let resultData = SocialLoginModel(userImage: results?.user.profile?.imageURL(withDimension: 120)?.absoluteString, userFullName: results?.user.profile?.givenName ?? "", email: results?.user.fetcherAuthorizer.userEmail ?? "", userId: results?.user.userID ?? "")
                    guard let vc = self.storyboard?.instantiateViewController(identifier: "SignUPVC") as? SignUPVC else { return }
                    vc.socialType = .Google
                    vc.isFromSocial = true
                    vc.socialLoginBody = resultData
                    vc.selectStatus = self.selectStatus
                    vc.restoselctStatus = self.restoselctStatus
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    if Store.userDetails?.role == 1{
                        Store.sociallogin = true
                        Store.autoLogin = true
                        CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
                        Store.screenType = 1
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                        let navigationController = UINavigationController(rootViewController: tabVC)
                        navigationController.navigationBar.isHidden = true
                        navigationController.viewControllers = [tabVC]
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                        
                        
                    }else{
                        let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
                        if Store.userDetails?.isCompleted != 1{
                            let vc = storyBoard.instantiateViewController(withIdentifier: "restoCreateVC")as! restoCreateVC
                            vc.btnCheckStatus = self.restoselctStatus
                            if self.restoselctStatus == 1{
                                vc.heading = "Restaurant Profile"
                                vc.name = "Restaurant Name"
                                UserDefaults.standard.set("Restaurant", forKey: "name")
                            }else  if self.restoselctStatus == 2{
                                vc.heading = "Club Profile"
                                vc.name = "Club Name"
                                UserDefaults.standard.set("Club", forKey: "name")
                            }else {
                                vc.heading = "Bar Profile"
                                vc.name = "Bar Name"
                                UserDefaults.standard.set("Bar", forKey: "name")
                            }
                            UserDefaults.standard.set(self.restoselctStatus, forKey: "status")
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else if Store.userDetails?.is_approved == 0{
                            CommonUtilities.shared.showAlert(message: "Your business account approval is pending. You will be notified once the process is complete.", isSuccess: .error)
                        } else {
                            Store.autoLogin = true
                            Store.sociallogin = true
                            CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
                            let tabVC = storyBoard.instantiateViewController(withIdentifier: ViewController.RestoTabBarVC) as! RestoTabBarVC
                            let navigationController = UINavigationController(rootViewController: tabVC)
                            navigationController.navigationBar.isHidden = true
                            navigationController.viewControllers = [tabVC]
                            UIApplication.shared.windows.first?.rootViewController = navigationController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func fbSiginAction(_ sender: UIButton){
        
    }
    
    @IBAction func appleSiginAction(_ sender: UIButton){
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    
    
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
extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            
            if KeychainHelper.fetch("userIdentifier") == nil {
                KeychainHelper.save("userIdentifier", value: userIdentifier)
            }
            
            if let fullName = appleIDCredential.fullName {
                let fullNameString = "\(fullName.givenName ?? "") \(fullName.familyName ?? "")"
                if KeychainHelper.fetch("fullName") == nil {
                    KeychainHelper.save("fullName", value: fullNameString)
                }
            }
            
            if let email = appleIDCredential.email {
                if KeychainHelper.fetch("email") == nil {
                    KeychainHelper.save("email", value: email)
                }
            }
            
            var socialData = SocialLoginModel(userImage: "", userFullName: "", email: "", userId: "")
            if let userId = KeychainHelper.fetch("userIdentifier") {
                print("Fetched userIdentifier: \(userId)")
                socialData.userId = userId
                socialData.userImage = ""
            }
            
            if let fullName = KeychainHelper.fetch("fullName") {
                print("Fetched fullName: \(fullName)")
                socialData.userFullName = fullName
            }
            
            if let email = KeychainHelper.fetch("email") {
                print("Fetched email: \(email)")
                socialData.email = email
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.viewmodel.checkSocialExistAPI(socialId: socialData.userId, socialType: 3) { [weak self] response in
                    guard let self = self else { return }
                    if response?.code == 410 {
                        guard let vc = self.storyboard?.instantiateViewController(identifier: "SignUPVC") as? SignUPVC else { return }
                        vc.socialType = .Apple
                        vc.isFromSocial = true
                        vc.socialLoginBody = socialData
                        vc.selectStatus = self.selectStatus
                        vc.restoselctStatus = self.restoselctStatus
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        if Store.userDetails?.role == 1{
                            Store.sociallogin = true
                            Store.autoLogin = true
                            CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
                            Store.screenType = 1
                            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                            let navigationController = UINavigationController(rootViewController: tabVC)
                            navigationController.navigationBar.isHidden = true
                            navigationController.viewControllers = [tabVC]
                            UIApplication.shared.windows.first?.rootViewController = navigationController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                            
                            
                        } else {
                            let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
                            if Store.userDetails?.isCompleted != 1{
                                let vc = storyBoard.instantiateViewController(withIdentifier: "restoCreateVC")as! restoCreateVC
                                vc.btnCheckStatus = self.restoselctStatus
                                if self.restoselctStatus == 1{
                                    vc.heading = "Restaurant Profile"
                                    vc.name = "Restaurant Name"
                                    UserDefaults.standard.set("Restaurant", forKey: "name")
                                }else  if self.restoselctStatus == 2{
                                    vc.heading = "Club Profile"
                                    vc.name = "Club Name"
                                    UserDefaults.standard.set("Club", forKey: "name")
                                }else {
                                    vc.heading = "Bar Profile"
                                    vc.name = "Bar Name"
                                    UserDefaults.standard.set("Bar", forKey: "name")
                                }
                                UserDefaults.standard.set(self.restoselctStatus, forKey: "status")
                                self.navigationController?.pushViewController(vc, animated: true)
                            }else if Store.userDetails?.is_approved == 0{
                                CommonUtilities.shared.showAlert(message: "Your business account approval is pending. You will be notified once the process is complete.", isSuccess: .error)
                            } else {
                                Store.autoLogin = true
                                Store.sociallogin = true
                                CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
                                let tabVC = storyBoard.instantiateViewController(withIdentifier: ViewController.RestoTabBarVC) as! RestoTabBarVC
                                let navigationController = UINavigationController(rootViewController: tabVC)
                                navigationController.navigationBar.isHidden = true
                                navigationController.viewControllers = [tabVC]
                                UIApplication.shared.windows.first?.rootViewController = navigationController
                                UIApplication.shared.windows.first?.makeKeyAndVisible()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple error: \(error.localizedDescription)")
    }
    
}
