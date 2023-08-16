//
//  RestoVerificationVC.swift
//  Spacial OClock
//
//  Created by cql211 on 07/07/23.
//

import UIKit
import SVPinView

class RestoVerificationVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var viewPin :SVPinView!
    @IBOutlet weak var lblMobile: UILabel!
    
    //MARK: Variables
    var btnCheckStatus = Int()
    var viewmodel = AuthViewModel()
    var otpVerify : String?
   // var dataget = comonmodelModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                CommonUtilities.shared.showAlert(Title: "Please enter otp 1111", message:  "\(String(describing: ""))", isSuccess: .success, duration: 2)
                       }
 
    @IBAction func btnSendAgain(_ sender: Any) {
        viewmodel.resendOtp {
            CommonUtilities.shared.showAlert(Title: "Please enter otp 1111", message:  "\(String(describing: ""))", isSuccess: .success, duration: 2)
        }
        
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func verifyBtn(_ sender: UIButton) {
        viewmodel.otpverification(otp: viewPin.getPin()) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewController.RestoVerificationAlertVC)as! RestoVerificationAlertVC
            
            vc.modalPresentationStyle = .overFullScreen
            vc.callBack = {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewController.restoCreateVC)as! restoCreateVC

                            if self.btnCheckStatus == 1{
                                vc.heading = "Pub & Bar Profile"
                                vc.name = "Bar Name"
                                UserDefaults.standard.set("Bar", forKey: "name")
                            }
                            //Resto
                            else if self.btnCheckStatus == 0{
                                vc.heading = "Restaurant Profile"
                                vc.name = "Restaurant Name"
                                UserDefaults.standard.set("Restaurant", forKey: "name")
                            }
                            UserDefaults.standard.set(self.btnCheckStatus, forKey: "status")
                
                            vc.btnCheckStatus = self.btnCheckStatus
                self.navigationController?.pushViewController(vc, animated: true)
            }
            self.navigationController?.present(vc, animated: true)
        }
        
    }
}
