//
//  AuthViewModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 07/08/23.
//

import Foundation
import UIKit
import PhoneNumberKit

class AuthViewModel : NSObject {
    var selectedImageArr = [parameters]()
    var imageData = String()
    var eventImgString = String()
    
    //MARK: - SIGN UP API
    func signUpapi(isImage:Bool,image: [FileuploadModelBody], name : String, email: String,country_code: String,countrySymbol:String, phone: String ,password:String, confirmpassword: String,devicetype: Int,  isselected:Bool,longitude:Double,latitude:Double,location:String,role:Int,dob:String, onsuccess: @escaping ((()->()))) {
        
        if CheckValidations.validationSignUp(isImage:isImage,name: name, email: email, country_code: country_code,countrySymbol:countrySymbol, phone: phone, password: password, confirmpassword: confirmpassword, devicetype:1 , isselected: isselected){
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(image)
                let jsonString = String(data: jsonData, encoding: .utf8)
                guard let json = jsonString else{return}
                var param = parameters()
                param = [ "image":json,"name":name, "email":email, "country_code":country_code ,"phone":phone,  "password":password,"device_token":DEVICE_TOKEN,"latitude":latitude, "longitude":longitude,"location":location,"role":role, "device_type":1,"timezone":TimeZone.current.identifier]
                
                if role == 1 {
                    param["dob"] = dob
                }
                
                WebService.service(API.signup,  param: param, service: .post){
                    (modeldata: SignupModel, data, json) in
                    Store.authKey = modeldata.body?.token ?? ""
                    Store.userDetails = modeldata.body
                    onsuccess()
                }
            } catch {
                print("error--\(error.localizedDescription)")
            }
        }
    }

    // MARK: - Image Upload
    func fileUploadedAPI(type: String, image:UIImage,onSuccess:@escaping(([FileuploadModelBody]?)->())) {
        selectedImageArr.removeAll()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.fullDate.rawValue
        let date = formatter.string(from: Date())
        let imageInfo : ImageStructInfo
        
        imageInfo = ImageStructInfo.init(fileName: "Img\(date).jpeg", file_type: "image/jpeg", data: image.toData(), key: "image", image: image)
        
        let param = ["type": type, "folder": "users", "image": imageInfo] as [String : Any]
        print(param)
        
        WebService.service(API.file_upload, param: param, service: .post, showHud: true) {
            (userData: FileuploadModel , data, json) in
           
            for indx in 0..<(userData.body.count ){
                let image = userData.body[indx].image
                let thumbnail = userData.body[indx].thumbnail
                let fileName = userData.body[indx].fileName
                let folder = userData.body[indx].folder
                let file_type = userData.body[indx].file_type
                let newDict : parameters = ["image":image,"thumbnail":thumbnail,"fileName":fileName,"folder":folder,"file_type":file_type]
                self.selectedImageArr.append(newDict)
            }
            onSuccess(userData.body)
        }
    }
    
    //MARK: - LOGIN API
    func loginApicall(email:String, password:String,device_type:Int,role:Int,timeZone:String ,onSuccess: @escaping (()->())) {
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Please enter your email", isSuccess: .error)
        }else if !email.isValidemail {
            CommonUtilities.shared.showAlert(message: "Please enter a valid Email", isSuccess: .error)
        }else if password.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Please enter your password", isSuccess: .error)
        }else {
            let param: parameters = ["email":email,"password":password,"device_token":DEVICE_TOKEN,"device_type":device_type,"timezone":timeZone]
            //,"role":role
            WebService.service(API.login, param: param, service: .post){
                (modaldata: SignupModel , Data, Json) in
                Store.userDetails = modaldata.body
                Store.authKey = modaldata.body?.token ?? ""
                //Store.autoLogin = true
                onSuccess()
            }
        }
    }
    
    //MARK: - VERIFICATION OTP
    func otpverification(otp:String, onSuccess :@escaping()->()){
        if otp.count < 4 {
            CommonUtilities.shared.showAlert(message: "Please enter the OTP", isSuccess: .error)
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
            onSuccess()
        }
    }
    
    //MARK: Forgot Password
    func ForgotPassword(email: String, onSuccess : @escaping (()->())) {
        if  email.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter your email", isSuccess: .error)
        }else{
            let param: parameters = ["email" : email]
            print(param)
            WebService.service(API.forgot_password, param: param, service: .post) {
                (modaldata: ForgotpasswordModel , Data, Json) in
                onSuccess()
            }
        }
    }
    
    //MARK: cms
    func cmsAPI(type: Int, onSuccess:@escaping ((CMSModel)->())) {
        
        WebService.service(.get_content,urlAppendId: type, service: .get, showHud: true) {
            (userData: CMSModel, data, json) in
            onSuccess(userData)
        }
    }

//    //MARK: - PRIVACY POLICY
//    func privacypolicyApi(onSuccess : @escaping ((TermsconditionModelBody?)->())){
//        WebService.service(API.privacypolicy ,service: .get, showHud: true) {
//            (modaldata: TermsconditionModel , Data, Json) in
//            onSuccess(modaldata.body)
//        }
//    }
//    //MARK: - TERMS & CONDITION
//    func termsandconditionApi(onSuccess : @escaping ((TermsconditionModelBody?)->())){
//        WebService.service(API.termsAndCondition ,service: .get, showHud: true) {
//            (modaldata: TermsconditionModel , Data, Json) in
//            onSuccess(modaldata.body)
//        }
//    }
    func helpandFaq(onSuccess : @escaping (([HelpandFAQModelBody]?)->())){
        WebService.service(API.faq ,service: .get, showHud: true) {
            (modaldata: HelpandFAQModel , Data, Json) in
            onSuccess(modaldata.body )
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
            CommonUtilities.shared.showAlert(message: "Please enter your old password", isSuccess: .error)
        }else if oldpassword == newpassword{
            CommonUtilities.shared.showAlert(message: "Old password and new password should not be the same", isSuccess: .error)
        }else if newpassword.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter your new password", isSuccess: .error)
        }else if newpassword.count <= 5{
            CommonUtilities.shared.showAlert(message: "Please enter a password with a minimum of 6 characters", isSuccess: .error)
        }else if confirmpassword.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please confirm your password", isSuccess: .error)
        }else if confirmpassword != newpassword{
            CommonUtilities.shared.showAlert(message: "New password and confirmation password should be the same", isSuccess: .error)
        }else{
            let param : parameters = ["old_password":oldpassword,
                                      "new_password":newpassword,
                                      "confirm_password":confirmpassword]
           
            WebService.service(API.change_password, param: param, service: .post){
                (modaldata : CommonModel , data, json) in
                CommonUtilities.shared.showAlert(message: modaldata.message ?? "", isSuccess: .success)
                onsuccess()
            }
        }
        
    }
    //    MARK: - CUSTMOR SUPPORT
    func contactUsApiCall(name:String, email:String,  message:String, onSuccess: @escaping (()->())){
        if name.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter name", isSuccess: .error)
        }else if email.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter your email", isSuccess: .error)
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
    func addbusinessApi(singleimage:Bool,isImageSelected:Bool,country:String,state:String,city:String,latitude:Double,longitude:Double,Profileimage:[FileuploadModelBody],type:Int, name:String, image: [FileuploadModelBody], location:String, opentime:String, closetime:String,  themesrestrorantid:String, cusine: String,shortdescription: String, category:String,onsuccess:@escaping (()->())) -> Bool{
//        if !(singleimage) {
//            CommonUtilities.shared.showAlert(message: "Please select image ", isSuccess: .error)
//            return false
//        }  else if !(isImageSelected) {
//            CommonUtilities.shared.showAlert(message: "Please select image ", isSuccess: .error)
//            return false
//        } else
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Enter your restaurant name", isSuccess: .error)
            return false
        } else if country.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Select your country", isSuccess: .error)
            return false
        } else if location.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Select your location", isSuccess: .error)
            return false
        } else if opentime.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Enter opening time", isSuccess: .error)
            return false
        } else if closetime.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Enter closing time", isSuccess: .error)
            return false
        }
//        else if themesrestrorantid.trimmingCharacters(in: .whitespaces).isEmpty{
//            CommonUtilities.shared.showAlert(message: "Select your theme", isSuccess: .error)
//            return false
//        }
//        else if cusine.trimmingCharacters(in: .whitespaces).isEmpty{
//            CommonUtilities.shared.showAlert(message: "Select your cuisines", isSuccess: .error)
//            return false
//        }
        else if shortdescription.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Enter a short description", isSuccess: .error)
            return false
        } else if category.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Select your category", isSuccess: .error)
            return false
        } else {
            addResto(type: type,Profileimage:Profileimage, country:country,state:state,city:city,latitude:latitude,longitude:longitude,name: name, image: image, location: location, opentime: opentime, closetime: closetime, themesrestrorantid: themesrestrorantid, cusine: cusine, shortdescription: shortdescription, category: category) { (data) in
                onsuccess()
            }
            return true
        }
        
    }
    
    
    func addResto(type:Int,Profileimage:[FileuploadModelBody],country:String,state:String,city:String,latitude:Double,longitude:Double, name:String, image: [FileuploadModelBody], location:String, opentime:String, closetime:String,  themesrestrorantid:String, cusine: String,shortdescription: String,category:String, onsuccess: @escaping (((AddbusinessModel?)->()))) {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(Profileimage)
            let jsonString = String(data: jsonData, encoding: .utf8)
            guard let json = jsonString else{return}
            
            let jsonDataimage = try jsonEncoder.encode(image)
            let jsonStringimage = String(data: jsonDataimage, encoding: .utf8)
            guard let jsonimage = jsonStringimage else{return}
            var param =  parameters()
            param = ["type":type,"name": name,
                     "location":location,
                     "open_time": opentime,
                     "close_time":closetime,
                     "short_description": shortdescription,
                     "cuisine_ids":cusine,
                     "country":country,
                     "state":state,
                     "city":city,
                     "category_ids":category,
                     "latitude":latitude,
                     "country_code":Store.userDetails?.countryCode ?? "",
                     "mobile":Store.userDetails?.phone ?? 0,
                     "longitude":longitude]
            
            if json != "[]"{
                param["profile_image"] = json
            }
            
            if jsonimage != "[]"{
                param["image"] = jsonimage
            }
            
            if themesrestrorantid != "0"{
                param["themes_restrorant_id"] = themesrestrorantid
            }
            
            WebService.service(API.add_business, param: param, service: .post){
                (modeldata: AddbusinessModel, data, json) in
                onsuccess(modeldata)
            }
        } catch {
            print("error--\(error.localizedDescription)")
        }
    }
    
    
    //MARK: - EDITPROFILE API
    func editprofile(isImage:Bool, name:String, phone: String,countrySymbol: String,countryCode: String, email: String, image: [FileuploadModelBody], OnSuccess: @escaping (()->())) {
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            CommonUtilities.shared.showAlert(message: "Please enter your name", isSuccess: .error)
        }else if phone.trimmingCharacters(in: .whitespaces).isEmpty{
            CommonUtilities.shared.showAlert(message: "Please enter your mobile number", isSuccess: .error)
        }else if phone.count < AuthViewModel.getCountryBasedMobileNumberRange(code: countrySymbol){
            CommonUtilities.shared.showAlert(message: "Please enter a valid mobile number",isSuccess: .error)
        }else {
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(image)
                let jsonString = String(data: jsonData, encoding: .utf8)
                guard let json = jsonString else{return}
                var param: parameters = ["name":name, "phone":phone, "email":email,"country_code":countryCode]
                
                if isImage == true {
                   param["image"] = json
                }
                
                print(param)
                WebService.service(API.edit_profile, param: param,service: .post) {
                    (modaldata: EditProfileModel, data, json) in
                    Store.userDetails?.image = modaldata.body.image
                    OnSuccess()
                }
            } catch {
                print("error--\(error.localizedDescription)")
            }
        }
    }
   
    
    //MARK: Profile
    func ProfileAPI(onSuccess:@escaping ((GetprofileModelBody?)->())) {
        WebService.service(.get_profile, service: .get, showHud: true) {
            (userData: GetprofileModel ,data, json) in
            onSuccess(userData.body)
        }
    }
    
    class func getCountryBasedMobileNumberRange(code:String) -> Int {
        let phoneNumberKit = PhoneNumberKit()
        let sample = phoneNumberKit.metadata(for: code)?.mobile?.possibleLengths // 412345678
        var range = sample?.national ?? ""
        if range.contains(","){
            range = range.components(separatedBy: ",").last ?? "\(String.init(range.first!))"
        }
        return Int(range) ?? 0
    }
    
    
    //MARK: - LOCATION GET LIST
    func locationGetapicall(onsuccess: @escaping (([LocationListBody]?)->())){
        WebService.service(API.fetch_app_availability, service: .get) {
            (modaldata: LocationList, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - LOCATION GET LIST
    func locationListing(onsuccess: @escaping (([LocationList_Body]?)->())){
        WebService.service(API.location_listing, service: .get) {
            (modaldata: LocationListModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    
    // MARK: - Image Upload
    func fileUploadeMultipledAPI(type: String, image:[UIImage],onSuccess:@escaping(([FileuploadModelBody]?)->())) {
        
        selectedImageArr.removeAll()
        var uploadImages = [ImageStructInfo]()
        for i in 0..<image.count {
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat.fullDate.rawValue
            let date = formatter.string(from: Date())
            uploadImages.append(ImageStructInfo.init(fileName: "Img\(date).jpeg", file_type: "image/jpg", data: image[i].toData(), key: "image", image: image[i]))
        }
        let param = ["type": type, "folder": "users", "image": uploadImages] as [String : Any]
        print(param)
        
        WebService.service(API.file_upload, param: param, service: .post, showHud: true) {
            (userData: FileuploadModel , data, json) in
            
            for indx in 0..<(userData.body.count ){
                let image = userData.body[indx].image
                let thumbnail = userData.body[indx].thumbnail
                let fileName = userData.body[indx].fileName
                let folder = userData.body[indx].folder
                let file_type = userData.body[indx].file_type
                let newDict : parameters = ["image":image,"thumbnail":thumbnail,"fileName":fileName,"folder":folder,"file_type":file_type]
                self.selectedImageArr.append(newDict)
            }
            onSuccess(userData.body)
        }
    }
}


