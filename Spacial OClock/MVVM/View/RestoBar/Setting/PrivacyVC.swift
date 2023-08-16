//
//  PrivacyVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit
import AVFoundation

class PrivacyVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var lblcms: UITextView!
    @IBOutlet weak var lblHeading : UILabel!

    //MARK: Variable
    var status = Int()
    var heading = String()
    var viewmodel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        lblHeading.text = heading
        if self.lblHeading.text == "Privacy Policy" {
            viewmodel.privacypolicyApi { data in
                self.lblcms.text = data?.description.htmlToString
            }
        } else {
            self.lblHeading.text == "Terms and condition"; do {
                self.viewmodel.termsandconditionApi { data in
                    self.lblcms.text = data?.description.htmlToString
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension PrivacyVC {
//    func checkStatus(){
//        switch status {
//        case 0:
//            debugPrint("0")
//        case 1:
//            debugPrint("1")
//               default:
//            debugPrint("")
//        }
//    }
}
