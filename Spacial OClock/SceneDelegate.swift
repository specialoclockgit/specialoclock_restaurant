//
//  SceneDelegate.swift
//  Spacial OClock
//
//  Created by cql99 on 19/06/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        auttooLogin()
        guard let _ = (scene as? UIWindowScene) else { return }
        if let userActivity = connectionOptions.userActivities.first,
           userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let urlinfo = userActivity.webpageURL {
            print ("Universial Link Open at SceneDelegate on App Start ::::::: \(urlinfo)")
        }
        
        // MARK: Deeplink Open
        if connectionOptions.urlContexts.first?.url != nil {
            if let urlinfo = connectionOptions.urlContexts.first?.url {
                if let scheme = urlinfo.scheme,
                   scheme.localizedCaseInsensitiveContains("com.live.specialOClockUser") == true {
                    let arrayString = "\(urlinfo)"
                    if let index = arrayString.range(of: "restaurantId=")?.upperBound{
                        let restaurantId = String(arrayString[index...])
                        print("restaurantId--=====\(restaurantId)")
                        if Store.authKey != nil && Store.authKey != "" && Store.autoLogin == true{
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let nav = storyBoard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                            let tab = storyBoard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                            tab.selectedIndex = 0
                            let eventDetailVC = storyBoard.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                            eventDetailVC.hidesBottomBarWhenPushed = true
                            eventDetailVC.ProductID = Int(restaurantId) ?? 0
                            nav.viewControllers = [tab,eventDetailVC]
                            window?.rootViewController = nav
                        }
                    }
                }
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}


extension SceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
       
        if  let url = URLContexts.first?.url {
            if let scheme = url.scheme,
               scheme.localizedCaseInsensitiveContains("com.live.specialOClockUser") == true {
                let arrayString = "\(url)"
                if let index = arrayString.range(of: "restaurantId=")?.upperBound{
                    let restaurantId = String(arrayString[index...])
                    print("restaurantId--=====\(restaurantId)")
                    if Store.authKey != nil && Store.authKey != "" && Store.autoLogin == true{
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let nav = storyBoard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                        let tab = storyBoard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                        tab.selectedIndex = 0
                        let eventDetailVC = storyBoard.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                        eventDetailVC.hidesBottomBarWhenPushed = true
                        eventDetailVC.ProductID = Int(restaurantId) ?? 0
                        nav.viewControllers = [tab,eventDetailVC]
                        window?.rootViewController = nav
                    }
                }
            }
        }
    }
}


extension SceneDelegate {
    func auttooLogin(){
        if Store.userDetails?.role == 1 {
            if Store.autoLogin == true {
                let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = homeStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                let nav = UINavigationController.init(rootViewController: vc)
                nav.isNavigationBarHidden = true
                UIApplication.shared.windows.first?.rootViewController = nav
            }
//            else{
//                let storyb = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//                let nav = UINavigationController.init(rootViewController: vc)
//                nav.isNavigationBarHidden = true
//                UIApplication.shared.windows.first?.rootViewController = nav
//            }
        }else{
            if Store.autoLogin == true {
                let homeStoryboard = UIStoryboard.init(name: "RestoBar", bundle: nil)
                let vc = homeStoryboard.instantiateViewController(withIdentifier: "RestoTabBarVC") as! RestoTabBarVC
                let nav = UINavigationController.init(rootViewController: vc)
                nav.isNavigationBarHidden = true
                UIApplication.shared.windows.first?.rootViewController = nav
            }
            //else{
//                let storyb = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//                let nav = UINavigationController.init(rootViewController: vc)
//                nav.isNavigationBarHidden = true
//                UIApplication.shared.windows.first?.rootViewController = nav
          //  }
        }
    }
    
    func setLoginRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SelectVC") as! SelectVC
        let nav = UINavigationController.init(rootViewController: loginViewController)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
    }

    
    func setWalktroughRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = mainStoryBoard.instantiateViewController(withIdentifier: "WalkThroughVC") as! WalkThroughVC
        let nav = UINavigationController.init(rootViewController: initialViewController)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
    }

    func HomeRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        let nav = UINavigationController.init(rootViewController: redViewController)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
    }

    func LoginRoot(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SelectVC") as! SelectVC
        let nav = UINavigationController.init(rootViewController: redViewController)
        Store.autoLogin = false
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
    }

//    //MARK: Resto View Controller
//    func RestoHome(){
//        let mainStoryBoard = UIStoryboard(name: "RestoBar", bundle: nil)
//        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: ViewController.RestoWalkThroughVC) as! RestoWalkThroughVC
//        let nav = UINavigationController.init(rootViewController: redViewController)
//        nav.isNavigationBarHidden = true
//        UIApplication.shared.windows.first?.rootViewController = nav
//    }
//    func RestoLogin(){
//        let mainStoryBoard = UIStoryboard(name: "RestoBar", bundle: nil)
//        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: ViewController.RestoLoginVC) as! RestoLoginVC
//        let nav = UINavigationController.init(rootViewController: redViewController)
//        nav.isNavigationBarHidden = true
//        UIApplication.shared.windows.first?.rootViewController = nav
//    }
}


