//
//  AddProductVC.swift
//  Spacial OClock
//
//  Created by cql211 on 04/07/23.
//

import UIKit

class AddProductVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var imgProduct : UIImageView!
    @IBOutlet weak var tfSelectCuisines : UITextField!
    
    //MARK: Variable
    var picker = UIPickerView()
    var menuID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.hideKeyboardWhenTappedAround()
        tfSelectCuisines.setupRightImage(imageName: "dropDownResto", width:7, height: 5)
        tfSelectCuisines.inputView = picker
        // Do any additional setup after loading the view.
    }

    //MARK: Action
    @IBAction func btnImgAct(_ sender : UIButton){
            ImagePicker().pickImage(self) { (image) in
        self.imgProduct.image = image
        }
    }
    @IBAction func btnAddAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
