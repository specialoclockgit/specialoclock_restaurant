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
    @IBOutlet weak var dobTf: UITextField!
    //MARK: PROPERTIES
    var viewmodel = AuthViewModel()
    var profileBody : GetprofileModelBody?
    var countryCode = String()
    var image = [FileuploadModelBody]()
    var isImage = false
    var callBack: (()->())?
    let datePicker = UIDatePicker()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.isUserInteractionEnabled = false
        tabBarController?.tabBar.isHidden = true
        viewProfile.layer.cornerRadius = viewProfile.frame.height / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        tfPhoneNumber.delegate = self
        tfName.delegate = self
        setData()
        setupDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func setData() {
        self.viewmodel.ProfileAPI { data in
            self.profileBody = data
            self.imgProfile.showIndicator(baseUrl: imageURL, imageUrl: data?.image ?? "")
            self.tfName.text = data?.name.capitalized ?? ""
            self.tfEmail.text = data?.email ?? ""
            self.tfCountryCode.text = "\(data?.countryCode ?? "")"
            self.dobTf.text = data?.dob ?? ""
            self.dobTf.isUserInteractionEnabled = data?.dob.isEmpty == true ? true : false
            if let phone = data?.phone, phone != 0 {
                self.tfPhoneNumber.text = phone.description
            }
            
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
     CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            guard let self = self else { return }
            self.tfCountryCode.text = country.dialingCode
            self.countryCode = country.countryCode
            print(self.countryCode)
        }
    }
    
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
        self.callBack?()
    }
    
    @IBAction func btnSaveAct(_ sender : UIButton) {
        viewmodel.editprofile(isImage:self.isImage, name: tfName.text ?? "", phone: tfPhoneNumber.text ?? "",countrySymbol: self.countryCode,countryCode: self.tfCountryCode.text ?? "", email: tfEmail.text ?? "", image: self.image,dob: dobTf.text ?? "") {
            CommonUtilities.shared.showAlert(message: "Profile updated successfully", isSuccess: .success)
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
extension UserEditProfileVC {
    //MARK: - DatePicker 1
    func setupDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "en")
        datePicker.calendar = Calendar(identifier: .gregorian)
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
        formatter.locale = Locale(identifier: "en")
        formatter.calendar = Calendar(identifier: .gregorian)
        dobTf.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
       
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
}
