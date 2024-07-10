//
//  SignUPVC.swift
//  Special O'Clock
//
//  Created by cql197 on 16/06/23.
//

import UIKit
import SKCountryPicker
import GooglePlaces
import CoreLocation
import AVFoundation


class SignUPVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var tfPhone: CustomTextField!
    @IBOutlet weak var restaurantBtn: UIButton!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var imgProfile : UIImageView!
    @IBOutlet weak var tfCountry : UITextField!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfEmail : UITextField!
    @IBOutlet weak var tfPassword : UITextField!
    @IBOutlet weak var tfConfirmPass : UITextField!
    @IBOutlet weak var stackViewRestaurant : UIStackView!
    @IBOutlet weak var viewButton: CustomView!
    @IBOutlet weak var signUpBtn : UIButton!
    @IBOutlet weak var btnBar : UIButton!
    @IBOutlet weak var btnRestaurant : UIButton!
    @IBOutlet weak var dobVw: UIView!
    @IBOutlet weak var dobTf: UITextField!
    @IBOutlet weak var passVw: UIView!
    @IBOutlet weak var confirmPassVw: UIView!
    
    //MARK: Variables
    var viewmodel = AuthViewModel()
    var locationManager : CLLocationManager!
    var isImageSelected = false
    var isselected = false
    var lat : Double?
    var long : Double?
    var Location = String()
    var countryCode = String()
    var image = [FileuploadModelBody]()
    var selectStatus = Int()
    var restoselctStatus = Int()
    let datePicker = UIDatePicker()
    var socialLoginBody : SocialLoginModel?
    var socialType = SocialType.Google
    var isFromSocial = false
    //MARK: ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.delegate = self
        tfPhone.delegate = self
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfConfirmPass.delegate = self
        dobVw.isHidden = selectStatus == 1 ? false : true
        uiSet()
        showDatePicker()
        if isFromSocial {
            self.setSocialLoginData()
        }else {
            self.signUpBtn.setTitle("Sign Up", for: .normal)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.requestLocationPermission()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    
    //MARK: - Function
    private func uiSet() {
        tapGesture()
        view.hideKeyboardWhenTappedAround()
        viewButton.isHidden = true
    }
    
    private func setSocialLoginData() {
        CommonUtilities.shared.showAlert(message: "Please complete your profile details.")
        self.passVw.isHidden = true
        self.confirmPassVw.isHidden = true
        self.tfName.text = socialLoginBody?.userFullName ?? ""
        self.tfEmail.text = socialLoginBody?.email ?? ""
        self.tfEmail.isUserInteractionEnabled = false
        switch socialType {
        case .FaceBook:
            self.signUpBtn.setTitle("Continue with Facebook", for: .normal)
        case .Google:
            self.signUpBtn.setTitle("Continue with Google", for: .normal)
        case .Apple:
            self.signUpBtn.setTitle("Continue with Apple", for: .normal)
        }
        
        
        if socialLoginBody?.userImage != "" {
            self.imgProfile.sd_setImage(with: URL(string: socialLoginBody?.userImage?.replacingOccurrences(of: " ", with: "%20") ?? ""),placeholderImage: UIImage(named: "placeholder (1)")) { (img, err, type, urll) in
                if let img = img {
                    self.viewmodel.fileUploadedAPI(type: "image", image: img) { [weak self] imageData in
                        self?.isImageSelected = true
                        self?.image = imageData ?? [FileuploadModelBody]()
                    }
                }
            }
        }
    }
    
    
    // MARK: - Actions
    @IBAction func btnProfile(_ sender : UIButton){
        self.checkCameraAccess()
        ImagePicker().pickImage(self) { (image) in
            self.imgProfile.image = image
            self.viewmodel.fileUploadedAPI(type: "image", image: image) { [weak self] imageData in
                self?.image = imageData ?? [FileuploadModelBody]()
                self?.isImageSelected = true
                if self?.checkFilledDeatils(isImage: self?.isImageSelected ?? false, name: self?.tfName.text ?? "", email: self?.tfEmail.text ?? "", phone: self?.tfPhone.text ?? "", dob: self?.dobTf.text ?? "", pass: self?.tfPassword.text ?? "", conPass: self?.tfConfirmPass.text ?? "",isSelected: self?.isselected ?? false) == true {
                    self?.signUpBtn.isUserInteractionEnabled = true
                    self?.signUpBtn.backgroundColor = UIColor(named: "themeOrange")
                } else {
                    self?.signUpBtn.isUserInteractionEnabled = false
                    self?.signUpBtn.backgroundColor = .lightGray
                }
            }
        }
    }
    
    @IBAction func btnResto(_ sender: UIButton) {
        selectStatus = 2
        restaurantBtn.setTitleColor(UIColor.white, for: .normal)
        userBtn.setTitleColor(UIColor.black, for: .normal)
        restaurantBtn.backgroundColor = UIColor(named: "themeOrange")
        userBtn.backgroundColor = UIColor.systemGray6
        if sender.isSelected == false{
            stackViewRestaurant.isHidden = false
            viewButton.isHidden = false
        }
    }
    
    @IBAction func btnUser(_ sender: UIButton) {
        selectStatus = 1
        userBtn.setTitleColor(UIColor.white, for: .normal)
        restaurantBtn.setTitleColor(UIColor.black, for: .normal)
        userBtn.backgroundColor = UIColor(named: "themeOrange")
        restaurantBtn.backgroundColor = UIColor.systemGray6
        viewButton.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCountryPicker(_ sender : UIButton){
        CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            guard let self = self else { return }
            self.tfCountry.text = country.dialingCode
            self.countryCode = country.countryCode
        }
    }
    
    @IBAction func btbnSelectBar(_ sender: UIButton) {
        restoselctStatus = 2
        viewButton.isHidden = true
        restaurantBtn.setTitle("Bar/Club ▼", for: .normal)
    }
    
    @IBAction func btnSelectResto(_ sender: UIButton) {
        restoselctStatus = 1
        viewButton.isHidden = true
        restaurantBtn.setTitle("Restaurant ▼", for: .normal)
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        if !isFromSocial {
            self.viewmodel.signUpapi(isImage: self.isImageSelected, image: self.image , name: self.tfName.text ?? "", email: self.tfEmail.text ?? "", country_code: self.tfCountry.text ?? "",countrySymbol:self.countryCode, phone: self.tfPhone.text ?? "", password: self.tfPassword.text ?? "", confirmpassword: self.tfConfirmPass.text ?? "", devicetype: 1, isselected: self.isselected, longitude:Double( self.long ?? 0) , latitude: Double(self.lat ?? 0), location: self.Location, role: self.selectStatus,dob: self.dobTf.text ?? "") {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC")as! VerificationVC
                vc.btnCheckStatus = self.selectStatus
                vc.restoselctStatus = self.restoselctStatus
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            
                self.viewmodel.socialLoginAPI(socialId: socialLoginBody?.userId ?? "", socialType: socialType.rawValue, email: self.tfEmail.text ?? "", role: self.selectStatus, latitude: Double(self.lat ?? 0), longitude: Double( self.long ?? 0), location: self.Location, image: self.image, name: self.tfName.text ?? "", dob: dobTf.text ?? "",phone: tfPhone.text ?? "",countryCode: self.tfCountry.text ?? "") {
                  
                    if self.selectStatus == 1 {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifypopUpVC") as! VerifypopUpVC
                        vc.modalPresentationStyle = .overFullScreen
                        vc.callBack = {
                            Store.sociallogin = true
                            Store.autoLogin = true
                            Store.screenType = 1
                            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                            let nav = UINavigationController.init(rootViewController: redViewController)
                            nav.isNavigationBarHidden = true
                            UIApplication.shared.windows.first?.rootViewController = nav
                            
                        }
                        self.navigationController?.present(vc, animated: true)
                    }
                    
                    //MARK: - RESTO SIDE 2
                    else {
                        let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "restoCreateVC") as! restoCreateVC
                        vc.btnCheckStatus = self.restoselctStatus
                        if self.restoselctStatus == 1 {
                            vc.heading = "Restaurant Profile"
                            vc.name = "Restaurant Name"
                            UserDefaults.standard.set("Restaurant", forKey: "name")
                        }else if  self.restoselctStatus == 2 {
                            vc.heading = "Club Profile"
                            vc.name = "Club Name"
                            UserDefaults.standard.set("Club", forKey: "name")
                        } else {
                            vc.heading = "Bar Profile"
                            vc.name = "Bar Name"
                            UserDefaults.standard.set("Bar", forKey: "name")
                        }
                        UserDefaults.standard.set(self.restoselctStatus, forKey: "status")
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
   
    @IBAction func termSConditionsBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TermsConditionVC")as! TermsConditionVC
        vc.status = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnEyeAct(_ sender : UIButton){
        if sender.tag == 0 {
            sender.isSelected == false ? (tfPassword.isSecureTextEntry = false) : (tfPassword.isSecureTextEntry = true)
            sender.isSelected = !sender.isSelected
        }else if sender.tag == 1 {
            sender.isSelected == false ? (tfConfirmPass.isSecureTextEntry = false) : (tfConfirmPass.isSecureTextEntry = true)
            sender.isSelected = !sender.isSelected
        }
    }
    
    @IBAction func btnCheckAct(_ sender : UIButton){
        sender.isSelected = !sender.isSelected
        //sender.isSelected == false ? (sender.layer.borderWidth = 0): (sender.layer.borderWidth = 1)
        switch sender.isSelected {
        case true:
            isselected = true
        default:
            isselected = false
        }
        
        if checkFilledDeatils(isImage: self.isImageSelected, name: tfName.text ?? "", email: tfEmail.text ?? "", phone: tfPhone.text ?? "", dob: dobTf.text ?? "", pass: tfPassword.text ?? "", conPass: tfConfirmPass.text ?? "",isSelected: isselected){
            print("True")
            signUpBtn.isUserInteractionEnabled = true
            signUpBtn.backgroundColor = UIColor(named: "themeOrange")
        }else {
            print("false")
            signUpBtn.isUserInteractionEnabled = false
            signUpBtn.backgroundColor = .lightGray
        }
        
        
    }
}

extension SignUPVC {
    
    func checkFilledDeatils(isImage:Bool,name:String,email:String,phone:String,dob:String,pass:String,conPass:String,isSelected:Bool) -> Bool{
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            return false
        }
        if email.trimmingCharacters(in: .whitespaces).isEmpty{
            return false
        }
        if phone.trimmingCharacters(in: .whitespaces).isEmpty{
            return false
        }
        if selectStatus == 1{
            if dob.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
        }
        if !isFromSocial {
            if pass.trimmingCharacters(in: .whitespaces).isEmpty{
                return false
            }
            if conPass.trimmingCharacters(in: .whitespaces).isEmpty{
                return false
            }
        }
        
        if isSelected == false {
            return false
        }
        return true
    }
    
    
    
    func tapGesture(){
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(mytapGestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender:UITapGestureRecognizer){
        //viewButton.isHidden = true
    }
}

extension SignUPVC : CLLocationManagerDelegate {
    
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
        //  self.locationLbl.text = location
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
                self.Location = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
}




extension SignUPVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if checkFilledDeatils(isImage: self.isImageSelected, name: tfName.text ?? "", email: tfEmail.text ?? "", phone: tfPhone.text ?? "", dob: dobTf.text ?? "", pass: tfPassword.text ?? "", conPass: tfConfirmPass.text ?? "",isSelected: isselected){
            print("True")
            signUpBtn.isUserInteractionEnabled = true
            signUpBtn.backgroundColor = UIColor(named: "themeOrange")
        } else {
            print("false")
            signUpBtn.isUserInteractionEnabled = false
            signUpBtn.backgroundColor = .lightGray
        }
        
        
        
        if textField == self.tfName{
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: String =
            currentString.replacingCharacters(in: range, with: string) as String
            return string.containsValidCharacter && newString.length() <= 30
        }else if textField == self.tfEmail{
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: String =
            currentString.replacingCharacters(in: range, with: string) as String
            return newString.length() <= 30
        }else if textField == self.tfPassword || textField == self.tfConfirmPass {
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: String =
            currentString.replacingCharacters(in: range, with: string) as String
            return newString.length() <= 30
        }
        
        
        return true
    }
    
    
    
}
//MARK: - CAMERA ACCSESS
extension SignUPVC {
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        default: print("kkkkk")
        }
    }
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "Enable Camera Permission",
                                                message: "Camera access is denied",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
}


class AnywhereSwipeGestureRecognizer: UIScreenEdgePanGestureRecognizer {
    override func shouldReceive(_ event: UIEvent) -> Bool {
        return true
    }
}
extension SignUPVC {
    
    
    func requestLocationPermission() {
        if locationManager == nil {
            locationManager = CLLocationManager()
        }
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
    }
}
extension SignUPVC {
    //MARK: - DatePicker 1
    func showDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        dobTf.inputAccessoryView = toolbar
        dobTf.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dobTf.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        if checkFilledDeatils(isImage: self.isImageSelected, name: tfName.text ?? "", email: tfEmail.text ?? "", phone: tfPhone.text ?? "", dob: dobTf.text ?? "", pass: tfPassword.text ?? "", conPass: tfConfirmPass.text ?? "",isSelected: isselected){
            print("True")
            signUpBtn.isUserInteractionEnabled = true
            signUpBtn.backgroundColor = UIColor(named: "themeOrange")
        } else {
            print("false")
            signUpBtn.isUserInteractionEnabled = false
            signUpBtn.backgroundColor = .lightGray
        }
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
}

