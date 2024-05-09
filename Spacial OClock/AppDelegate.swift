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
/*
 
 hardin@gmail.com
 pass: 12345678
 
 
 */
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var locationUpdated = Bool()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(3)
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyA-Ga7BvTYtT6KGYYoMWfolfoPj7CswuL0")
        GMSPlacesClient.provideAPIKey("AIzaSyCIVy1w4jCuYDgqDjfNGU-uqxgJb_OjM4g")
        SocketIOManager.sharedInstance.connectMySocket()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationUpdated = true
                    self.locationManager.delegate = self
                    self.locationManager.requestWhenInUseAuthorization()
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    self.locationManager.startUpdatingLocation()
                }
            } else {
                DispatchQueue.main.async {
                    self.locationUpdated = false
                }
            }
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
            let userInfos = userInfo["aps"] as?  [String:Any]
            let Staustype = userInfos?["type"] as? Int
            
            if Store.userDetails?.role == 1 {
                if let topVc = UIApplication.topViewController(), topVc.isKind(of: HomeVC.self) {
                    if Staustype == 0 {
                        completionHandler([])
                    } else {
                        completionHandler([.sound,.banner,.badge])
                    }
                    
                } else {
                    completionHandler([.sound,.banner,.badge])
                }
                if let topVc = UIApplication.topViewController(), topVc.isKind(of: ChatVC.self) {
                    completionHandler([])
                } else {
                    completionHandler([.sound,.banner,.badge])
                }
            }else{
                if let topVc = UIApplication.topViewController(), topVc.isKind(of: RestoHomeVC.self) {
                    if Staustype == 7 || Staustype != 0{
                        completionHandler([.sound,.banner,.badge])
                    }else {
                        topVc.viewWillAppear(true)
                        completionHandler([])
                    }
                    
                } else {
                    completionHandler([.sound,.banner,.badge])
                }
                if let topVc = UIApplication.topViewController(), topVc.isKind(of: ChatVC.self) {
                    completionHandler([])
                } else {
                    completionHandler([.sound,.banner,.badge])
                }
                
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let userInfo = response.notification.request.content.userInfo as? [String:Any] {
            print("**********************",userInfo)
            let storyboard = UIStoryboard.init(name: "RestoBar", bundle: Bundle.main)
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            if let notificationType = userInfo["type"] as? Int {
                
                if Store.userDetails?.role == 1{
                    
                    if notificationType == 0 {
                        let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                        tabVC.selectedIndex = 0
                        let navigationController = UINavigationController(rootViewController: tabVC)
                        navigationController.navigationBar.isHidden = true
                        navigationController.viewControllers = [tabVC]
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    } else if notificationType == 1 {
                        if let booking_id = userInfo["booking_primary_id"] as? Int {
                            let vc = mainStoryboard.instantiateViewController(withIdentifier: "bookingDetailVC") as! bookingDetailVC
                            let navigationController = UINavigationController(rootViewController: vc)
                            navigationController.navigationBar.isHidden = true
                            let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                            vc.booking_id = booking_id
                            vc.buttonTitle = "Cancel Booking"
                            vc.buttonColor = "themeRed"
                            vc.statusColor = "themeRed"
                            vc.statusVerify = 0
                            navigationController.viewControllers = [tabVC,vc]
                            UIApplication.shared.windows.first?.rootViewController = navigationController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }//booking_primary_id
                    } else if notificationType == 7 {
                        if let booking_id = userInfo["booking_id"] as? Int{
                            let vc = mainStoryboard.instantiateViewController(withIdentifier: ViewController.bookingDetailVC) as! bookingDetailVC
                            let navigationController = UINavigationController(rootViewController: vc)
                            navigationController.navigationBar.isHidden = true
                            let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                            navigationController.viewControllers = [tabVC,vc]
                            //vc.cancelid =
                            vc.booking_id = booking_id
                            vc.buttonTitle = "Cancel Booking"
                            vc.buttonColor = "themeRed"
                            vc.statusColor = "themeRed"
                            vc.statusVerify = 0
                            UIApplication.shared.windows.first?.rootViewController = navigationController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }
                    }else {
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                        let navigationController = UINavigationController(rootViewController: vc)
                        navigationController.navigationBar.isHidden = true
                        let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                        navigationController.viewControllers = [tabVC,vc]
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }
                } else {
                    if notificationType == 0{
                        let tabVC = storyboard.instantiateViewController(withIdentifier: "RestoTabBarVC") as! RestoTabBarVC
                        tabVC.selectedIndex = 0
                        let navigationController = UINavigationController(rootViewController: tabVC)
                        navigationController.navigationBar.isHidden = true
                        navigationController.viewControllers = [tabVC]
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    } else if notificationType == 7 {
                        if let restrorant_bar_id = userInfo["restrorant_bar_id"] as? String, let booking_id = userInfo["booking_id"] as? String{
                            let vc = storyboard.instantiateViewController(withIdentifier: ViewController.bookingDetailsVC) as! bookingDetailsVC
                            let navigationController = UINavigationController(rootViewController: vc)
                            navigationController.navigationBar.isHidden = true
                            let tabVC = storyboard.instantiateViewController(withIdentifier: "RestoTabBarVC") as! RestoTabBarVC
                            navigationController.viewControllers = [tabVC,vc]
                            vc.restoid = Int(restrorant_bar_id) ?? 0
                            vc.booking_id = booking_id
                            vc.isHidden = true
                            UIApplication.shared.windows.first?.rootViewController = navigationController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }
                    } else {
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                        let navigationController = UINavigationController(rootViewController: vc)
                        navigationController.navigationBar.isHidden = true
                        let tabVC = storyboard.instantiateViewController(withIdentifier: "RestoTabBarVC") as! RestoTabBarVC
                        navigationController.viewControllers = [tabVC,vc]
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }
                }
            }
        }
    }
}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
