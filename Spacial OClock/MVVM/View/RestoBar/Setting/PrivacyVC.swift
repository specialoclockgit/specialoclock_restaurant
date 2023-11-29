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
    var viewmodel = restoViewModal()
    
    //MARK: - VIEW LIFECYCLE
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
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}
