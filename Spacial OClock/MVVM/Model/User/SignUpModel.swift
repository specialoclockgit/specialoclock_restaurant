//
//  SignUpModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 07/08/23.
//

//MARK: Social Login Model
struct SocialLoginModel {
    var userImage: String?
    var userFullName: String?
    var email: String?
    var userId: String?
    
    init(userImage: String? = nil, userFullName: String? = nil, email: String? = nil, userId: String) {
        self.userImage = userImage
        self.userFullName = userFullName
        self.email = email
        self.userId = userId
    }
}


// MARK: - SignupModel
struct SignupModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: SignupBody?
}

// MARK: - SignupBody
struct SignupBody: Codable {
    var id: Int?
    var name, aboutMe, nickName, dob: String?
    var gender,restoid: Int?
    var email: String?
    var type, role: Int?
    var countryCode: String?
    var phone: Int?
    var password, socialID: String?
    var socialType, otp: Int?
    var deviceToken: String?
    var deviceType: Int?
    var selfieImage: String?
    var isSelfieStatus, isOtpVerified: Int?
    var image, verifyImage: String?
    var isImageVerified, isCardAdded: Int?
    var location, latitude, longitude: String?
    var loginTime, bussinesstype: Int?
    var notes, interests: String?
    var status, loginStep, isCompleted, notificationStatus, is_approved, bussiness_id: Int?
    var createdAt, updatedAt, token: String?

    enum CodingKeys: String, CodingKey {
        case id, name, is_approved, isCardAdded
        case bussinesstype = "bussiness_type"
        case aboutMe = "about_me"
        case nickName = "nick_name"
        case dob, gender, email, type, role, restoid
        case countryCode = "country_code"
        case phone, password
        case socialID = "social_id"
        case socialType = "social_type"
        case otp
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case selfieImage = "selfie_image"
        case isSelfieStatus = "is_selfie_status"
        case isOtpVerified = "is_otp_verified"
        case image, bussiness_id
        case verifyImage = "verify_image"
        case isImageVerified = "is_image_verified"
        case location, latitude, longitude
        case loginTime = "login_time"
        case notes, interests, status
        case loginStep = "login_step"
        case isCompleted = "is_completed"
        case notificationStatus = "notification_status"
        case createdAt, updatedAt, token
    }
}
