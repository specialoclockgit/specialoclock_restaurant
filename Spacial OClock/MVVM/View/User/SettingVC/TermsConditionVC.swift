//
//  TermsConditionVC.swift
//  Special O'Clock
//
//  Created by cql197 on 16/06/23.
//

import UIKit

class TermsConditionVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var headerlbl: UILabel!
    
    
    //MARK: - Variables
    var status = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if status == 0{
            headerlbl.text = "Terms Condition"
        }else if status == 1{
            headerlbl.text = "Privacy Policy"
        }else {
            headerlbl.text = "Terms Condition"
        }
        self.tabBarController?.tabBar.isHidden = true

    }
    

    // MARK: - Actions
    @IBAction func backBtn(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
