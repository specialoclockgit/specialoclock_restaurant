//
//  UserEditProfileVC.swift
//  Spacial OClock
//
//  Created by cql211 on 18/07/23.
//

import UIKit
import SKCountryPicker

class UserEditProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var imgProfile : UIImageView!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfPhoneNumber : UITextField!
    @IBOutlet weak var tfCountryCode : UITextField!
    @IBOutlet weak var tfEmail : UITextField!
    @IBOutlet weak var viewProfile : UIView!
    
    //MARK: PROPERTIES
    var viewmodel = AuthViewModel()
    var profileBody : GetprofileModelBody?
    var countryCode = String()
    var image = [FileuploadModelBody]()
    var isImage = false
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.isUserInteractionEnabled = false
        tabBarController?.tabBar.isHidden = true
        viewProfile.layer.cornerRadius = viewProfile.frame.height / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        tfPhoneNumber.delegate = self
        tfName.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    private func setData() {
        self.viewmodel.ProfileAPI { data in
            self.profileBody = data
            self.imgProfile.showIndicator(baseUrl: imageURL, imageUrl: data?.image ?? "")
            self.tfName.text = data?.name.capitalized ?? ""
            self.tfEmail.text = data?.email ?? ""
            self.tfPhoneNumber.text = "\(data?.phone ?? 0)"
            self.tfCountryCode.text = "\(data?.countryCode ?? "")"
        }
    }
    
    //MARK: Button Action
    @IBAction func btnProfileAct(_ sender : UIButton) {
        ImagePicker().pickImage(self) { (image) in
            self.imgProfile.image = image
            self.viewmodel.fileUploadedAPI(type: "image", image: image) { [weak self] imageData in
                self?.image = imageData ?? [FileuploadModelBody]()
                self?.isImage = true
            }
        }
    }
    
    @IBAction func btnCountryPicker(_ sender : UIButton){
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            guard let self = self else { return }
            self.tfCountryCode.text = country.dialingCode
            self.countryCode = country.countryCode
            print(self.countryCode)
        }
    }
    
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveAct(_ sender : UIButton) {
        viewmodel.editprofile(isImage:self.isImage, name: tfName.text ?? "", phone: tfPhoneNumber.text ?? "",countrySymbol: self.countryCode,countryCode: self.tfCountryCode.text ?? "", email: tfEmail.text ?? "", image: self.image) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UserEditProfileVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.tfPhoneNumber {
            let maxLength = AuthViewModel.getCountryBasedMobileNumberRange(code: self.countryCode)
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: String =
            currentString.replacingCharacters(in: range, with: string) as String
            if newString.first == "0"{
                return false
            }
            return newString.count <= maxLength
        }else if textField == self.tfName {
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: String =
            currentString.replacingCharacters(in: range, with: string) as String
            return string.containsValidCharacter && newString.length() <= 30
        }
        return true
    }
}
