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
    var arrImg = ["notification","unlock","question","books","outline","phone","delete-user-1","logout-1"]
    var arrName = ["Notification","Change Password","Privacy Policy","Terms and Conditions","Help & FAQ's","Contact Us","Delete Account","Logout"]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")as!settingCell
        if indexPath.row == 0{
            cell.swichBtn.isHidden = false
            cell.arrowImg.isHidden = true
        }else if indexPath.row == 7 {
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
            let vc = storyboard?.instantiateViewController(withIdentifier: "TermsConditionVC")as! TermsConditionVC
            vc.status = 2
            vc.titleLbl = "Terms & Conditions"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TermsConditionVC")as! TermsConditionVC
            vc.status = 1
            vc.titleLbl = "Privacy policy"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.HelpQAVC) as! HelpQAVC
            self.navigationController?.pushViewController(screen, animated: true)
        }else if indexPath.row == 5{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsVC")as! ContactUsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6{
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
            
        }else if indexPath.row == 7{
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
