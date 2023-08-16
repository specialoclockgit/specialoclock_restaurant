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
    
    //MARK: Variables
//    var heading = String()
//    var name = ""
//    var email = ""
//    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        viewProfile.layer.cornerRadius = viewProfile.frame.height / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        // Do any additional setup after loading the view.
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
        self.navigationController?.popViewController(animated: true)
    }
}
