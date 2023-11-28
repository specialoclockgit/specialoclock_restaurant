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

class SignUPVC: UIViewController {
    
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
    @IBOutlet weak var btnMainRB : UIButton!
    @IBOutlet weak var btnBar : UIButton!
    @IBOutlet weak var btnRestaurant : UIButton!
    
    //MARK: Variables
    var viewmodel = AuthViewModel()
    let locationManager = CLLocationManager()
    var isImageSelected = false
    var isselected = false
    var lat : Double?
    var long : Double?
    var imgString:String?
    var Location = String()
    var countryCode = String()
    var image = [FileuploadModelBody]()
    var selectStatus = Int()
    var restoselctStatus = Int()
    
    
    //MARK: ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.delegate = self
        tfPhone.delegate = self
        tfPassword.delegate = self
        tfConfirmPass.delegate = self
        uiSet()
        DispatchQueue.global().async {
            if (CLLocationManager.locationServicesEnabled()){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.startUpdatingLocation()
            }
            else
            {
#if debug
                println("Location services are not enabled");
#endif
            }
        }
        
        uiSet()
    }
    
    //MARK: - Function
    func uiSet(){
        tapGesture()
        view.hideKeyboardWhenTappedAround()
        viewButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    //MARK: - Function
    
    // MARK: - Actions
    @IBAction func btnProfile(_ sender : UIButton){
        self.checkCameraAccess()
        ImagePicker().pickImage(self) { (image) in
            self.imgProfile.image = image
            self.viewmodel.fileUploadedAPI(type: "image", image: image) { [weak self] imageData in
                self?.image = imageData ?? [FileuploadModelBody]()
                self?.isImageSelected = true
            }
        }
    }
    @IBAction func btnResto(_ sender: UIButton) {
        selectStatus = 2
        restaurantBtn.setTitleColor(UIColor.white, for: .normal)
        userBtn.setTitleColor(UIColor.black, for: .normal)
        restaurantBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        userBtn.backgroundColor = UIColor.systemGray6
        if sender.isSelected == false{
            stackViewRestaurant.isHidden = false
            viewButton.isHidden = false
        }
    }
    
    @IBAction func btnUser(_ sender: UIButton) {
        selectStatus = 0
        userBtn.setTitleColor(UIColor.white, for: .normal)
        restaurantBtn.setTitleColor(UIColor.black, for: .normal)
        userBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        restaurantBtn.backgroundColor = UIColor.systemGray6
        viewButton.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCountryPicker(_ sender : UIButton){
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            guard let self = self else { return }
            self.tfCountry.text = country.dialingCode
            self.countryCode = country.countryCode
            print(self.countryCode)
        }
    }
    
    @IBAction func btbnSelectBar(_ sender: UIButton) {
        restoselctStatus = 2
        viewButton.isHidden = true
        restaurantBtn.setTitle("Bar ▼", for: .normal)
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
        self.viewmodel.signUpapi(isImage: self.isImageSelected, image: self.image , name: self.tfName.text ?? "", email: self.tfEmail.text ?? "", country_code: self.tfCountry.text ?? "",countrySymbol:self.countryCode, phone: self.tfPhone.text ?? "", password: self.tfPassword.text ?? "", confirmpassword: self.tfConfirmPass.text ?? "", devicetype: 1, isselected: self.isselected, longitude:Double( self.long ?? 0) , latitude: Double(self.lat ?? 0), location: self.Location, role: self.selectStatus) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC")as! VerificationVC
            vc.btnCheckStatus = self.selectStatus
            vc.restoselctStatus = self.restoselctStatus
            self.navigationController?.pushViewController(vc, animated: true)
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
        sender.isSelected == false ? (sender.layer.borderWidth = 0): (sender.layer.borderWidth = 1)
        switch sender.isSelected {
        case true:
            isselected = true
        default:
            isselected = false
        }
    }
}

extension SignUPVC {
    func tapGesture(){
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(mytapGestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender:UITapGestureRecognizer){
        //viewButton.isHidden = true
    }
}

extension SignUPVC : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
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
            }
        }
        locationManager.stopUpdatingLocation()
    }
}

extension SignUPVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        if textField == self.tfPhone{
        //            let maxLength = AuthViewModel.getCountryBasedMobileNumberRange(code: self.countryCode)
        //            let currentString: NSString = (textField.text ?? "") as NSString
        //            let newString: String =
        //            currentString.replacingCharacters(in: range, with: string) as String
        //            if newString.first == "0"{
        //                return false
        //            }
        //            return newString.count <= maxLength
        //        }else
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
