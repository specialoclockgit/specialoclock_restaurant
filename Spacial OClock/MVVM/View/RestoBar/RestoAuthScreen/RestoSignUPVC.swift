//
//  RestoSignUPVC.swift
//  Spacial OClock
//
//  Created by cql211 on 07/07/23.
//

import UIKit
import SKCountryPicker
import GooglePlaces
import CoreLocation

class RestoSignUPVC: UIViewController{
    
    //MARK: - Outlets
    @IBOutlet weak var tfConfirmpassword: CustomTextField!
    @IBOutlet weak var tfPhone: CustomTextField!
    @IBOutlet weak var tfName: CustomTextField!
    @IBOutlet weak var restaurantBtn: UIButton!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var imgProfile : UIImageView!
    @IBOutlet weak var tfCountry : UITextField!
    @IBOutlet weak var stackViewRestaurant : UIStackView!
    @IBOutlet weak var btnMainRB : UIButton!
    @IBOutlet weak var btnBar : UIButton!
    @IBOutlet weak var btnRestaurant : UIButton!
    @IBOutlet weak var tfPassword : UITextField!
    @IBOutlet weak var tfEmail : UITextField!
    @IBOutlet weak var viewButton : UIView!
    
    //MARK: Variables
    var btnCheckStatus = Int()
    var viewmodel = AuthViewModel()
    let locationManager = CLLocationManager()
    var isImageSelected = false
    var isselected = false
    var lat : Double?
    var long : Double?
    var imgString:String?
    var Location = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        stackViewRestaurant.isHidden = true
        viewButton.isHidden = true
    }
    
    //MARK: - Function
    func uiSet(){
        tapGesture()
        view.hideKeyboardWhenTappedAround()
        userBtn.isHidden = true
        
    }
    
    // MARK: - Actions
    @IBAction func btnProfile(_ sender : UIButton){
//        ImagePicker().pickImage(self) { (image) in
//            self.imgProfile.image = image
//            self.viewmodel.fileUploadedAPI(type: "image", image: image) { [weak self] imageData in
//                self?.imgString = imageData
//            }
//            self.isImageSelected = true
//        }
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
//        self.viewmodel.signUpapi(isImageSelected: self.isImageSelected , name: tfName.text ?? "", email: tfEmail.text ?? "", country_code: tfCountry.text ?? "", phone: tfPhone.text ?? "", password: tfPassword.text ?? "", confirmpassword: tfConfirmpassword.text ?? "", devicetype: 1, image: imgString ?? "" , isselected: self.isselected, longitude:Double( long ?? 0) , latitude: Double(lat ?? 0), location: Location ?? "") {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewController.RestoVerificationVC)as! RestoVerificationVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    
    @IBAction func btnUser(_ sender: UIButton) {
//        userBtn.setTitleColor(UIColor.white, for: .normal)
//        restaurantBtn.setTitleColor(UIColor.black, for: .normal)
//        userBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
//        restaurantBtn.backgroundColor = UIColor.systemGray6
//        viewButton.isHidden = true
    }
    
    @IBAction func btnRestaurant(_ sender: UIButton) {
//        restaurantBtn.setTitleColor(UIColor.white, for: .normal)
//        userBtn.setTitleColor(UIColor.black, for: .normal)
//        restaurantBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
//        userBtn.backgroundColor = UIColor.systemGray6
//        if sender.isSelected == false{
//            //debugPrint("Not Selected")
//            stackViewRestaurant.isHidden = false
//            viewButton.isHidden = false
//        }
    }
    
    @IBAction func btnSelectBar(_ sender : UIButton){
        btnCheckStatus = 1
        if sender.isSelected == false{
            btnMainRB.setTitle("Bar ▼", for: .normal)
            stackViewRestaurant.isHidden = true
            self.isselected = true
            viewButton.isHidden = true
        }
    }
    @IBAction func btnSelectRestorant(_ sender : UIButton){
        btnCheckStatus = 0
        if sender.isSelected == false{
            btnMainRB.setTitle("Restaurant ▼", for: .normal)
            stackViewRestaurant.isHidden = true
            viewButton.isHidden = true
        }
    }
    
    @IBAction func termSConditionsBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ViewController.PrivacyVC)as! PrivacyVC
        vc.heading = "Terms and Conditions"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCheckBoxAct(_ sender : UIButton){
        if sender.isSelected == false {
            sender.backgroundColor = UIColor(named: "themeOrange")
            sender.layer.borderWidth = 0
        }else{
            sender.backgroundColor = UIColor.white
            sender.layer.borderWidth = 1
        }
        sender.isSelected = !sender.isSelected
        isselected = true
    }
}
    //MARK: - CURRENT LOCATION
    
    extension RestoSignUPVC : CLLocationManagerDelegate{
        
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

    
    //MARK: Tap Gesture On View
    extension RestoSignUPVC {
        func tapGesture(){
            let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            self.view.addGestureRecognizer(mytapGestureRecognizer)
            view.isUserInteractionEnabled = true
            
        }
        @objc func handleTap(_ sender:UITapGestureRecognizer){
            viewButton.isHidden = true
        }
    }

