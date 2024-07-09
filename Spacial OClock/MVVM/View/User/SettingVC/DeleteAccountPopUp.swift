//
//  DeleteAccountPopUp.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit

class DeleteAccountPopUp: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    //MARK: - Variables
    var callBack:(()->())?
    var status = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if status == 0{
            self.userImg.image = UIImage(named: "delete-user")
            titlelbl.text = "Are you sure want to delete your account?"
        }else{
            self.userImg.image = UIImage(named: "logout")
            titlelbl.text = "Are you sure you want to log out?"
        }
    }
    

    // MARK: - Actions
    @IBAction func yesBtn(_ sender: UIButton) {
        self.dismiss(animated: true){
            self.callBack?()
        }
        
    }
    
    @IBAction func noBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}
