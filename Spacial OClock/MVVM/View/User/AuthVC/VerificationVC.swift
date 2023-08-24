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
    @IBOutlet weak var numberLbl: UILabel!
    
    //MARK: Variables
    var btnCheckStatus = Int()
    var viewmodel = AuthViewModel()
    var otpVerify : String?
    // var dataget = comonmodelModel()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonUtilities.shared.showAlert(Title: "Please enter otp 1111", message:  "\(String(describing: ""))", isSuccess: .success, duration: 2)
        numberLbl.text = "\(Store.userDetails?.countryCode ?? "") \(Store.userDetails?.phone ?? 0)"
    }
    
    @IBAction func btnSendAgain(_ sender: Any) {
        viewmodel.resendOtp(phone: "\(Store.userDetails?.phone ?? 0)", onSuccess: {
            CommonUtilities.shared.showAlert(Title: "Please enter otp 1111", message:  "\(String(describing: ""))", isSuccess: .success, duration: 2)
        })
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyBtn(_ sender: UIButton) {
        viewmodel.otpverification(otp: viewPin.getPin()) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifypopUpVC") as! VerifypopUpVC
            vc.modalPresentationStyle = .overFullScreen
            vc.callBack = {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC")as! TabbarVC
                if self.btnCheckStatus == 1{
                    // vc.heading = "Pub & Bar Profile"
                    // vc.name = "Bar Name"
                    //  UserDefaults.standard.set("Bar", forKey: "name")
                }
                //Resto
                else if self.btnCheckStatus == 0{
                    //  vc.heading = "Restaurant Profile"
                    //  vc.name = "Restaurant Name"
                    //  UserDefaults.standard.set("Restaurant", forKey: "name")
                }
                UserDefaults.standard.set(self.btnCheckStatus, forKey: "status")
                
                // vc.btnCheckStatus = self.btnCheckStatus
                self.navigationController?.pushViewController(vc, animated: true)
            }
            self.navigationController?.present(vc, animated: true)
        }
    }
}

