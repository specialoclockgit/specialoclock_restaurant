//
//  UserProfileVC.swift
//  Spacial OClock
//
//  Created by cql211 on 18/07/23.
//

import UIKit

class UserProfileVC: UIViewController {
    
    //MARK: Outlets
    //@IBOutlet weak var btnViewProfile : UIButton!
    @IBOutlet weak var btnEditProfile : UIButton!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblPhoneNumber : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
  
    //MARK: Varibale
    var btnCheckStatus = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Button Actions
    @IBAction func btnEditProfileAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.UserEditProfileVC) as! UserEditProfileVC
//        screen.name = lblName.text ?? ""
//        screen.email = lblEmail.text ?? ""
//        screen.phoneNumber = lblPhoneNumber.text ?? ""
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

