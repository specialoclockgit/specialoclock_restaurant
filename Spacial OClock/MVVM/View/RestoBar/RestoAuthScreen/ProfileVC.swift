//
//  ProfileVC.swift
//  Spacial OClock
//
//  Created by cql211 on 12/07/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var btnViewProfile : UIButton!
    @IBOutlet weak var btnEditProfile : UIButton!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblPhoneNumber : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
  
    //MARK: Varibale
    var btnCheckStatus = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    //MARK: Button Actions
    @IBAction func btnRestaurantProfileAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.RestoProfileVC) as! RestoProfileVC
        let status = UserDefaults.standard.status
        if status == 0 {
            screen.heading = "Restaurant Profile"
        }else if status == 1{
            screen.heading = "Bar Profile"
        }
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    @IBAction func btnEditProfileAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.EditProfileVC) as! EditProfileVC
        screen.name = lblName.text ?? ""
        screen.email = lblEmail.text ?? ""
        screen.phoneNumber = lblPhoneNumber.text ?? ""
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension ProfileVC{
    func initialLoad(){
        btnCheckStatus = UserDefaults.standard.status
        debugPrint(btnCheckStatus)
        if btnCheckStatus == 0 {
            btnViewProfile.setTitle("Restaurant Profile", for: .normal)
        }else if btnCheckStatus == 1 {
            btnViewProfile.setTitle("Bar Profile", for: .normal)
        }
    }
}
