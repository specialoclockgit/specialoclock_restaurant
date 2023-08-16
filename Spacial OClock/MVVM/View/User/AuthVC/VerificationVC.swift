//
//  VerificationVC.swift
//  Special O'Clock
//
//  Created by cql197 on 16/06/23.
//

import UIKit
import SVPinView
class VerificationVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var viewPin : SVPinView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPin.style = .box
       
      //  viewPin.placeholder = "0000"
        
//        viewPin.borderLineThickness = 2
//        viewPin.layer.shadowColor = UIColor.gray.cgColor
//        viewPin.layer.shadowOpacity = 1
//        viewPin.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func verifyBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VerifypopUpVC")as! VerifypopUpVC
        vc.modalPresentationStyle = .overFullScreen
        vc.callBack = {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC")as! TabbarVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.navigationController?.present(vc, animated: true)
    }
}
