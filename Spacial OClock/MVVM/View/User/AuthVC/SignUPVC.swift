//
//  SignUPVC.swift
//  Special O'Clock
//
//  Created by cql197 on 16/06/23.
//

import UIKit
import SKCountryPicker

class SignUPVC: UIViewController {
    
    //MARK: - Outlets
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
    
    //MARK: ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        stackViewRestaurant.isHidden = true
    }
    
    //MARK: - Function
    func uiSet(){
        view.hideKeyboardWhenTappedAround()
        
        userBtn.setTitleColor(UIColor.white, for: .normal)
        restaurantBtn.isHidden = true
        restaurantBtn.setTitleColor(UIColor.black, for: .normal)
        userBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        restaurantBtn.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        tfEmail.keyboardType = .alphabet
        tfName.keyboardType = .asciiCapable
    }
    
    // MARK: - Actions
    @IBAction func btnProfile(_ sender : UIButton){
        ImagePicker().pickImage(self) { (image) in
            self.imgProfile.image = image
//            self.isImageSelected = true
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "VerificationVC")as! VerificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnUser(_ sender: UIButton) {
        userBtn.setTitleColor(UIColor.white, for: .normal)
        restaurantBtn.setTitleColor(UIColor.black, for: .normal)
        userBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        restaurantBtn.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        
    }
    
    @IBAction func btnRestaurant(_ sender: UIButton) {
//        restaurantBtn.setTitleColor(UIColor.white, for: .normal)
//        userBtn.setTitleColor(UIColor.black, for: .normal)
//        restaurantBtn.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
//        userBtn.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
//        if sender.isSelected == false{
//            //debugPrint("Not Selected")
//            stackViewRestaurant.isHidden = false
//        }
    }
    
    @IBAction func btnSelectBar(_ sender : UIButton){
        if sender.isSelected == false{
            btnMainRB.setTitle("Bar ▼", for: .normal)
            stackViewRestaurant.isHidden = true
        }
    }
    @IBAction func btnSelectRestorant(_ sender : UIButton){
        if sender.isSelected == false{
            btnMainRB.setTitle("Restaurant ▼", for: .normal)
            stackViewRestaurant.isHidden = true
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
        sender.isSelected == false ? (sender.layer.borderWidth = 0): (sender.layer.borderWidth = 1)
        sender.isSelected = !sender.isSelected
    }
}
