//
//  EditProfileModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 11/08/23.
//
import Foundation

// MARK: - EditProfileModel
struct EditProfileModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: EditProfileModelBody
}

// MARK: - Body
struct EditProfileModelBody: Codable {
    var id: Int
    var name, aboutMe, nickName, dob: String
    var gender: Int
    var email: String
    var type, role: Int
    var countryCode: String
    var phone: Int?
    var password, socialID: String
    var socialType, otp: Int
    var deviceToken: String
    var deviceType: Int
    var selfieImage: String
    var isSelfieStatus, isOtpVerified: Int
    var image, verifyImage: String
    var isImageVerified: Int
    var location, latitude, longitude: String
    var loginTime: Int
    var notes, interests: String
    var status, loginStep, isCompleted, notificationStatus: Int
    var createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case aboutMe = "about_me"
        case nickName = "nick_name"
        case dob, gender, email, type, role
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
        case image
        case verifyImage = "verify_image"
        case isImageVerified = "is_image_verified"
        case location, latitude, longitude
        case loginTime = "login_time"
        case notes, interests, status
        case loginStep = "login_step"
        case isCompleted = "is_completed"
        case notificationStatus = "notification_status"
        case createdAt, updatedAt
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.aboutMe = try container.decode(String.self, forKey: .aboutMe)
        self.nickName = try container.decode(String.self, forKey: .nickName)
        self.dob = try container.decode(String.self, forKey: .dob)
        self.gender = try container.decode(Int.self, forKey: .gender)
        self.email = try container.decode(String.self, forKey: .email)
        self.type = try container.decode(Int.self, forKey: .type)
        self.role = try container.decode(Int.self, forKey: .role)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        
        if let value = try? container.decode(Int.self, forKey: .phone) {
            self.phone = value
        }else if let value = try? container.decode(String.self, forKey: .phone) {
            self.phone = Int(value)
        }
        
        self.password = try container.decode(String.self, forKey: .password)
        self.socialID = try container.decode(String.self, forKey: .socialID)
        self.socialType = try container.decode(Int.self, forKey: .socialType)
        self.otp = try container.decode(Int.self, forKey: .otp)
        self.deviceToken = try container.decode(String.self, forKey: .deviceToken)
        self.deviceType = try container.decode(Int.self, forKey: .deviceType)
        self.selfieImage = try container.decode(String.self, forKey: .selfieImage)
        self.isSelfieStatus = try container.decode(Int.self, forKey: .isSelfieStatus)
        self.isOtpVerified = try container.decode(Int.self, forKey: .isOtpVerified)
        self.image = try container.decode(String.self, forKey: .image)
        self.verifyImage = try container.decode(String.self, forKey: .verifyImage)
        self.isImageVerified = try container.decode(Int.self, forKey: .isImageVerified)
        self.location = try container.decode(String.self, forKey: .location)
        self.latitude = try container.decode(String.self, forKey: .latitude)
        self.longitude = try container.decode(String.self, forKey: .longitude)
        self.loginTime = try container.decode(Int.self, forKey: .loginTime)
        self.notes = try container.decode(String.self, forKey: .notes)
        self.interests = try container.decode(String.self, forKey: .interests)
        self.status = try container.decode(Int.self, forKey: .status)
        self.loginStep = try container.decode(Int.self, forKey: .loginStep)
        self.isCompleted = try container.decode(Int.self, forKey: .isCompleted)
        self.notificationStatus = try container.decode(Int.self, forKey: .notificationStatus)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
}
