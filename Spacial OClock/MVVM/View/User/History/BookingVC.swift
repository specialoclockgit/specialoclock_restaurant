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

class BookingVC: UIViewController, UIGestureRecognizerDelegate {

    //MARK: - OUTLETS
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnCurrent: CustomButton!
    @IBOutlet weak var btnPast: CustomButton!
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var bookingTV: UITableView!
    
    //MARK: - VARIABLES
    var status = 0
    var modal : [currentPastModalBody]?
    var viewmodal = HomeViewModel()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        if btnPast.titleLabel?.textColor == UIColor.white {
            currentpastAPI(status: 1)
        } else {
            currentpastAPI(status: 0)
        }
    }

    //MARK: - FUNCTIONS
    func currentpastAPI(status:Int){
        bookingTV.backgroundView = nil
        bookingTV.showAnimatedGradientSkeleton()
        self.modal?.removeAll()
        self.bookingTV.reloadData()
        viewmodal.currentPast_API(type: status, genre: "0") { [weak self] dataa in
            self?.modal = dataa?.reversed()
            self?.bookingTV.hideSkeleton()
            self?.bookingTV.reloadData()
        }
    }
    // MARK: - ACTIONS
    @IBAction func currentBtn(_ sender: UIButton) {
        currentpastAPI(status: 0)
        lblHeading.text = "Bookings"
        btnCurrent.setTitleColor(UIColor.white, for: .normal)
        btnPast.setTitleColor(UIColor.black, for: .normal)
        btnCurrent.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        btnPast.backgroundColor = .white
        bookingTV.reloadData()
    }
    
    @IBAction func pastBtn(_ sender: UIButton) {
        currentpastAPI(status: 1)
        lblHeading.text = "Bookings"
        btnPast.setTitleColor(UIColor.white, for: .normal)
        btnCurrent.setTitleColor(UIColor.black, for: .normal)
        btnPast.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        btnCurrent.backgroundColor = .white
        bookingTV.reloadData()
    }
}
//MARK: - EXTENSIONS
extension BookingVC: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "bookingCell"
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if modal?.count == 0{
            tableView.setNoDataMessage("No booking found",yPosition: -120)
        } else {
            tableView.backgroundView = nil
            return modal?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookingCell") as! bookingCell
        cell.bookingListing = modal?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.bookingDetailVC) as! bookingDetailVC
        screen.status = modal?[indexPath.row].status ?? 0
        if status == 1 {
            screen.buttonTitle = "Add Rating & Review"
            screen.buttonColor = "themeOrange"
            screen.statusColor = "themeGreen"
            screen.statusVerify = 1
        } else {
            screen.cancelid = modal?[indexPath.row].bookingID ?? ""
            screen.booking_id = modal?[indexPath.row].id ?? 0
            screen.buttonTitle = "Cancel Booking"
            screen.buttonColor = "themeRed"
            screen.statusColor = "themeRed"
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
    
    
    var bookingListing: currentPastModalBody? {
        didSet {
            if bookingListing?.status == 0 {
                bookingStatuslbl.text = "Ongoing"
                bookingStatuslbl.textColor = .red
            } else if bookingListing?.status == 1 {
                bookingStatuslbl.text = "Completed"
                bookingStatuslbl.textColor = .systemGreen
            } else {
                bookingStatuslbl.text = "Cancelled"
                bookingStatuslbl.textColor = .red
            }
            bookingDatelbl.text = bookingListing?.bookingDate ?? ""
            bookingNumber.text = bookingListing?.bookingID ?? ""
            bookingTimelbl.text = bookingListing?.bookingSlot ?? ""
            let imageIndex = (imageURL) + (bookingListing?.restoImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            itemImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            itemImg.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
        }
    }
    
}
