//
//  HistoryVC.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit
import SDWebImage
import SkeletonView
import SwiftGifOrigin

class BookingVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnCurrent: CustomButton!
    @IBOutlet weak var btnPast: CustomButton!
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var bookingTV: UITableView!
    
    //MARK: - VARIABLES
    var arrImg = ["Rectangle1","Rectangle 351"]
    var status = 0
    var modal : [currentPastModalBody]?
    var viewmodal = HomeViewModel()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        currentpastAPI()
        bookingTV.showSkeleton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    //MARK: - FUNCTIONS
    func currentpastAPI(){
        viewmodal.currentPast_API(type: status, genre: "0") { [weak self] dataa in
            self?.modal = dataa
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.bookingTV.hideSkeleton()
            }
            self?.bookingTV.reloadData()
        }
    }
    // MARK: - ACTIONS
    @IBAction func currentBtn(_ sender: UIButton) {
        currentpastAPI()
        status = 0
        lblHeading.text = "Bookings"
        btnCurrent.setTitleColor(UIColor.white, for: .normal)
        btnPast.setTitleColor(UIColor.black, for: .normal)
        btnCurrent.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        btnPast.backgroundColor = .white
        bookingTV.reloadData()
    }
    
    @IBAction func pastBtn(_ sender: UIButton) {
        currentpastAPI()
        status = 1
        lblHeading.text = "Orders"
        btnPast.setTitleColor(UIColor.white, for: .normal)
        btnCurrent.setTitleColor(UIColor.black, for: .normal)
        btnPast.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        btnCurrent.backgroundColor = .white
        bookingTV.reloadData()
    }
}
//MARK: - EXTENSIONS
extension BookingVC: UITableViewDelegate, UITableViewDataSource{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "bookingCell"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if modal?.count == 0{
            self.imgView.image = UIImage.gif(name: "nodataFound")
            self.imgView.isHidden = false
        }else{
            self.imgView.isHidden = true
            return modal?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookingCell") as! bookingCell
        if self.modal?[indexPath.row].status == 0{
            cell.bookingStatuslbl.text = "Ongoing"
            cell.bookingStatuslbl.textColor = .red
        }else{
            cell.bookingStatuslbl.text = "Completed"
            cell.bookingStatuslbl.textColor = .systemGreen
        }
        cell.bookingDatelbl.text = modal?[indexPath.row].bookingDate ?? ""
        cell.bookingNumber.text = modal?[indexPath.row].bookingID ?? ""
        cell.bookingTimelbl.text = modal?[indexPath.row].bookingSlot ?? ""
        let image = self.modal?[indexPath.row].restoImage ?? ""
        let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        cell.itemImg.showIndicator(baseUrl: imageURL, imageUrl: urlString)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.bookingDetailVC) as! bookingDetailVC
        if status == 1{
            screen.buttonTitle = "Add Rating & Review"
            screen.buttonColor = "themeOrange"
            screen.status = "Completed"
            screen.statusColor = "themeGreen"
            screen.image = arrImg[indexPath.row]
            screen.statusVerify = 1
        }else{
            screen.buttonTitle = "Cancel Booking"
            screen.buttonColor = "themeRed"
            screen.status = "Ongoing"
            screen.statusColor = "themeRed"
            screen.image = arrImg[indexPath.row]
            screen.statusVerify = 0
        }
        self.navigationController?.pushViewController(screen, animated: true)
    }
}

//MARK: - UITableViewCell
class bookingCell:UITableViewCell{
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var bookingNumber: UILabel!
    @IBOutlet weak var bookingDatelbl: UILabel!
    @IBOutlet weak var bookingTimelbl: UILabel!
    @IBOutlet weak var bookingStatuslbl: UILabel!
    
    
}
