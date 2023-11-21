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
    var viewmodal = HomeViewModel()
    var restoID = Int()
    var ratig = Double()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden  = true

    }
    
    
    //MARK: - FUCNTION
    func add_Review(){
        viewmodal.addReviewAPI(restoid: restoID, rating: Double(cosmosView.rating) , review: txtView.text) { dataa in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnSubmit(_ sender: UIButton) {
        add_Review()
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
