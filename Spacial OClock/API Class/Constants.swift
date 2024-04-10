//
//  Constants.swift
//  
//
//  Created by apple on 21/03/24.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

public typealias parameters = [String:Any]
let appName = "Special O'Clock"
var DEVICE_TOKEN = "ios"

var noInternetConnection = "No Internet Connection Available"

let iOSplatForm = "1"

//let imageBaseUrl = "http://192.168.1.80:2020"
//let baseURL  = "http://202.164.42.227:9999"
//let localURL = "http://192.168.1.60:9999/api/"
//let clientURL = "https://app.specialoclock.com/api/"


//let baseURL = "http://192.168.1.80:9999/api/" /*-> sachin local*/
let baseURL = "https://app.specialoclock.com/api/"

let imageURL = "https://app.specialoclock.com/"

let imageBaseURL =  "https://app.specialoclock.com/assets/images/"
let menuImgURL = "https://app.specialoclock.com/uploads/"
let productImgURL = "https://app.specialoclock.com/assets/img/"


//let imagePickerSources = ImagePickerClass()

let securitykey = "sk_Dac1t2GMfvvgO1+ZtLvOjwEhQluidxzVy9Av5fiV5kCZzCr+PjdB0ap0Qx6zCPkBDRS8gSGyFw=="

let publishedkey = "pk_ndhUQm9z9VVAEDQAKUjM5nQ6F690crObNnPPobC36LUWJcUKQQC/aSzj9kqTQ22rurF2B6DvyiI="

var datePicker = UIDatePicker()

//MARK: - root vc
var rootVC: UIViewController?{
    get{
        return UIApplication.shared.windows.first?.rootViewController
    }set{
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
    case fetch_app_availability
    case location_listing
    

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
    case theme_UserRestro    = "theme_UserRestro"
    case product_details = "fetch_resto_by_id"
    case liked_listing = "liked_listing"
    case restoLIke = "like_product"
    case fetch_restos_by_theme
    case fetch_restos_by_cusine
    case fetch_restos_by_location
    case write_review
    case booking
    case fetch_data_by_menutype
    case time_slots
    case booking_history
    case restro_BookingDetail
    case cancel_booking
    case fetch_available_slots
    case fetch_menu_gallery
    case fetch_restos_by_category
    
    //RESTO
    case restro_home
    case fetch_notifications
    case menu_listing
    case my_menu_products
    case offer_listing
    case review_listing = "fetch_reviews"
    case fetch_invoices
    case card_listing
    case fetch_invoice_detail
    case payment_sheet
    case get_business_details
    case edit_business
    case complete_booking
    case report_booking
    case fetch_bardata_by_menutype
    case reply_review
}

//MARK: - User Default keys
enum DefaultKeys: String {
    case restoStatus
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
    case screenType
   
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

enum constantMessages:String {
    
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

func isToday(dateString: String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    if let date = dateFormatter.date(from: dateString) {
        return Calendar.current.isDateInToday(date)
    } else {
        return false // Invalid date format
    }
}

func checkDatesAreInSequence(array: [String]) -> Bool {
    let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      let dates = array.compactMap { dateFormatter.date(from: $0) }
      
      guard dates.count > 1 else {
          return false
      }
      
      for i in 0..<(dates.count - 1) {
          let calendar = Calendar.current
          if let nextDate = calendar.date(byAdding: .day, value: 1, to: dates[i]) {
              if nextDate != dates[i + 1] {
                  return false
              }
          } else {
              return false
          }
      }
      return true
}

func nextAvailableDate(selectedDate: String, closedDates: [String]) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    guard let selected = dateFormatter.date(from: selectedDate) else {
        return nil
    }
    
    // Sort the closed dates array
    let sortedClosedDates = closedDates.sorted { dateFormatter.date(from: $0)! < dateFormatter.date(from: $1)! }
    
    for (index, closedDate) in sortedClosedDates.enumerated() {
        if let date = dateFormatter.date(from: closedDate) {
            // Check if selected date is among closed dates
            if selected <= date {
                if index < sortedClosedDates.count - 1 {
                    // If there are more closed dates, return the next one
                    let nextDate = dateFormatter.date(from: sortedClosedDates[index + 1])!
                    let daysToAdd = Calendar.current.dateComponents([.day], from: date, to: nextDate).day!
                    if daysToAdd > 1 {
                        // If there are days between the current closed date and the next one, return the date in between
                        let nextAvailableDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                        dateFormatter.dateFormat = "dd/MM/yyyy"
                        return dateFormatter.string(from: nextAvailableDate)
                    }
                } else {
                    // If there are no more closed dates, return the next day after the last closed date
                    let nextAvailableDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                    dateFormatter.dateFormat = "dd/MM/yyyy" 
                    return dateFormatter.string(from: nextAvailableDate)
                }
            }
        }
    }
    
    // If no available date found, return nil
    return nil
}




func formatDate(inputDate: String) -> String? {
    let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      
      guard let date = dateFormatter.date(from: inputDate) else {
          return nil
      }
      
      dateFormatter.dateFormat = "MMMM"
      let formattedDate = dateFormatter.string(from: date)
      
      let dayFormatter = DateFormatter()
      dayFormatter.dateFormat = "dd"
      let day = dayFormatter.string(from: date)
      
      var ordinalSuffix = "th"
      let lastTwoDigits = Int(day)! % 100
      if lastTwoDigits >= 11 && lastTwoDigits <= 13 {
          ordinalSuffix = "th"
      } else {
          switch Int(day)! % 10 {
          case 1: ordinalSuffix = "st"
          case 2: ordinalSuffix = "nd"
          case 3: ordinalSuffix = "rd"
          default: break
          }
      }
      
      return "\(day)\(ordinalSuffix) \(formattedDate)"
}
