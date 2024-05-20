//
//  MyReviewVC.swift
//  Spacial OClock
//
//  Created by cqlios on 02/07/23.
//

import UIKit
import SDWebImage
import Cosmos
import SwiftGifOrigin

class MyReviewVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var tableVW: UITableView!
   
    
    //MARK: - VARIABLES
    var viewmodel = restoViewModal()
    var dataget : [ReviewListingModelBody]?
    var imageView: UIImageView?
    //MARK: - VEIW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupapi()
        
    }
    //MARK: - FUNCTION API REVIEW
    func setupapi(){
        viewmodel.reviewListing(restoid: Store.userDetails?.bussiness_id ?? 0) { data in
            self.dataget = data
            self.tableVW.reloadData()
        }
    }
    //MARK: - ACTIONS
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
//MARK: - EXTENSIONS
extension MyReviewVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataget?.count == 0{
            tableView.setNoDataMessage("No review found", txtColor: .black)
        }else{
            tableView.backgroundView = nil
            return dataget?.count ?? 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyReviewTVC", for: indexPath) as! MyReviewTVC
        cell.listing = dataget?[indexPath.row]
        return cell
    }
}
