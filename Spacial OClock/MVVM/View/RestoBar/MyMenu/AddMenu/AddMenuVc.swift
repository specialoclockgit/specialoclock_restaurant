//
//  AddMenuVc.swift
//  Spacial OClock
//
//  Created by cql99 on 27/06/23.
//

import UIKit

class AddMenuVc: UIViewController {

    //MARK: - OUTLETS
    
    //MARK: - VARIABLES
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.hideKeyboardWhenTappedAround()

    }
    //MARK: - ACTIONS
    @IBAction func btnAdd(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
