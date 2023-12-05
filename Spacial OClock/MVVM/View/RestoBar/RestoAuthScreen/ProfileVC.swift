//
//  ProfileVC.swift
//  Spacial OClock
//
//  Created by cql211 on 12/07/23.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var btnViewProfile : UIButton!
    @IBOutlet weak var btnEditProfile : UIButton!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblPhoneNumber : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
  
    //MARK: Varibale
    var btnCheckStatus = Int()
    var checkValue = String()
    var viewmodel =  AuthViewModel()
    var getdataget: GetprofileModelBody?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Store.userDetails?.bussinesstype == 1{
            setupAPi()
            btnViewProfile.setTitle("Restaurant Profile", for: .normal)
        }else{
            setupAPi()
            btnViewProfile.setTitle("Bar Profile", for: .normal)
        }
        initialLoad()
        
    }
    
     func setupAPi(){
        viewmodel.ProfileAPI { data in
            self.getdataget = data
            self.lblName.text = data?.name ?? ""
            self.lblEmail.text = data?.email ?? ""
            self.lblPhoneNumber.text =  data?.phone.description ?? ""
            self.profileImg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.profileImg.sd_setImage(with: URL(string: imageURL + (data?.image ?? "")),placeholderImage: UIImage(named: "placeholder 1"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    //MARK: Button Actions
    @IBAction func btnRestaurantProfileAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.RestoProfileVC) as! RestoProfileVC
        
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
//        if btnCheckStatus == 0 {
//            btnViewProfile.setTitle("Restaurant Profile", for: .normal)
//        }else if btnCheckStatus == 1 {
//            btnViewProfile.setTitle("Bar Profile", for: .normal)
//        }
    }
}
