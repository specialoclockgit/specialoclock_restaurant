//
//  RestoSettingVC.swift
//  Spacial OClock
//
//  Created by cql99 on 27/06/23.
//

//import UIKit
//import Foundation
//
//class RestoSettingVC: UIViewController {
//
//    //MARK: - OUTLETS
//
//    @IBOutlet weak var tableVW: UITableView!
//    //MARK: - VARIABLES
//    var nameary = ["Notifications", "Change Password", "Privacy Policy", "Terms and Conditions", "My Menu", "My Offers", "My Review", "My Invoices", "Manage Cards", "Help & FAQ’s", "Contact Us", "Delete Account", "Logout"]
//    var image = ["bell","unlock","question","books","menu","specialOffer","reviews", "invoice", "creditCard1","helpCircle", "phone","delete-user-1","logout-1"]
//    var viewmodel = AuthViewModel()
//    var isSelected = 0
//    
//    //MARK: - VIEW LIFECYCLE
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    
//    }
//   
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tabBarController?.tabBar.isHidden = false
//    }
//}
//
////MARK: - EXTENSIONS
//extension RestoSettingVC: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return nameary.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RestoSettingTVC", for: indexPath) as! RestoSettingTVC
//        cell.imgView.image = UIImage(named: image[indexPath.row])
//        cell.lblName.text = nameary[indexPath.row]
//        cell.notificationBtn.addTarget(self, action: #selector(notificationbtn), for: .touchUpInside)
//        cell.notificationBtn.tag = indexPath.row
//        if Store.userDetails?.body.notificationStatus == 1 {
//            cell.notificationBtn.isOn = true
//        } else {
//            cell.notificationBtn.isOn = false
//        }
//        //        if Store.userDetails?.body.notificationStatus == 0 {
//        //            isSelected = 0
//        //            cell.notificationBtn.onTintColor = .gray
//        //
//        //        }else {
//        //            isSelected = 1
//        ////            Store.userDetails?.body.notificationStatus = 1
//        //            cell.notificationBtn.onTintColor = UIColor.init(named: "orange")
//        //        }
//        if indexPath.row == 0{
//            cell.notificationBtn.isHidden = false
//            cell.imgViewArrow.isHighlighted = true
//        }else{
//            cell.notificationBtn.isHidden = true
//            cell.imgViewArrow.isHighlighted = false
//        }
//        cell.lblName.text = nameary[indexPath.row]
//        return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60.0
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        debugPrint(indexPath.row)
//        let status = UserDefaults.standard.status
//        switch indexPath.row{
//        case 0:
//            let notificationVC =  storyboard?.instantiateViewController(withIdentifier: ViewController.NotificationRestoVC) as! NotificationRestoVC
//            self.navigationController?.pushViewController(notificationVC, animated: true)
//        case 1:
//            let chnagePassScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.ChangePasswordRestoVC) as! ChangePasswordRestoVC
//            self.navigationController?.pushViewController(chnagePassScreen, animated: true)
//        case 2:
//            let privacyScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.PrivacyVC) as! PrivacyVC
//            privacyScreen.heading = "Privacy Policy"
//            self.navigationController?.pushViewController(privacyScreen, animated: true)
//            
//        case 3:
//            let termScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.PrivacyVC) as! PrivacyVC
//            termScreen.heading = "Terms and Conditions"
//            self.navigationController?.pushViewController(termScreen, animated: true)
//        case 4 :
//            if status == 0 {
//                let menuScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.MyMenuVC) as! MyMenuVC
//                self.navigationController?.pushViewController(menuScreen, animated: true)
//            }else if status == 1{
//                let barMenuScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.BarMenuVC) as! BarMenuVC
//                self.navigationController?.pushViewController(barMenuScreen, animated: true)
//            }
//        case 5:
//            if status == 0 {
//                let offerScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.MyOfferVC) as! MyOfferVC
//                self.navigationController?.pushViewController(offerScreen, animated: true)
//                debugPrint("My offer")
//            }else if status == 1{
//                let barOfferScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.BarOfferVC) as! BarOfferVC
//                self.navigationController?.pushViewController(barOfferScreen, animated: true)
//            }
//            
//        case 6:
//            let reviewScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.MyReviewVC) as! MyReviewVC
//            self.navigationController?.pushViewController(reviewScreen, animated: true)
//            debugPrint("My reviews")
//        case 7:
//            let invoiceScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.MyInvoiceVC) as! MyInvoiceVC
//            self.navigationController?.pushViewController(invoiceScreen, animated: true)
//            debugPrint("My invoice")
//        case 8:
//            let manageCScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.RestoCardListVC) as! RestoCardListVC
//            self.navigationController?.pushViewController(manageCScreen, animated: true)
//            debugPrint("Manage Card")
//        case 9:
//            let helpFAQScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.HelpFAQRestoVC) as! HelpFAQRestoVC
//            self.navigationController?.pushViewController(helpFAQScreen, animated: true)
//        case 10:
//            let contactUsScreen = storyboard?.instantiateViewController(withIdentifier: ViewController.ContactUsRestoVC) as! ContactUsRestoVC
//            self.navigationController?.pushViewController(contactUsScreen, animated: true)
//        case 11:
//            let deleteAcccount = storyboard?.instantiateViewController(withIdentifier: Alert.AlertBottomVC) as! AlertBottomVC
//            deleteAcccount.statuschange = 0
//            deleteAcccount.imgString = "delete-user"
//            deleteAcccount.messgae = AlertMessage.deleteAccountMessage
//            deleteAcccount.callBack = {
//                SceneDelegate().RestoLogin()
//            }
//            self.navigationController?.present(deleteAcccount, animated: true)
//        case 12:
//            let logOutScreen = storyboard?.instantiateViewController(withIdentifier: Alert.AlertBottomVC) as! AlertBottomVC
//            logOutScreen.statuschange = 1
//            logOutScreen.imgString = "logout"
//            logOutScreen.messgae = AlertMessage.logOutMessage
//            logOutScreen.callBack = {
//                SceneDelegate().RestoLogin()
//            }
//            self.navigationController?.present(logOutScreen, animated: true)
//        default :
//            debugPrint("")
//        }
//    }
//    @objc func notificationbtn(_ sender : UIButton){
//        viewmodel.NotificationStatus(notistatus: isSelected) {
//            
//            let val = Store.userDetails?.body.notificationStatus == 0 ? 1 : 0
//            sender.isSelected = !sender.isSelected
//            self.viewmodel.NotificationStatus(notistatus: val) {
//                Store.userDetails?.body.notificationStatus = val
//                self.tableVW.reloadData()
//            }
//        }
//                }
//            
//            //            if Store.userDetails?.body.notificationStatus == 0 {
//            //                Store.userDetails?.body.notificationStatus = 1
//            //            }
//            //            else {
//            //                Store.userDetails?.body.status = 0
//            //            }
//            //        }
//        }
// 
