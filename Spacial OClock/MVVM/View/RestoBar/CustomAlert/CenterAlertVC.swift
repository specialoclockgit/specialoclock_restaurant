//
//  CenterAlertVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit

class CenterAlertVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var imgAlert : UIImageView!
    @IBOutlet weak var lblAlertMessage : UILabel!
    
    //MARK: Variables
    var alertMessage = String()
    var alertImage = String()
    var status = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLoad()
    }
    
    //MARK: Button Action
    @IBAction func btnYesAct(_ sender : UIButton){
        
    }
    @IBAction func btnNoAct(_ sender : UIButton){
        self.dismiss(animated: true)
    }
    
}
//MARK: AssignValue
extension CenterAlertVC{
    func initialLoad(){
        imgAlert.image = UIImage(named: alertImage)
        lblAlertMessage.text = alertMessage
    }
}
