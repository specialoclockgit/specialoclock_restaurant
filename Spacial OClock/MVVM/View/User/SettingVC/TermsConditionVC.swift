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
    @IBOutlet weak var txtView: UITextView!
    
    //MARK: - Variables
    var status = 0
    var viewModel = AuthViewModel()
    var titleLbl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if status == 0{
            cms(type: 1)
        }else if status == 1{
            cms(type: 2)
        }
        headerlbl.text = titleLbl
        self.tabBarController?.tabBar.isHidden = true
    }
    

    // MARK: - Actions
    @IBAction func backBtn(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func cms(type:Int){
        viewModel.cmsAPI(type: type) { data in
            self.txtView.text = data.body?.description?.htmlToString
        }
    }
}
