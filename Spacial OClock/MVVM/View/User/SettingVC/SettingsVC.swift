//
//  SettingsVC.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit

class SettingsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var settingTV: UITableView!
    
    //MARK: - Variables
    var arrImg = ["notification","unlock","Group 7127","question","books","outline","phone","delete-user-1","logout-1"]
    var arrName = ["Notification","Change Password","Chat with Admin","Privacy Policy","Terms and Conditions","Help & FAQ's","Contact Us","Delete Account","Logout"]
    var viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

//MARK: - UITableViewDelegateUITableViewDataSource
extension SettingsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! settingCell
        cell.swichBtn.addTarget(self, action: #selector(notificationbtn), for: .valueChanged)
        cell.swichBtn.tag = indexPath.row
        if Store.userDetails?.notificationStatus == 1 {
            cell.swichBtn.isOn = true
        } else {
            cell.swichBtn.isOn = false
        }
        if indexPath.row == 0{
            cell.swichBtn.isHidden = false
            cell.arrowImg.isHidden = true
        }else if indexPath.row == 8 {
            cell.swichBtn.isHidden = true
            cell.arrowImg.isHidden = true
        }else{
            cell.swichBtn.isHidden = true
            cell.arrowImg.isHidden = false
        }
        cell.itemNamelbl.text = arrName[indexPath.row]
        cell.itemImg.image = UIImage(named: arrImg[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.NotificationVC) as! NotificationVC
            self.navigationController?.pushViewController(screen, animated: true)
        }else if indexPath.row == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC")as! ChangePasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TermsConditionVC")as! TermsConditionVC
            vc.status = 1
            vc.titleLbl = "Privacy policy"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TermsConditionVC")as! TermsConditionVC
            vc.status = 0
            vc.titleLbl = "Terms & Conditions"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 5 {
            let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: ViewController.HelpFAQRestoVC) as! HelpFAQRestoVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6 {
            let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ContactUsRestoVC") as! ContactUsRestoVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 7 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DeleteAccountPopUp")as! DeleteAccountPopUp
            vc.modalPresentationStyle = .overFullScreen
            vc.status = 0
            vc.callBack = {
                self.viewModel.deleteAccountApi(onsuccess: { [weak self] in
                    SceneDelegate().LoginRoot()
//                    self?.dismiss(animated: true, completion: nil)
//                    let stry = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = stry.instantiateViewController(identifier: "LoginVC") as! LoginVC
//                    let nav1 = UINavigationController()
//                    nav1.navigationBar.isHidden = true
//                    nav1.viewControllers = [vc]
//                    self?.view.window?.rootViewController = nav1
                })
            }
            self.navigationController?.present(vc, animated: true)
            
        }else if indexPath.row == 8{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DeleteAccountPopUp")as! DeleteAccountPopUp
            vc.modalPresentationStyle = .overFullScreen
            vc.status = 1
            vc.callBack = {
                self.viewModel.logoutapicall { [weak self] in
                    SceneDelegate().LoginRoot()
                }
            }
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    @objc func notificationbtn(_ sender : UISwitch){
        let cell = settingTV.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! settingCell
        if cell.swichBtn.isOn {
            setNotification()
        }else {
            setNotification()
        }
        
    }
    
    func setNotification() {
        let val = Store.userDetails?.notificationStatus == 0 ? 1 : 0
            self.viewModel.NotificationStatus(notistatus: val) {
                Store.userDetails?.notificationStatus = val
                CommonUtilities.shared.showAlert(message: "Notification status update successfully", isSuccess: .success)
                self.settingTV.reloadData()
        }
    }
}

//MARK: - UITableViewCell
class settingCell: UITableViewCell{
    @IBOutlet weak var itemNamelbl: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var swichBtn: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        swichBtn.transform = CGAffineTransform(scaleX: 1.0 , y: 0.9)
    }
}
