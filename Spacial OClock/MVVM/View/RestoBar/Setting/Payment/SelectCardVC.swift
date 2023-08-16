//
//  SelectCardVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit

class SelectCardVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var imgVisaSelectd : UIImageView!
    @IBOutlet weak var imgCreditCardSelected : UIImageView!
    @IBOutlet weak var viewDebit : UIView!
    @IBOutlet weak var viewCredit : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //MARK: Button Action
    @IBAction func btnDebitCardAct(_ sender : UIButton){
        if sender.isSelected == false{
            imgCreditCardSelected.image = UIImage()
            viewCredit.viewBorder(cornerRadius: 10.0, borderWidth: 1, borderColor: UIColor.white)
            imgVisaSelectd.image = UIImage(named:  "selected")
            viewDebit.viewBorder(cornerRadius: 10.0, borderWidth: 1, borderColor: UIColor(named: "themeGreen")!)
        }
    }
    @IBAction func btnCreditAct(_ sender : UIButton){
        if sender.isSelected == false{
            imgCreditCardSelected.image = UIImage(named:  "selected")
            viewCredit.viewBorder(cornerRadius: 10.0, borderWidth: 1, borderColor: UIColor.systemGray)
            imgVisaSelectd.image = UIImage()
            viewDebit.viewBorder(cornerRadius: 10.0, borderWidth: 1, borderColor: UIColor.white )
        }
    }
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPaymentAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.PaymentCenterAlertVC) as! PaymentCenterAlertVC
        self.navigationController?.present(screen, animated: true)
    }
    
}
