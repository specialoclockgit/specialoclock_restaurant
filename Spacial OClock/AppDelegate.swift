//
//  AppDelegate.swift
//  Spacial OClock
//
//  Created by cql99 on 19/06/23.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces
import GoogleMaps
@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    var locationUpdated = Bool()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(3)
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyA-Ga7BvTYtT6KGYYoMWfolfoPj7CswuL0")
        GMSPlacesClient.provideAPIKey("AIzaSyDG3ftTHL_IMGAd8c8vU-q0Oi-oURgTeKE")
        SocketIOManager.sharedInstance.connectMySocket()
        SocketIOManager.sharedInstance.connect_user()
        SocketIOManager.sharedInstance.connect_user_listen()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationUpdated = true
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }else{
            locationUpdated = false
        }
    registerForPushNotifications()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    
    class var sharedDelegate:AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    //MARK:- register for push notifications
    
    func registerForPushNotifications() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UIApplication.shared.cancelAllLocalNotifications()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func badge(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        let badgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        UIApplication.shared.applicationIconBadgeNumber = badgeNumber
    }
    
    //MARK:- Notification work and device token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
        DEVICE_TOKEN  = token
        UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
        Store.deviceToken = "simulator/error"
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if let userInfo = notification.request.content.userInfo as? [String:Any] {
            print("**********************")
            print(userInfo)
//            let apnsData = userInfo["data"] as? [String:Any]
            
//            if let notificationType = apnsData?["noti_type"] as? String {
//                if Store.isCompanion == "2" {
//                    let homeStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
//                    if let tabBarController  = rootController1 as? UINavigationController  ,  let visibleViewController = tabBarController.visibleViewController {
//                        if notificationType == "message" {
//                            if visibleViewController != visibleViewController as? ChatVC {
//                                completionHandler([.alert, .sound])
//
//                            } else {
//                                completionHandler([])
//                            }
//                        }else {
//
//                        }
//                    }
//                }
//            }
        }
        let badgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = badgeNumber
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let userInfo = response.notification.request.content.userInfo as? [String:Any] {
            print("**********************")
            print(userInfo)
//            let apnsData = userInfo["data"] as? [String:Any]
//            let receiverId = apnsData?["receiver_id"] as? String
//            let senderId = apnsData?["sender_id"] as? String
//            let senderName = apnsData?["sender_name"] as? String
//            let receiverName = apnsData?["receiver_name"] as? String
//            let senderImage = apnsData?["sender_image"] as? String
//            let receiverImage = apnsData?["receiver_image"] as? String
//            let roomId = apnsData?["room_id"] as? String
            
//            if let notificationType = apnsData?["noti_type"] as? String {
//                if Store.isCompanion == "2" {
//                    let homeStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
//                    if let tabBarController  = rootController1 as? UINavigationController  ,  let visibleViewController = tabBarController.visibleViewController {
//                        if notificationType == "accept_event_request" {
//                            let vc = homeStoryBoard.instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC
//                            visibleViewController.navigationController?.pushViewController(vc, animated: true)
//                        }else if notificationType == "message" {
//                            let vc = homeStoryBoard.instantiateViewController(identifier: "ChatVC") as! ChatVC
//                            vc.roomId = roomId ?? ""
//                            if senderId == Store.userDetails?.id {
//                                vc.name = receiverName ?? ""
//                                vc.receiverID = receiverId ?? ""
//                                vc.image = receiverImage ?? ""
//                            }else {
//                                vc.name = senderName ?? ""
//                                vc.receiverID = senderId ?? ""
//                                vc.image = senderImage ?? ""
//                            }
//                            visibleViewController.navigationController?.pushViewController(vc, animated: true)
//                        }else {
//                            let vc = homeStoryBoard.instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC
//                            visibleViewController.navigationController?.pushViewController(vc, animated: true)
//                        }
//                    }
//                }else {
//                    let homeStoryBoard = UIStoryboard.init(name: "BusinessTabBar", bundle: nil)
//                    if let tabBarController  = rootController1 as? UINavigationController  ,  let visibleViewController = tabBarController.visibleViewController {
//                        if notificationType == "accept_event_request" {
//                            let vc = homeStoryBoard.instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC
//                            visibleViewController.navigationController?.pushViewController(vc, animated: true)
//                        }else {
//                            let vc = homeStoryBoard.instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC
//                            visibleViewController.navigationController?.pushViewController(vc, animated: true)
//                        }
//                    }
//                }
//            }
        }
        completionHandler()
    }
}
