//
//  LoginVC.swift
//  Special O'Clock
//
//  Created by cql99 on 15/06/23.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import CoreLocation

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
    var locationManager : CLLocationManager!
    var lat : Double?
    var long : Double?
    var Location = String()
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.requestLocationPermission()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func requestLocationPermission() {
        if locationManager == nil {
            locationManager = CLLocationManager()
        }
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
    }
    //MARK: FUNCTIONS FOR LOCATION
    @objc func appMovedToBackground() {
        print("appMovedToBackground")
    }
    
    @objc func appMovedToForeground() {
        print("appMovedToForeground")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.locationManagerDidChangeAuthorization(self.locationManager)
        }
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
            let userImg = UIImageView()
            userImg.sd_setImage(with: URL(string: results?.user.profile?.imageURL(withDimension: 120)?.absoluteString.replacingOccurrences(of: " ", with: "%20") ?? ""),placeholderImage: UIImage(named: "placeholder (1)")) { (img, err, type, urll) in
                
                self.viewmodel.fileUploadedAPI(type: "image", image: img ?? UIImage()) { fileUploadResp in
                    self.viewmodel.socialLoginAPI(socialId: results?.user.userID ?? "", socialType: "2", email: results?.user.fetcherAuthorizer.userEmail ?? "", role: self.selectStatus, latitude: self.lat ?? 0, longitude: self.long ?? 0, location: self.Location, image: fileUploadResp ?? [FileuploadModelBody](), name: results?.user.profile?.givenName ?? "") {
                        if Store.userDetails?.role == 1 {
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
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.viewmodel.checkSocialExistAPI(socialId: socialData.userId, socialType: 3) { [weak self] response in
//                    guard let self = self else { return }
//                    if response?.code == 410 {
//                        guard let vc = self.storyboard?.instantiateViewController(identifier: "SignUPVC") as? SignUPVC else { return }
//                        vc.socialType = .Apple
//                        vc.isFromSocial = true
//                        vc.socialLoginBody = socialData
//                        vc.selectStatus = self.selectStatus
//                        vc.restoselctStatus = self.restoselctStatus
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    } else {
//                        if Store.userDetails?.role == 1{
//                            Store.sociallogin = true
//                            Store.autoLogin = true
//                            CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
//                            Store.screenType = 1
//                            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                            let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
//                            let navigationController = UINavigationController(rootViewController: tabVC)
//                            navigationController.navigationBar.isHidden = true
//                            navigationController.viewControllers = [tabVC]
//                            UIApplication.shared.windows.first?.rootViewController = navigationController
//                            UIApplication.shared.windows.first?.makeKeyAndVisible()
//                            
//                            
//                        } else {
//                            let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
//                            if Store.userDetails?.isCompleted != 1{
//                                let vc = storyBoard.instantiateViewController(withIdentifier: "restoCreateVC")as! restoCreateVC
//                                vc.btnCheckStatus = self.restoselctStatus
//                                if self.restoselctStatus == 1{
//                                    vc.heading = "Restaurant Profile"
//                                    vc.name = "Restaurant Name"
//                                    UserDefaults.standard.set("Restaurant", forKey: "name")
//                                }else  if self.restoselctStatus == 2{
//                                    vc.heading = "Club Profile"
//                                    vc.name = "Club Name"
//                                    UserDefaults.standard.set("Club", forKey: "name")
//                                }else {
//                                    vc.heading = "Bar Profile"
//                                    vc.name = "Bar Name"
//                                    UserDefaults.standard.set("Bar", forKey: "name")
//                                }
//                                UserDefaults.standard.set(self.restoselctStatus, forKey: "status")
//                                self.navigationController?.pushViewController(vc, animated: true)
//                            }else if Store.userDetails?.is_approved == 0{
//                                CommonUtilities.shared.showAlert(message: "Your business account approval is pending. You will be notified once the process is complete.", isSuccess: .error)
//                            } else {
//                                Store.autoLogin = true
//                                Store.sociallogin = true
//                                CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
//                                let tabVC = storyBoard.instantiateViewController(withIdentifier: ViewController.RestoTabBarVC) as! RestoTabBarVC
//                                let navigationController = UINavigationController(rootViewController: tabVC)
//                                navigationController.navigationBar.isHidden = true
//                                navigationController.viewControllers = [tabVC]
//                                UIApplication.shared.windows.first?.rootViewController = navigationController
//                                UIApplication.shared.windows.first?.makeKeyAndVisible()
//                            }
//                        }
//                    }
//                }
//            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple error: \(error.localizedDescription)")
    }
    
}
extension LoginVC : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch  manager.authorizationStatus{
            
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
            openAlert()
        case .denied:
            print("denied")
            openAlert()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            print("authorizedAlways")
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            print("authorizedWhenInUse")
        @unknown default:
            print("@unknown")
        }
    }
    
    func openAlert() {
        let alertController = UIAlertController(title: "Enable Location Services", message: "Special O'Clock wants to access your location only to show you nearby restaurants and bars.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Go to Settings", style: .default, handler: {(cAlertAction) in
            alertController.dismiss(animated: true) {
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
        })
        alertController.addAction(okAction)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }else{
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lat = locValue.latitude
        self.long = locValue.longitude
        let location = locations.last! as CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks as? [CLPlacemark]
            if placemark?.count ?? 0>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                self.Location = "\(placemark.locality ?? ""), \(placemark.administrativeArea ?? "" ), \(placemark.country ?? "")"
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
}
