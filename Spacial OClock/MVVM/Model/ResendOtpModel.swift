//
//  ResendOtpModel.swift
//  Spacial OClock
//
//  Created by cqlpc on 11/08/23.
//
import Foundation

// MARK: - ResendotpModel
struct ResendotpModel: Codable {
    var success: Bool
    var code: Int
    var message: String
    var body: ResendotpModelBody
}

// MARK: - Body
struct ResendotpModelBody: Codable {
    var id: Int
    var name, aboutMe, nickName, dob: String
    var gender: Int
    var email: String
    var type, role: Int
    var countryCode: String
    var phone: Int
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
}
