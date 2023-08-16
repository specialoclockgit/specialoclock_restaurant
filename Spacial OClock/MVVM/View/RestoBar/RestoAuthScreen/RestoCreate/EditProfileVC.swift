//
//  EditProfileVC.swift
//  Spacial OClock
//
//  Created by cql211 on 12/07/23.
//

import UIKit

class EditProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var imgProfile : UIImageView!
    @IBOutlet weak var viewProfile : UIView!
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfPhoneNumber : UITextField!
    @IBOutlet weak var tfEmail : UITextField!
    
    //MARK: Variables
    var heading = String()
    var name = ""
    var email = ""
    var phoneNumber = ""
    var viewmodel = AuthViewModel()
    var getdataApi : EditProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        initialLoad()
        // Do any additional setup after loading the view.
    }
//    func setupApi(){ data in
//        self.getdataApi = Data
//        self.tfName.text = Data
//    }
    
    
    //MARK: Button Action
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCameraAct(_ sender: UIButton){
        ImagePicker().pickImage(self) { (image) in
            self.imgProfile.image = image
        }
    }
    @IBAction func btnSaveAct(_ sender : UIButton){
        viewmodel.editprofile(name: tfName.text ?? "", phone: tfPhoneNumber.text ?? "", email: tfEmail.text ?? "", image: imgProfile) {
            self.navigationController?.popViewController(animated: true)
        }
       
    }
}
extension EditProfileVC{
    func initialLoad(){
        tfName.text = name
        tfEmail.text = email
        tfPhoneNumber.text = phoneNumber
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        viewProfile.layer.cornerRadius = viewProfile.frame.height / 2
        view.hideKeyboardWhenTappedAround()
    }
}
