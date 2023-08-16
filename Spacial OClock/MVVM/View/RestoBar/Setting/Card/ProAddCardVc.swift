//
//  ProAddCardVc.swift
//  Spacial OClock
//
//  Created by cqlios on 03/07/23.
//

import UIKit

class ProAddCardVc: UIViewController {

    //MARK: - OUTLETS
    
    //MARK: - VARIABLES
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - ACTIONS
    @IBAction func btnAdd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

