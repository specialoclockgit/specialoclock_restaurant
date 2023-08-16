//
//  EditRestoProfileVC.swift
//  Spacial OClock
//
//  Created by cql211 on 12/07/23.
//

import UIKit

class EditRestoProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfTheme : UITextField!
    @IBOutlet weak var tfCategory : UITextField!
    @IBOutlet weak var tfCusinies : UITextField!
    @IBOutlet weak var tvDescription : UITextView!
    @IBOutlet weak var viewCuisines : UIView!
    @IBOutlet weak var viewOffer : UIView!
    @IBOutlet weak var viewCategory : UIView!
    
    @IBOutlet weak var imgMain : UIImageView!
    @IBOutlet weak var imgOptionOne : UIImageView!
    @IBOutlet weak var imgOptionTwo : UIImageView!
    @IBOutlet weak var imgOptionThree : UIImageView!
    
    //MARK: Variables
    var heading = String()
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCameraAct(_ sender : UIButton){
        if sender.tag == 0 {
            ImagePicker().pickImage(self) { (image) in
                self.imgMain.image = image
            }
        }else if sender.tag == 1{
            ImagePicker().pickImage(self) { (image) in
                self.imgOptionOne.image = image
            }
        }else if sender.tag == 2{
            ImagePicker().pickImage(self) { (image) in
                self.imgOptionTwo.image = image
            }
        }else if sender.tag == 3{
            ImagePicker().pickImage(self) { (image) in
                self.imgOptionThree.image = image
            }
        }
    }
    
    @IBAction func btnSaveAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension EditRestoProfileVC{
    func initialLoad(){
        view.hideKeyboardWhenTappedAround()
        lblHeading.text = heading
        tvDescription.layer.cornerRadius = 10.0
        tfCategory.inputView = pickerView
        tfTheme.inputView = pickerView
        tfCusinies.inputView = pickerView
        imgMain.layer.cornerRadius = 10.0
        imgOptionOne.layer.cornerRadius = 10.0
        imgOptionTwo.layer.cornerRadius = 10.0
        imgOptionThree.layer.cornerRadius = 10.0
        let status = UserDefaults.standard.status
        if status == 0{
            lblName.text = "Restaurant Name"
            tfName.placeholder = "Enter Name"
            viewCategory.isHidden = true
        }else if status == 1{
            lblName.text = "Bar Name"
            tfName.placeholder = "Bar Name"
            viewCuisines.isHidden = true
            viewOffer.isHidden = true
        }
    }
}
