//
//  EditProductVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit

class EditProductVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tfProductName : UITextField!
    @IBOutlet weak var tfPrice : UITextField!
    @IBOutlet weak var tfSelectCusins : UITextField!
    @IBOutlet weak var imgProduct : UIImageView!
    
    //MARK: Variables
    var imgName  = String()
    var productName = String()
    var price = String()
    var picker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCameraAct(_ sender : UIButton){
        ImagePicker().pickImage(self) { (image) in
            self.imgProduct.image = image
        }
    }
    @IBAction func btnSaveAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension EditProductVC{
    func initialLoad(){
        view.hideKeyboardWhenTappedAround()
        tfProductName.text = productName
        tfPrice.text = price
        imgProduct.image = UIImage(named: imgName)
        tfSelectCusins.setupRightImage(imageName: "dropDownResto" , width: 7 , height: 5)
        tfSelectCusins.inputView = picker
    }
}
