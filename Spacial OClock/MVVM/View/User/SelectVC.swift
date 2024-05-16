//
//  SelectVC.swift
//  Spacial OClock
//
//  Created by cqlios on 26/12/23.
//

import UIKit

class SelectVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var userBgImage : UIImageView!
    @IBOutlet weak var restroBgImage : UIImageView!
    @IBOutlet weak var clubBgImage : UIImageView!
    @IBOutlet weak var continueBtn : UIButton!
    @IBOutlet weak var barBgImageVw: UIImageView!
    //MARK: - VARIABLES
    var selectStatus = 0
    var restoselctStatus = 0
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(true, forKey: "AppInstalled")
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 40
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    //MARK: - ACTIONS
    @IBAction func btnUser(_ sender: UIButton) {
        selectStatus = 1
        continueBtn.backgroundColor = UIColor.init(named: "themeOrange")
        userBgImage.image = UIImage(named: "userSelected")
        restroBgImage.image = UIImage(named: "restroUnselected")
        clubBgImage.image = UIImage(named: "clubUnselected")
        barBgImageVw.image = UIImage(named: "barUnselected")
    }
    
    @IBAction func btnRestro(_ sender: UIButton) {
        selectStatus = 2
        restoselctStatus = 1
        continueBtn.backgroundColor = UIColor.init(named: "themeOrange")
        userBgImage.image = UIImage(named: "userUnselected")
        restroBgImage.image = UIImage(named: "restroSelected")
        clubBgImage.image = UIImage(named: "clubUnselected")
        barBgImageVw.image = UIImage(named: "barUnselected")
    }
    
    @IBAction func btnClub(_ sender: UIButton) {
        selectStatus = 2
        restoselctStatus = 2
        continueBtn.backgroundColor = UIColor.init(named: "themeOrange")
        userBgImage.image = UIImage(named: "userUnselected")
        restroBgImage.image = UIImage(named: "restroUnselected")
        clubBgImage.image = UIImage(named: "clubSelected")
        barBgImageVw.image = UIImage(named: "barUnselected")
    }
    
    @IBAction func btnBar(_ sender: UIButton){
        selectStatus = 2
        restoselctStatus = 3
        userBgImage.image = UIImage(named: "userUnselected")
        restroBgImage.image = UIImage(named: "restroUnselected")
        clubBgImage.image = UIImage(named: "clubUnselected")
        barBgImageVw.image = UIImage(named: "barSelected")
    }
    
    
    @IBAction func btnContinue(_ sender: UIButton) {
        if selectStatus == 0 {
            CommonUtilities.shared.showAlert(message: "Please select your sign-up type", isSuccess: .error)
        } else {
            let stry = UIStoryboard(name: "Main", bundle: nil)
             let vc = stry.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
             vc.selectStatus = self.selectStatus
             vc.restoselctStatus = self.restoselctStatus
             self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
