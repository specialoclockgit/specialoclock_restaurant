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
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var btnEditProfile : UIButton!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblPhoneNumber : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
  
    //MARK: Varibale
    var btnCheckStatus = Int()
    var viewModel = AuthViewModel()
    var profileBody : GetprofileModelBody?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setData()
    }
    
    
    func setData() {
        self.viewModel.ProfileAPI { data in
            self.profileBody = data
            self.lblName.text = data?.name ?? ""
            self.lblEmail.text = data?.email ?? ""
            self.lblPhoneNumber.text = "\(data?.countryCode ?? "") \(data?.phone ?? 0)"
            self.profileImg.showIndicator(baseUrl: imageURL, imageUrl: data?.image ?? "")
        }
    }
    
    //MARK: Button Actions
    @IBAction func btnEditProfileAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.UserEditProfileVC) as! UserEditProfileVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

