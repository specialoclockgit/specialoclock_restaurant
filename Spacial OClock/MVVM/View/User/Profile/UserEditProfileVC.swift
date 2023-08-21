//
//  UserEditProfileVC.swift
//  Spacial OClock
//
//  Created by cql211 on 18/07/23.
//

import UIKit

class UserEditProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var imgProfile : UIImageView!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfPhoneNumber : UITextField!
    @IBOutlet weak var tfEmail : UITextField!
    @IBOutlet weak var viewProfile : UIView!
    
    var viewmodel = AuthViewModel()
    var profileBody : GetProfileBody?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        viewProfile.layer.cornerRadius = viewProfile.frame.height / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    private func setData() {
        self.viewmodel.ProfileAPI { data in
            self.profileBody = data.body
            self.imgProfile.showIndicator(baseUrl: imageURL, imageUrl: data.body?.image ?? "")
            self.tfName.text = data.body?.name ?? ""
            self.tfEmail.text = data.body?.email ?? ""
            self.tfPhoneNumber.text = "\(data.body?.countryCode ?? "")\(data.body?.phone ?? 0)"
        }
    }
    //MARK: Button Action
    @IBAction func btnProfileAct(_ sender : UIButton){
        ImagePicker().pickImage(self) { (image) in
            self.imgProfile.image = image
        }
    }
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveAct(_ sender : UIButton){
        viewmodel.editprofile(name: tfName.text ?? "", phone: tfPhoneNumber.text ?? "", email: tfEmail.text ?? "", image: imgProfile.image ?? UIImage()) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
