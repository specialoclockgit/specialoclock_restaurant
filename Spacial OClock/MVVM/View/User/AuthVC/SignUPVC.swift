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
    @IBOutlet weak var btnMainRB : UIButton!
    @IBOutlet weak var btnBar : UIButton!
    @IBOutlet weak var btnRestaurant : UIButton!
    
    //MARK: Variables
   
    var viewmodel = AuthViewModel()
    let locationManager = CLLocationManager()
    var btnCheckStatus = Int()
    var isImageSelected = false
    var isselected = false
    var lat : Double?
    var long : Double?
    var imgString:String?
    var Location = String()
    
    //MARK: ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        btnCheckStatus = 0
        uiSet()
        //stackViewRestaurant.isHidden = true
       
    }
    
    //MARK: - Function
    func uiSet(){
        tapGesture()
        view.hideKeyboardWhenTappedAround()
        //userBtn.isHidden = true
        
    }
    //MARK: - Function
//    func uiSet(){
//        view.hideKeyboardWhenTappedAround()
//
//       // userBtn.setTitleColor(UIColor.white, for: .normal)
//       // restaurantBtn.isHidden = true
//      //  restaurantBtn.setTitleColor(UIColor.black, for: .normal)
//      //  userBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
//      //  restaurantBtn.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
//        tfEmail.keyboardType = .alphabet
//        tfName.keyboardType = .asciiCapable
//    }
    
    // MARK: - Actions
    @IBAction func btnProfile(_ sender : UIButton){
        ImagePicker().pickImage(self) { (image) in
            self.imgProfile.image = image
          self.isImageSelected = true
            self.viewmodel.fileUploadedAPI(type: "image", image: image) { data in
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnCountryPicker(_ sender : UIButton){
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            guard let self = self else { return }
            self.tfCountry.text = country.dialingCode
        }
    }
    
    @IBAction func btnSignIn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSignUp(_ sender: UIButton){
       // self.viewmodel.fileUploadedAPI(type: "image", image: imgProfile.image!) { img in
           
            self.viewmodel.signUpapi(image: self.imgProfile.image ?? UIImage(), name: self.tfName.text ?? "", email: self.tfEmail.text ?? "", country_code: self.tfCountry.text ?? "", phone: self.tfPhone.text ?? "", password: self.tfPassword.text ?? "", confirmpassword: self.tfConfirmPass.text ?? "", devicetype: 1, isselected: self.isselected, longitude:Double( self.long ?? 0) , latitude: Double(self.lat ?? 0), location: self.Location) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC")as! VerificationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    
   // @IBAction func btnUser(_ sender: UIButton) {
//        userBtn.setTitleColor(UIColor.white, for: .normal)
//        restaurantBtn.setTitleColor(UIColor.black, for: .normal)
//        userBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
       // restaurantBtn.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        
  //  }
    
//    @IBAction func btnSelectBar(_ sender : UIButton){
//        if sender.isSelected == false{
//            btnMainRB.setTitle("Bar ▼", for: .normal)
//            stackViewRestaurant.isHidden = true
//        }
//    }
//    @IBAction func btnSelectRestorant(_ sender : UIButton){
//        if sender.isSelected == false{
//            btnMainRB.setTitle("Restaurant ▼", for: .normal)
//            stackViewRestaurant.isHidden = true
//        }
//    }
    
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
