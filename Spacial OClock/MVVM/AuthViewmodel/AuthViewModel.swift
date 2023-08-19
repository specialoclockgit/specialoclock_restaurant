//
//  AuthViewModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 07/08/23.
//

import Foundation
import UIKit

class AuthViewModel : NSObject {
    var selectedImageArr = [parameters]()
    var imageData = String()
    var eventImgString = String()
    
    //MARK: - SIGN UP API
    func signUpapi(name : String, email: String,country_code: String, phone: String ,password:String, confirmpassword: String,devicetype: Int, image: UIImage, isselected:Bool,longitude:Double,latitude:Double,location:String, onsuccess: @escaping ((()->()))){
        
        if CheckValidations.validationSignUp(name: name, email: email, country_code: country_code, phone: phone, password: password, confirmpassword: confirmpassword, devicetype:1 , img: image, isselected: isselected){
            
            let param : parameters = [ "image":imageData,"name":name, "email":email, "country_code":country_code ,"phone":phone,  "password":password,"device_token":DEVICE_TOKEN,"latitude":latitude, "longitude":longitude,"location":location,"role":2, "device_type":1] as [String : Any]
         
            WebService.service(API.signup,  param: param, service: .post){
                (modeldata: SignupModel, data, json) in
                Store.authKey = modeldata.body?.token ?? ""
                Store.userDetails = modeldata.body
                onsuccess()
            }
        }
    }
    // MARK: - Image Upload
    func fileUploadedAPI(type: String, image:UIImage,onSuccess:@escaping((String)->())) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.fullDate.rawValue
        let date = formatter.string(from: Date())
        let imageInfo : ImageStructInfo
        
        imageInfo = ImageStructInfo.init(fileName: "Img\(date).jpeg", type: "image/jpeg", data: image.toData(), key: "image", image: image)
        
        let param = ["type": type, "folder": "users", "image": imageInfo] as [String : Any]
        
        WebService.service(API.file_upload, param: param, service: .post, showHud: true) {
            (userData: FileuploadModel , data, json) in
            self.imageData = ""
            for indx in 0..<(userData.body.count ?? 0){
                let image = userData.body[indx].image
                let thumbnail = userData.body[indx].thumbnail
                let fileName = userData.body[indx].fileName
                let folder = userData.body[indx].folder
                let file_type = userData.body[indx].fileType
                let newDict : parameters = ["image":image,"thumbnail":thumbnail,"fileName":fileName,"folder":folder,"file_type":file_type]
                self.selectedImageArr.append(newDict)
            }
            onSuccess(self.selectedImageArr.toJSONString())
            self.eventImgString = self.selectedImageArr.toJSONString()
            self.imageData = self.selectedImageArr.toJSONString()
        }
    }
    

    //MARK: - LOGIN API
    func loginApicall(email:String, password:String,device_type:Int ,onSuccess: @escaping (()->())) {
        if email.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Enter your email", isSuccess: .error)
        }else if password.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Enter your password", isSuccess: .error)
        }else{
            
            let param: parameters = ["email":email,
                                     "password":password,"device_token":DEVICE_TOKEN,"device_type":device_type ]
            
            WebService.service(API.login, param: param, service: .post){
                (modaldata: SignupModel , Data, Json) in
                Store.userDetails = modaldata.body
                Store.authKey = modaldata.body?.token ?? ""
                Store.autoLogin = true
                onSuccess()
            }
        }
        
    }
    
    
    //    MARK: - VERIFICATION OTP
    func otpverification(otp:String, onSuccess :@escaping()->()){
        if otp.count < 4 {
            CommonUtilities.shared.showAlert(message: "Please enter otp", isSuccess: .error)
        }else{
            let param : parameters = ["otp":otp]
           
            WebService.service(API.verify_otp, param: param, service: .post){
                (modaldata : CommonModel , data, json) in
                onSuccess()
            }
        }
    }
    
    
    //MARK: RESEND OTP
    func resendOtp(phone: String ,onSuccess : @escaping (()->())) {
        
        let params = ["phone": phone] as [String : Any]
        
        WebService.service(API.resend_otp, param: params , service: .post, showHud: true) {
            (modaldata : ResendOtpModel , Data, Json) in
         //   CommonUtilities.shared.showAlert(message: "Your OTP is \(modaldata.body?.otp ?? 0)", isSuccess: .success)
            onSuccess()
        }
    }

    
    //MARK: Forgot Password
    func ForgotPassword(email: String, onSuccess : @escaping (()->())){
        if  email.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter  email", isSuccess: .error)
        }else{
            let param: parameters = ["email" : email]
            print(param)
            WebService.service(API.forgot_password, param: param, service: .post) {
                (modaldata: ForgotpasswordModel , Data, Json) in
                onSuccess()
            }
        }
    }
    //MARK: - PRIVACY POLICY
    func privacypolicyApi(onSuccess : @escaping ((TermsconditionModelBody?)->())){
        WebService.service(API.privacypolicy ,service: .get, showHud: true) {
            (modaldata: TermsconditionModel , Data, Json) in
            onSuccess(modaldata.body)
        }
    }
    //MARK: - TERMS & CONDITION
    func termsandconditionApi(onSuccess : @escaping ((TermsconditionModelBody?)->())){
        WebService.service(API.termsAndCondition ,service: .get, showHud: true) {
            (modaldata: TermsconditionModel , Data, Json) in
            onSuccess(modaldata.body)
        }
    }
    func helpandFaq(onSuccess : @escaping (([HelpandFAQModelBody]?)->())){
        WebService.service(API.faq ,service: .get, showHud: true) {
            (modaldata: HelpandFAQModel , Data, Json) in
            onSuccess(modaldata.body ?? [])
        }
    }
    
    //    MARK: -  DELETE ACCOUNT
    func deleteAccountApi(onsuccess:@escaping (()->())){
        WebService.service(API.delete_account, service: .post) {
            (modaldata: CommonModel , Data, Json) in
            Store.userDetails = nil
            Store.autoLogin = false
            onsuccess()
        }
    }
    //  MARK: - CHANGE PASSWORD
    func changePasswordapicall(oldpassword: String, newpassword: String, confirmpassword: String, onsuccess: @escaping (()->())){
        if oldpassword.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter old password", isSuccess: .error)
        }else if oldpassword == newpassword{
            CommonUtilities.shared.showAlert(message: "Old password and new password should not be same", isSuccess: .error)
        }else if newpassword.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter new password", isSuccess: .error)
        }else if newpassword.count <= 5{
            CommonUtilities.shared.showAlert(message: "Please enter password minimum 6 characters", isSuccess: .error)
        }else if confirmpassword.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter confirm  password", isSuccess: .error)
        }else if confirmpassword != newpassword{
            CommonUtilities.shared.showAlert(message: "New password and confirm password should be same", isSuccess: .error)
        }else{
            let param : parameters = ["old_password":oldpassword,
                                      "new_password":newpassword,
                                      "confirm_password":confirmpassword]
           
            WebService.service(API.change_password, param: param, service: .post){
                (modaldata : CommonModel , data, json) in
                onsuccess()
            }
        }
        
    }
    //    MARK: - CUSTMOR SUPPORT
    func contactUsApiCall(name:String, email:String,  message:String, onSuccess: @escaping (()->())){
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter name", isSuccess: .error)
        }else if email.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter email", isSuccess: .error)
        }else if email.isValidEmail{
            CommonUtilities.shared.showAlert(message: "Please enter valid email", isSuccess: .error)
        }else if message.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter message", isSuccess: .error)
        }else{
            let param: parameters = ["name":name, "email":email, "message":message]
            WebService.service(API.contactus ,param: param, service: .post) {
                (modaldata: ContactUsModel, Data, json) in
                CommonUtilities.shared.showAlert(message: "Customer support submmit successfully.", isSuccess: .success)
                onSuccess()
            }
        }
    }
    //MARK: - NOTIFICATION STATUS
    func NotificationStatus(notistatus:Int, OnSuccess: @escaping (()->())){
        let param: parameters = ["status":notistatus]
        print(param)
        WebService.service(API.Notification_status, param: param,service: .post) {
            (modaldata: NotificationStatusModel, data, json) in
            
            //Store.userDetails?.body?.notificationStatus = modaldata.body?.notificationStatus?.notificationStatus
            OnSuccess()
            
        }
    }
    //    MARK: - LOGOUT API CALL
    func logoutapicall(onsuccess: @escaping (()->())){
        WebService.service(API.logout, service: .post) {
            (modaldata: CommonModel, Data , json) in
            onsuccess()
        }
        
    }
    //MARK: - THEME API CALL
    func themeapicall(onsuccess: @escaping (([ThemeModelBody]?)->())){
        WebService.service(API.theme_list, service: .get) {
            (modaldata: ThemeModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    //MARK: - CATEGORY GET LIST
    func Categoryapicall(onsuccess: @escaping (([CategoryListingModelBody]?)->())){
        WebService.service(API.category_list, service: .get) {
            (modaldata: CategoryListingModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    //MARK: - CUISINE GET LIST
    func Cuisineapicall(onsuccess: @escaping (([CuisineListingModelBody]?)->())){
        WebService.service(API.cuisine_list, service: .get) {
            (modaldata: CuisineListingModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    //    NARK: - ADDBUSINESS
    func addbusinessApi(isImageSelected:Bool,Profileimage:UIImageView,type:Int,  name:String, image: [String], location:String, opentime:String, closetime:String,  themesrestrorantid:String, cusine: String,shortdescription: String, onsuccess:@escaping (()->())) -> Bool{
        if !(isImageSelected) {
            CommonUtilities.shared.showAlert(message: "Please select image ", isSuccess: .error)
            return false
        } else if name.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Enter your restaurant name", isSuccess: .error)
            return false
        } else if location.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Enter your location", isSuccess: .error)
            return false
        }else if opentime.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Enter open time", isSuccess: .error)
            return false
        }else if closetime.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Enter close time", isSuccess: .error)
            return false
        }else if themesrestrorantid.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Select your theme", isSuccess: .error)
            return false
        }else if cusine.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Select your cuisines", isSuccess: .error)
            return false
        }else if shortdescription.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Enter your short description", isSuccess: .error)
            return false
        }else{
            let param: parameters = ["type":type,
                                     "profile_image":imageData,
                                     "name": name,
                                     "image":imageData,
                                     "location":location,
                                     "open_time": opentime,
                                     "close_time":closetime,
                                     "short_description": shortdescription ]
            print(param)
            WebService.service(API.add_business, param: param, service: .post){
                (modeldata: AddbusinessModel, data, json) in
                onsuccess()
                
            }
        }
        return true
    }
    
    
    //MARK: - EDITPROFILE API
    func editprofile(name:String, phone: String, email: String, image:UIImageView, OnSuccess: @escaping (()->())){
//        let formatter = DateFormatter()
//        formatter.dateFormat = dateFormat.fullDate.rawValue
//        let date = formatter.string(from: Date())
//        let imageInfo : ImageStructInfo
//     imageInfo = ImageStructInfo.init(fileName: "Img\(date).jpg", type: "image/jpg", data: image.toData() ?? Data(), key: "image", image: image)

        let param: parameters = ["name":name,  "phone":phone, "email":email, "image":image]
        print(param)
        WebService.service(API.edit_profile, param: param,service: .post) {
            (modaldata: EditProfileModel, data, json) in
            OnSuccess()
            
        }
    }
   
    
    //MARK: Profile
    func ProfileAPI(onSuccess:@escaping ((GetProfileModel)->())) {
        
        WebService.service(.get_profile, service: .get, showHud: true) {
            (userData: GetProfileModel ,data, json) in
            onSuccess(userData)
        }
    }
}


