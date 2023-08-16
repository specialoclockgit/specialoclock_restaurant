//
//  CustomTopAlertVC.swift
//  Spacial OClock
//
//  Created by cql211 on 30/06/23.
//

import UIKit

class CustomTopAlertVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var imgAlert : UIImageView!
    @IBOutlet weak var lblMessage : UILabel!
    @IBOutlet weak var btnAlert : UIButton!
    
    //MARK: Variables
    var message : String = ""
    var buttonText : String = ""
    var callBack: (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(message)
        debugPrint(buttonText)
        // Do any additional setup after loading the view.
    }
    
    //MARK: Button ACtions
    @IBAction func btnOkAct(sender : UIButton){
        self.dismiss(animated: true) {
            self.callBack?()
        }
    }
}
