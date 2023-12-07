//
//  RestoSettingVC.swift
//  Spacial OClock
//
//  Created by cql99 on 27/06/23.
//

import UIKit
import Foundation

class RestoSettingVC: UIViewController {

    //MARK: - OUTLETS

    @IBOutlet weak var tableVW: UITableView!
    //MARK: - VARIABLES
    var nameary = ["Notifications","Chat","Change Password", "Privacy Policy", "Terms and Conditions", "My Menu", "My Offers", "My Review", "My Invoices", "Help & FAQ’s", "Contact Us", "Delete Account", "Logout"]
    var image = ["bell","unlock","unlock","question","books","menu","specialOffer","reviews", "invoice","helpCircle", "phone","delete-user-1","logout-1"]
    var viewmodel = AuthViewModel()
    var isSelected = 0
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

//MARK: - EXTENSIONS
extension RestoSettingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameary.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestoSettingTVC", for: indexPath) as! RestoSettingTVC
        cell.imgView.image = UIImage(named: image[indexPath.row])
        cell.lblName.text = nameary[indexPath.row]
        cell.notificationBtn.addTarget(self, action: #selector(notificationbtn), for: .touchUpInside)
        cell.notificationBtn.tag = indexPath.row
        if Store.userDetails?.notificationStatus == 1 {
            cell.notificationBtn.isOn = true
        } else {
            cell.notificationBtn.isOn = false
        }
        //        if Store.userDetails?.body.notificationStatus == 0 {
        //            isSelected = 0
        //            cell.notificationBtn.onTintColor = .gray
        //
        //        }else {
        //            isSelected = 1
        ////            Store.userDetails?.body.notificationStatus = 1
        //            cell.notificationBtn.onTintColor = UIColor.init(named: "orange")
        //        }
        if indexPath.row == 0{
            cell.notificationBtn.isHidden = false
            cell.imgViewArrow.isHighlighted = true
        }else{
            cell.notificationBtn.isHidden = true
            cell.imgViewArrow.isHighlighted = false
        }
        cell.lblName.text = nameary[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        let status = UserDefaults.standard.status
        switch indexPath.row{
        case 0:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let notificationVC =  StoryBoard.instantiateViewController(withIdentifier: ViewController.NotificationRestoVC) as! NotificationRestoVC
            self.navigationController?.pushViewController(notificationVC, animated: true)
        case 1:
            let StoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let notificationVC =  StoryBoard.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
            self.navigationController?.pushViewController(notificationVC, animated: true)
        case 2:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let chnagePassScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.ChangePasswordRestoVC) as! ChangePasswordRestoVC
            self.navigationController?.pushViewController(chnagePassScreen, animated: true)
        case 3:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let privacyScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.PrivacyVC) as! PrivacyVC
            privacyScreen.heading = "Privacy Policy"
            self.navigationController?.pushViewController(privacyScreen, animated: true)
            
        case 4:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let termScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.PrivacyVC) as! PrivacyVC
            termScreen.heading = "Terms and Conditions"
            self.navigationController?.pushViewController(termScreen, animated: true)
        case 5 :
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            if status == 0 {
                let menuScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.MyMenuVC) as! MyMenuVC
                self.navigationController?.pushViewController(menuScreen, animated: true)
            }else if status == 1{
                let barMenuScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.MyMenuVC) as! MyMenuVC
                self.navigationController?.pushViewController(barMenuScreen, animated: true)
            }
        case 6:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            if status == 0 {
                let offerScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.MyOfferVC) as! MyOfferVC
                self.navigationController?.pushViewController(offerScreen, animated: true)
                debugPrint("My offer")
            }else if status == 1{
                let barOfferScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.MyOfferVC) as! MyOfferVC
                self.navigationController?.pushViewController(barOfferScreen, animated: true)
            }
            
        case 7:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let reviewScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.MyReviewVC) as! MyReviewVC
            self.navigationController?.pushViewController(reviewScreen, animated: true)
            debugPrint("My reviews")
        case 8:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let invoiceScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.MyInvoiceVC) as! MyInvoiceVC
            self.navigationController?.pushViewController(invoiceScreen, animated: true)
            debugPrint("My invoice")
//        case 9:
//            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
//            let manageCScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.RestoCardListVC) as! RestoCardListVC
//            self.navigationController?.pushViewController(manageCScreen, animated: true)
//            debugPrint("Manage Card")
        case 9:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let helpFAQScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.HelpFAQRestoVC) as! HelpFAQRestoVC
            self.navigationController?.pushViewController(helpFAQScreen, animated: true)
        case 10:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let contactUsScreen = StoryBoard.instantiateViewController(withIdentifier: ViewController.ContactUsRestoVC) as! ContactUsRestoVC
            self.navigationController?.pushViewController(contactUsScreen, animated: true)
        case 11:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let deleteAcccount = StoryBoard.instantiateViewController(withIdentifier: Alert.AlertBottomVC) as! AlertBottomVC
            deleteAcccount.statuschange = 0
            deleteAcccount.imgString = "delete-user"
            deleteAcccount.messgae = AlertMessage.deleteAccountMessage
            deleteAcccount.callBack = {
                SceneDelegate().setLoginRoot()
            }
            self.navigationController?.present(deleteAcccount, animated: true)
        case 12:
            let StoryBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let logOutScreen = StoryBoard.instantiateViewController(withIdentifier: Alert.AlertBottomVC) as! AlertBottomVC
            logOutScreen.statuschange = 4
            logOutScreen.imgString = "logout"
            logOutScreen.messgae = AlertMessage.logOutMessage
            logOutScreen.callBack = {
                SceneDelegate().setLoginRoot()
            }
            self.navigationController?.present(logOutScreen, animated: true)
        default :
            debugPrint("")
        }
    }
    @objc func notificationbtn(_ sender : UIButton){
        let cell = tableVW.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! RestoSettingTVC
        if cell.notificationBtn.isOn {
            setNotification()
        }else {
            setNotification()
        }
    }
    func setNotification() {
        let val = Store.userDetails?.notificationStatus == 0 ? 1 : 0
            self.viewmodel.NotificationStatus(notistatus: val) {
                Store.userDetails?.notificationStatus = val
                CommonUtilities.shared.showAlert(message: "Notification status update successfully", isSuccess: .success)
                self.tableVW.reloadData()
        }
    }
}
 
