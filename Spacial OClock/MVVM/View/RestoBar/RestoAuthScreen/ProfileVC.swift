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
       // self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        if Store.userDetails?.bussinesstype == 1{
            btnViewProfile.setTitle("Restaurant Profile", for: .normal)
        } else {
            btnViewProfile.setTitle("Bar/Club Profile", for: .normal)
        }
        
        initialLoad()
        
    }
    
     func setupAPi(){
        viewmodel.ProfileAPI { data in
            self.getdataget = data
            self.lblName.text = data?.name.capitalized ?? ""
            self.lblEmail.text = data?.email ?? ""
            self.lblPhoneNumber.text =  data?.phone.description ?? ""
            self.profileImg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.profileImg.sd_setImage(with: URL(string: imageURL + (data?.image.replacingOccurrences(of: " ", with: "%20") ?? "")),placeholderImage: UIImage(named: "placeholder 1"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        setupAPi()
    }
    //MARK: Button Actions
    @IBAction func btnRestaurantProfileAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.RestoProfileVC) as! RestoProfileVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    @IBAction func btnEditProfileAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.EditProfileVC) as! EditProfileVC
        screen.getdataApi = self.getdataget
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension ProfileVC{
    func initialLoad(){
        btnCheckStatus = UserDefaults.standard.status
        debugPrint(btnCheckStatus)
        if Store.userDetails?.bussinesstype == 1 {
            btnViewProfile.setTitle("Restaurant Profile", for: .normal)
        } else if Store.userDetails?.bussinesstype == 2 {
            btnViewProfile.setTitle("Bar/Club Profile", for: .normal)
        }
    }
}
