//
//  Constants.swift
//  
//
//  Created by apple on 02/07/20.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SwiftUI
import SwiftMessages

public typealias parameters = [String:Any]
let appName = "DoveCute"
var DEVICE_TOKEN = "ios"

var noInternetConnection = "No Internet Connection Available"

typealias successResponse = (()->())

var isBusiness = false

var fromTabBar = false

let iOSplatForm = "1"

//let baseURL  = "http://202.164.42.227:9999"

let baseURL = "http://202.164.42.227:9999/api/"

let imageURL = "http://202.164.42.227:9999/"

let imageBaseURL =  "http://202.164.42.227:9999/assets/images/"


//let imagePickerSources = ImagePickerClass()



let securitykey = "sk_Dac1t2GMfvvgO1+ZtLvOjwEhQluidxzVy9Av5fiV5kCZzCr+PjdB0ap0Qx6zCPkBDRS8gSGyFw=="

let publishedkey = "pk_ndhUQm9z9VVAEDQAKUjM5nQ6F690crObNnPPobC36LUWJcUKQQC/aSzj9kqTQ22rurF2B6DvyiI="

let deepLinkUrl = ""

var DayArray = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]

var genderArray = ["Male","Female"]

var datePicker = UIDatePicker()

var age = Int()

let PrimaryColor = #colorLiteral(red: 0.9918574691, green: 0.2109946012, blue: 0.4742730856, alpha: 1)

let CustomYellowColor = #colorLiteral(red: 0.7950755358, green: 0.6792131662, blue: 0.2435890436, alpha: 1)

let customGrayColor =  #colorLiteral(red:0.921, green: 0.922, blue: 0.921, alpha: 1)

var isFromPush = false

//MARK:- agora video call app id
let agoraAppId = ""
var agoraChannelName = ""
var agoraToken = ""

//MARK: - root vc
var rootVC: UIViewController?{
    get{
        return UIApplication.shared.windows.first?.rootViewController
    }
    set{
        UIApplication.shared.windows.first?.rootViewController = newValue
    }
}


//MARK: - StoryBoards

enum AppStoryboard : String {
    case Main      = "Main"
//    case Psychic  = "Psychic"

    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

enum API: String{
//user module
    case signup              = "signup"
    case login
    case forgot_password
    case privacypolicy       = "get_content/2"
    case termsAndCondition   = "get_content/1"
//    case helpandFaq          = "get_content/3"
    case file_upload  =  "file_upload"
    case delete_account
    case change_password
    case verify_otp
    case resend_otp
    case contactus
    case Notification_status
    case logout
    case faq
    case theme_list
    case category_list
    case cuisine_list
    case add_business
    case edit_profile
    case get_profile
    case get_content
    case location_list
    

//    MARK: - USER
    case user_home

//subject module
    case subjectList         = "subjet_listing"
    case chapterList         = "chapter_listing"
    case lessonListing       = "lesson_listing"
    case searchSubject       = "search_subject"
    case videoStatus         = "watchVideo"
//room module
    case usersList           = "users_listing"
    case users               = "users_listings"
    case search_user         = "search_user"
    case createRoom          = "createRoom"
    case roomListing         = "room_listing"
    case deleteParticipants  = "delete_participants"
    case addParticipants     = "AddParticipants"
    case leaveRoom           = "leaveGroup"
    case deleteRoom          = "delete_room"
//Quiz
    case quizList            = "quizList"
    case roomQuiz            = "room_qiuz_list"
    case createQuiz          = "roomQuiz"
    case quizDetails         = "room_qiuz_details"
    case submitQuiz          = "quiz_submit"
    case submitRoomQuiz      = "roomQuizSubmit"
    case quizResult          = "quiz_result"
    case deleteQuiz          = "delete_quiz"
    case rejectAcceptQuiz    = "quiz_accept_reject"
    case roomLeaderboad      = "leaderboard"
    case leaderboard         = "userQuizResult"
    case home                = "home"
    case fetch_restos_by_cusine = "fetch_restos_by_cusine"
    case theme_UserRestro    = "theme_UserRestro"
    case product_details = "fetch_resto_by_id"
    case liked_listing = "liked_listing"
    case restoLIke = "like_product"
    case fetch_restos_by_theme
    case fetch_restos_by_location
    case write_review
    case booking
    case fetch_data_by_menutype
    case fetch_available_slots
    case booking_history
   
}

//MARK: - User Default keys
enum DefaultKeys: String
{
    case Authorization
    case userId
    case loginvalue
    case email
    case remember
    case password
    case userDetails
    case autoLogin
    case deviceToken
    case rememberMe
    case security_key
    case auth_key
    case filter_data
    case user_type
    case first
    case profileImg
    case social_login
    case pushKitToken
    case isComing
    case roomId
    case lat
    case long
    case sociallogin
   
}


enum Services: String{
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}


enum dateFormat:String{
    case dayMonthYear = "dd/MM/yyyy"
    case BackEndFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case mon_dd_yyyy = "MMM dd, yyyy"
    case hh_mm_a_MM_dd_yy = "hh:mm a MM-dd-yy"
    case fullDate = "MM_dd_yy_HH:mm:ss.SS"
    case mon_dd_yyyy_hh_mm_a = "MMM dd, yyyy | hh:mm a"
}



//MARK:-  constant messages or Alert Messages

enum constantMessages:String{
    
    case internetError    = "Please check your internet connectivity"
    case accepted         = "Requested accepted sucessfully"
    case rejected         = "Requested rejected sucessfully"
    case emptyName        = "Please enter your name"
    case emptyFullName    = "Please enter your full name"
    case emptyLastName    = "Please enter your last name"
    case emptyCountryCode = "Please select country code"
    case emptyPhone       = "Please enter your phone number"
    case emptyEmail       = "Please enter your email"
    case emptyPassword    = "Please enter your password"
    case emptyOldPass     = "Please enter old password"
//    case emptyNewPassword = "Please enter your password"
    case emptyCPassword   = "Please enter confirm password"
    case passwordMismatch = "Password and confirm password didn't match"
    case emptyOtp         = "Please enter OTP"
    case emptyImage       = "Please upload images"
    case emptyGender      = "Please select your gender"
    case emptyLocation    = "Please enter your location"
    case emptyDob         = "Please enter your date of birth"
    case emptyBio         = "Please enter about yourself"
    case emptyAge         = "Please enter your age"
    case emptyHeight      = "Please enter your height"
    case emptymessage     = "Please write something"
    case emptyInterest    = "Please select your interests"
    case emptyHobbies     = "Please select your hobbies"
    case emptyImageOrVideo = "Please add an image or a video"
    case emptyTitle       = "Please add a title"
    case emptyDescription = "Please add description"
    
    case acceptTerms      = "Please accept Terms and Conditions"
    case invalidGroup     = "You need to add atleast two user to create room"
    case invalidPhone     = "Please enter valid phone number"
    case invalidEmail     = "Please enter valid email"
    case invalidCPassword = "Confirm password must be same"
    case invalidOtp       = "Please enter correct OTP"
    case invalidImage     = "You cannot select more than five images"
        
    case blockedUser      = "Please Unblock this user before sending message"
    case blockedByUser    = "You have been blocked by this user"
    case callRejected     = "Call rejected"
    case callEnded        = "Call ended"
    case callNoAnswer     = "No answer"
    
    var instance : String {
        return self.rawValue
    }
}

//MARK: SHOW SWIFTY MESSAGE
func showSwiftyAlert(_ Title :String,_ body: String ,_ isSuccess : Bool){
    DispatchQueue.main.async {
        let warning = MessageView.viewFromNib(layout: .cardView)
        if isSuccess == true{
            warning.configureTheme(.success)
        }else{
            warning.configureTheme(.error)
        }
        warning.configureDropShadow()
        warning.configureContent(title: Title, body: body)
        warning.button?.isHidden = true
        // warning.iconImageView?.image = #imageLiteral(resourceName: "imgNavLogo")
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        warningConfig.duration = .seconds(seconds: 1)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}
func goToLogin() {
   let login = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
   let navigationController = UINavigationController.init(rootViewController: login)
   navigationController.isNavigationBarHidden = true
   rootVC = navigationController
}
   func goToHome() {
        let tabVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
       let navigationController = UINavigationController.init(rootViewController: tabVC)
       navigationController.isNavigationBarHidden = true
       rootVC = navigationController
   }
