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
    var countryName : String?
    var restoselctStatus = Int()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLbl.text = "\(Store.userDetails?.countryCode ?? "") \(Store.userDetails?.phone ?? 0)"
    }
    
    @IBAction func btnSendAgain(_ sender: UIButton) {
        viewmodel.resendOtp(phone: "\(Store.userDetails?.phone ?? 0)", onSuccess: {

        })
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyBtn(_ sender: UIButton) {
        viewmodel.otpverification(otp: viewPin.getPin()) {
            
            //MARK: - USER SIDE STATUS 0
            if self.btnCheckStatus == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifypopUpVC") as! VerifypopUpVC
                vc.modalPresentationStyle = .overFullScreen
                vc.callBack = {
                    Store.autoLogin = true
                    Store.screenType = 1
                    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                    let nav = UINavigationController.init(rootViewController: redViewController)
                    nav.isNavigationBarHidden = true
                    UIApplication.shared.windows.first?.rootViewController = nav
                    
                }
                self.navigationController?.present(vc, animated: true)
            }
            
            //MARK: - RESTO SIDE 2
            else {
                let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "restoCreateVC") as! restoCreateVC
                vc.btnCheckStatus = self.restoselctStatus
                if self.restoselctStatus == 1 {
                    vc.heading = "Restaurant Profile"
                    vc.name = "Restaurant Name"
                    vc.country = self.countryName ?? ""
                    UserDefaults.standard.set("Restaurant", forKey: "name")
                }else if  self.restoselctStatus == 2 {
                    vc.heading = "Club Profile"
                    vc.name = "Club Name"
                    UserDefaults.standard.set("Club", forKey: "name")
                } else {
                    vc.heading = "Bar Profile"
                    vc.name = "Bar Name"
                    UserDefaults.standard.set("Bar", forKey: "name")
                }
                UserDefaults.standard.set(self.restoselctStatus, forKey: "status")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


