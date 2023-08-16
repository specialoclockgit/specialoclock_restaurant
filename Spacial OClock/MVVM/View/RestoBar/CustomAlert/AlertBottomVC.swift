//
//  AlertBottomVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit

class AlertBottomVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lblMessage : UILabel!
    
    //MARK: Variables
    var status = Int()
    var imgString = String()
    var messgae = String()
    var callBack : (()->())?
    var statuschange = Int()
    var viewmodel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = UIImage(named: imgString)
        lblMessage.text = messgae
        // Do any additional setup after loading the view.
    }
    
    //MARK: Button Act
    
    @IBAction func btnYesAct(_ sender : UIButton){
        if statuschange == 0{
            self.viewmodel.deleteAccountApi {
                self.dismiss(animated: true)
                self.callBack?()
            }
        }else{
            viewmodel.logoutapicall {
                Store.autoLogin = false
                Store.userDetails = nil
                Store.authKey = nil
                self.dismiss(animated: true)
                self.callBack?()
                
            }
            }
//        }
    }
      
    @IBAction func btnNoACt(_ sender : UIButton){
        self.dismiss(animated: true)
    }
}
