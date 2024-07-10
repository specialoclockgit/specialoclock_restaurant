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
    var getdataApi : GetprofileModelBody?
    var viewmodel = AuthViewModel()
    var imageData = [FileuploadModelBody]()
    var isImage = false
    var callBack : (()->())?
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        initialLoad()
    }

    
    //MARK: Button Action
    @IBAction func btnBackAct(sender : UIButton) {
        self.callBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCameraAct(_ sender: UIButton) {
        ImagePicker().pickImage(self) { (image) in
            self.imgProfile.image = image
            self.viewmodel.fileUploadedAPI(type: "image", image: image) { [weak self] imageData in
                self?.imageData = imageData ?? [FileuploadModelBody]()
                self?.isImage = true
            }
        }
    }
    
   
    @IBAction func btnSaveAct(_ sender : UIButton) {
        viewmodel.editprofile(isImage:self.isImage, name: tfName.text ?? "", phone: tfPhoneNumber.text ?? "",countrySymbol: getdataApi?.countryCode ?? "",countryCode: getdataApi?.countryCode ?? "", email: tfEmail.text ?? "", image: self.imageData) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension EditProfileVC{
    func initialLoad(){
        tfName.text = getdataApi?.name.capitalized ?? ""
        tfEmail.text = getdataApi?.email ?? ""
        tfEmail.isUserInteractionEnabled = false
        tfPhoneNumber.text = getdataApi?.phone.description ?? ""
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        viewProfile.layer.cornerRadius = viewProfile.frame.height / 2
        self.imgProfile.showIndicator(baseUrl: imageURL, imageUrl: getdataApi?.image.replacingOccurrences(of: " ", with: "%20") ?? "")
        view.hideKeyboardWhenTappedAround()
    }
}
