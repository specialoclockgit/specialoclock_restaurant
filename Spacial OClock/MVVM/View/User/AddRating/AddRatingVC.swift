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
    @IBOutlet weak var ImgVw: UIImageView!
    //MARK: - VARIABLES
    var viewmodal = HomeViewModel()
    var restoID = Int()
    var bookingID = Int()
    var ratig = Double()
    var imgUrl = ""
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden  = true
        ImgVw.showIndicator(baseUrl: imageURL, imageUrl: imgUrl)
    }
    
    
    //MARK: - FUCNTION
    func add_Review(){
        viewmodal.addReviewAPI(restoid: restoID, rating: Double(cosmosView.rating) , review: txtView.text,bookingId: self.bookingID) { dataa in
            CommonUtilities.shared.showAlert(message: "Review submitted successfully", isSuccess: .success)
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
