//
//  CheckValidations.swift
//  Schedula
//
//  Created by apple on 11/09/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SwiftMessages

class CheckValidations: NSObject{
    
    
    class func validateAddCard(name:String,cvv:String,cardNo:String,expiry:String) -> Bool {
        let trimmedString = cardNo.components(separatedBy: .whitespaces).joined()
        
        if cardNo.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Please enter card number")
            return false
        } else if trimmedString.count != 16 {
            CommonUtilities.shared.showAlert(message: "Please enter valid card number")
            return false
        } else if expiry.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Please enter card expiry month and year")
            return false
        } else if cvv.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Please enter card CVV")
            return false
        } else if name.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Please enter card holder name")
            return false
        }
        return true
    }
    
    
//     MARK: - SIGNUP -  VALDATION BAR Resturant
    
    class  func validationSignUp(isImage:Bool,name : String, email: String,country_code: String,countrySymbol:String, phone:String,password:String, confirmpassword: String,devicetype: Int, isselected:Bool) -> Bool{
        
//        if !(isImageSelected) {
//            CommonUtilities.shared.showAlert(message: "Please select image ", isSuccess: .error)
//            return false
//        } else
        
//        if image.isEqualToImage(image: UIImage(named: "Group 16274")!){
//            CommonUtilities.shared.showSwiftAlert(message: RegexMessage.emptyPhoto.rawValue, isSuccess: .error)
//            return false
//        }
//        if isImage == false {
//            CommonUtilities.shared.showAlert(message: "Please select image", isSuccess: .error)
//            return false
//        } else
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter your name", isSuccess: .error)
            return false
        } else if email.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter your email", isSuccess: .error)
            return false
        } else if email.isValidEmail {
            CommonUtilities.shared.showAlert(message: "Please enter valid email", isSuccess: .error)
            return false
        } else if country_code.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please select your country code", isSuccess: .error)
            return false
        }else if phone.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter your mobile number", isSuccess: .error)
            return false
        }else if phone.count < AuthViewModel.getCountryBasedMobileNumberRange(code: countrySymbol){
            CommonUtilities.shared.showAlert(message: "Please enter a valid mobile number",isSuccess: .error)
            return false
        }
//        else if phone.count <= 9{
//            CommonUtilities.shared.showAlert(message: "Please enter phone number minimum 10 characters", isSuccess: .error)
//            return false
//        }
        else if password.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter your password", isSuccess: .error)
            return false
        }else if password.count <= 5{
            CommonUtilities.shared.showAlert(message: "Please enter a password with a minimum of 6 characters", isSuccess: .error)
            return false
        }else if confirmpassword.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please confirm your password", isSuccess: .error)
            return false
        }else if password != confirmpassword{
            CommonUtilities.shared.showAlert(message: "Password and confirmation password should be the same", isSuccess: .error)
            return false
        }else if isselected == false {
            CommonUtilities.shared.showAlert(message: "Please accept the terms & conditions", isSuccess: .error)
            return false
        }
        return true
    }
    
    
    //MARK: Login VALIDATION
        class func loginValidation(email:UITextField,password:UITextField)-> Bool {
            if email.text!.isBlank {
                CommonUtilities.shared.showAlert(message: "Please enter your email", isSuccess: .error)
                return false
            }
            else if !email.text!.isValidemail {
                CommonUtilities.shared.showAlert(message: "Please enter a valid Email", isSuccess: .error)
                return false
            }
            else if password.text!.isBlank {
                CommonUtilities.shared.showAlert(message: "Please enter your password", isSuccess: .error)
                return false
            }
            return true
        }
    
//    class func validateSignUp(name : String, email: String, country_code: String , contact: String, password: String, confirmPassword: String, profile : UIImageView, gender: String, isSelected: Bool) -> Bool{
//        if (profile.image?.isEqualToImage(image: UIImage(named: "")!))!{
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidImage.rawValue)
//            return false
//        }
//        if name.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidName.rawValue )
//            return false
//        }else if !name.onlyAlphabet {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidAlphabetName.rawValue )
//            return false
//        }else if email.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidBlnkEmail.rawValue)
//            return false
//        }else if !Validation().validateEmailId(emailID: email){
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidEmail.rawValue)
//            return false
//        }
//        else if country_code.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidCountryCode.rawValue)
//            return false
//        }else if contact.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidPhnNo.rawValue)
//            return false
//        }else if contact.count < 10 || contact.count > 12{
//            CommonUtilities.shared.showAlert(message: RegexMessage.phoneLimitExceedError.rawValue)
//            return false
//        }else  if gender == "Select" {
//            CommonUtilities.shared.showAlert(message: RegexMessage.selectGender.rawValue )
//            return false
//            // }
//            //else if !gender.onlyAlphabet {
//            //            CommonUtilities.shared.showAlert(message: RegexMessage.invalidAlphabetName.rawValue )
//            //            return false
//        } else if password.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidPassword.rawValue)
//            return false
//        }
////        else if !Validation().validatePassword(password: password){
////            CommonUtilities.shared.showAlert(message: RegexMessage.strongPasswordError.rawValue)
////            return false
////        }
//        else if (password.count < 9 || password.count > 16) {
//            CommonUtilities.shared.showAlert(message: RegexMessage.passwordRangeError.rawValue)
//            return false
//        }
//        else if confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidConfPassword.rawValue)
//            return false
//        }else if password != confirmPassword{
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidConfirmPassword.rawValue)
//            return false
//        }else if !Validation().validaPhoneNumber(phoneNumber: contact){
//            CommonUtilities.shared.showAlert(message: RegexMessage.phoneLimitExceedError.rawValue)
//            return false
//        }
//        else if isSelected == false{
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidTerms.rawValue)
//            return false
//        }
//        return true
//    }
//
//    //MARK: - LOGIN - VALIDATION
//    class func validateLogin(email: String, password: String) -> Bool{
//        if email.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidBlnkEmail.rawValue)
//            return false
//        }else if !Validation().validateEmailId(emailID: email){
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidEmail.rawValue)
//            return false
//        }else if password.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidPassword.rawValue)
//            return false
//        }
//        return true
//    }

    
        
    
//    //MARK: - FORGOT PASSWORD - VALIDATION
//    class func validateForgot(email: String) -> Bool{
//        if email.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidBlnkEmail.rawValue)
//            return false
//        }else if !Validation().validateEmailId(emailID: email){
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidEmail.rawValue)
//            return false
//        }
//        return true
//    }
//
//
//    //MARK: - CHANGE PASSWORD - VALIDATION
//    class func validateChangePassword(oldPass: String, newPass: String, confirmPass : String)-> Bool{
//        if oldPass.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidOldPassword.rawValue)
//            return false
//        }
////        else if oldPass != oldPass{
////            CommonUtilities.shared.showAlert(message: RegexMessage.oldpass.rawValue)
////        }
//
//        else if newPass.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidNewPassword.rawValue)
//            return false
//        }else if confirmPass.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidConfPassword.rawValue)
//            return false
//        } else if !Validation().validatePassword(password: newPass){
//            CommonUtilities.shared.showAlert(message: RegexMessage.strongPasswordError.rawValue)
//            return false
//        }else if newPass != confirmPass{
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidConfirmPassword.rawValue)
//            return false
//        }
//        return true
//    }
//
//    // MARK: -  CONTACT US VALIDATION
//    class func validateContactUs(name: String, email: String, message : String)-> Bool{
//        if name.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidName.rawValue)
//            return false
//        }else if email.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidBlnkEmail.rawValue)
//            return false
//        }else if email.isValidEmail {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidEmail.rawValue)
//            return false
//        }else if message.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.enterMessage.rawValue)
//            return false
//        }
//        return true
//    }
//
//    // MARK: EDIT PROFILE - VALIDATION
//    class func validateProfile(name: String, contact : String, email : String, country : Int) -> Bool{
//        if name.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidName.rawValue)
//            return false
//        }else if contact.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidPhnNo.rawValue)
//            return false
//        }else if email.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidBlnkEmail.rawValue)
//            return false
//        }else if !Validation().validateEmailId(emailID: email){
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidEmail.rawValue)
//            return false
//        }
//        //        }else if !Validation().validaPhoneNumber(phoneNumber: contact){
//        //            CommonUtilities.shared.showAlert(message: RegexMessage.phoneLimitExceedError.rawValue)
//        //            return false
//        //        }
//        return true
//    }
//
//
//    //MARK: ADD ADDRESS - VALIDATION
//    class func validateAddress(name: String, contact: String,country: String, city:String, address : String, streetandhouse : String , postalcode : String)-> Bool{
//        if name.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidName.rawValue)
//            return false
//        }else if name.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidName.rawValue)
//            return false
//        }else if contact.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidPhnNo.rawValue)
//            return false
//        }else if !Validation().validaPhoneNumber(phoneNumber: contact){
//            CommonUtilities.shared.showAlert(message: RegexMessage.phoneLimitExceedError.rawValue)
//            return false
//        }
//        else if address.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidAddress.rawValue)
//            return false
//        }
//        else if streetandhouse.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.streetandHouse.rawValue)
//            return false
//        }
//        else if postalcode.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.postalcode.rawValue)
//            return false
//        }
//        else if city.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidCity.rawValue)
//            return false
//        }
//        else if country.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidCountry.rawValue)
//            return false
//        }
//        return true
//    }
//
//    //MARK: ADD REVIEW - VALIDATION
//    class func validateReview(review: String,rating: Int) -> Bool{
//        if review.trimmingCharacters(in: .whitespaces).isEmpty {
//            CommonUtilities.shared.showAlert(message: RegexMessage.invalidRating.rawValue)
//            return false
//        }else if rating == 0{
//            CommonUtilities.shared.showAlert(message: RegexMessage.emptyRating.rawValue)
//            return false
//        }
//        return true
//    }
    
    //    class func validateNewCardFields(name: String, cardNumber: String, expiry: String, cvv: String) -> Bool{
    //        let trimmedString = cardNumber.components(separatedBy: .whitespaces).joined()
    //        if name.trimmingCharacters(in: .whitespaces).isEmpty{
    //            CommonUtilities.shared.showAlert(message: RegexMessage.cardHolderNameError.rawValue)
    //            return false
    //        }else if cardNumber.trimmingCharacters(in: .whitespaces).isEmpty{
    //            CommonUtilities.shared.showAlert(message: RegexMessage.cardNumberError.rawValue)
    //            return false
    //        }else if trimmedString.count != 16{
    //            CommonUtilities.shared.showAlert(message: RegexMessage.invalidCardNumberError.rawValue)
    //            return false
    //        }
    //        else if expiry.trimmingCharacters(in: .whitespaces).isEmpty{
    //            CommonUtilities.shared.showAlert(message: RegexMessage.expiryDateError.rawValue)
    //            return false
    //        }else if cvv.trimmingCharacters(in: .whitespaces).isEmpty{
    //            CommonUtilities.shared.showAlert(message: RegexMessage.invalidCvvError.rawValue)
    //            return false
    //        }
    //        return true
    //    }
}

