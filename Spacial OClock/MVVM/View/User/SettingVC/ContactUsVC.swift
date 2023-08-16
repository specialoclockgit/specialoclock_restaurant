//
//  ContactUsVC.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit

class ContactUsVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tfEmail : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    

 
    // MARK: - Actions

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
