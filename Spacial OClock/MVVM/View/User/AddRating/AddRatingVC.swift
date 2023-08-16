//
//  AddRatingVC.swift
//  Spacial OClock
//
//  Created by cql99 on 26/06/23.
//

import UIKit
import Cosmos
import IQKeyboardManagerSwift

class AddRatingVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var txtView: IQTextView!
    @IBOutlet weak var cosmosView: CosmosView!
    
    //MARK: - VARIABLES
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden  = true

    }
    //MARK: - ACTIONS
    @IBAction func btnSubmit(_ sender: UIButton) {
//        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.BookingVC) as! BookingVC
//        self.navigationController?.pushViewController(screen, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
