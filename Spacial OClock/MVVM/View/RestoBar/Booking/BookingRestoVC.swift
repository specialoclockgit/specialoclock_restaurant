//
//  BookingVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit
import SkeletonView
import SDWebImage
import SwiftGifOrigin

struct ModelBooking {
    var img : String
    var bookingID : String
    var bookingDate : String
    var  bookingTime : String
}
class BookingRestoVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var btnCurrent : UIButton!
    @IBOutlet weak var btnPast : UIButton!
    @IBOutlet weak var tbBooking : UITableView!
    var viewmodal = restoViewModal()
    var modal : [rstoCurrentModalBody]?
    
    //MARK: Variable
    var statusButton = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(statusButton)
        let nib = UINib(nibName: Cell.CellBookingRestoTB, bundle: nil)
        tbBooking.register(nib, forCellReuseIdentifier: Cell.CellBookingRestoTB)
        tbBooking.delegate = self
        tbBooking.dataSource =  self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK: - FUCNTIONS
    func currentpastAPI(status:Int){
        viewmodal.resto_currentPast_API(type: status, genre: "1") { [weak self] dataa in
            self?.modal = dataa?.reversed()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.tbBooking.hideSkeleton()
            }
            self?.tbBooking.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if btnPast.titleLabel?.textColor == UIColor.white {
            currentpastAPI(status: 1)
        } else {
            currentpastAPI(status: 0)
        }
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Button Action
    @IBAction func btnCurrentAct(_ sender : UIButton){
        currentpastAPI(status: 0)
        if sender.isSelected == false{
            btnPast.backgroundColor = UIColor.white
            btnPast.setTitleColor(UIColor.black, for: .normal)
            btnCurrent.backgroundColor = UIColor(named: "themeOrange")
            btnCurrent.setTitleColor(UIColor.white, for: .normal)
        
        }
        tbBooking.reloadData()
    }
    @IBAction func btnPastAct(_ sender : UIButton){
        currentpastAPI(status: 1)
        if sender.isSelected == false{
            btnPast.backgroundColor = UIColor(named: "themeOrange")
            btnPast.setTitleColor(UIColor.white, for: .normal)
            btnCurrent.backgroundColor = UIColor.white
            btnCurrent.setTitleColor(UIColor.black, for: .normal)
        }
        tbBooking.reloadData()
    }
}
extension BookingRestoVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if modal?.count == 0{
            tableView.setNoDataMessage("No booking found", txtColor: .black)
          //  imgViewGif.image = UIImage.gif(name: "nodataFound")
           // imgViewGif.isHidden = false
        }else{
            tableView.backgroundView = nil
           // imgViewGif.isHidden = true
            return modal?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbBooking.dequeueReusableCell(withIdentifier: Cell.CellBookingRestoTB, for: indexPath) as! CellBookingRestoTB
        if modal?[indexPath.row].status == 0 {
            cell.lblStatus.text = "Ongoing"
            cell.lblStatus.textColor = UIColor(named: "themeAlert")
            cell.lblBookingIDHeading.text = "Booking Number:"
        }else if modal?[indexPath.row].status == 1{
            cell.lblStatus.text = "Completed"
            cell.lblStatus.textColor = UIColor(named: "themeGreen")
            cell.lblBookingIDHeading.text = "Booking Id:"
        }else{
            cell.lblStatus.text = "Cancelled"
            cell.lblStatus.textColor = UIColor(named: "themeAlert")
        }
        let imageIndex = (imageURL) + (modal?[indexPath.row].userImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgUser.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Default_Image"))
        cell.lblUserIndex.text = modal?[indexPath.row].userName ?? ""
        cell.lblBookingID.text = modal?[indexPath.row].bookingID
        cell.lblBookingDate.text = modal?[indexPath.row].bookingDate
        cell.lblBookingTime.text = modal?[indexPath.row].bookingSlot
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        let screen = storyboard?.instantiateViewController(withIdentifier: "bookingDetailsVC") as! bookingDetailsVC
        screen.restoid = modal?[indexPath.row].id ?? 0
        screen.status = modal?[indexPath.row].status ?? 0
//        if statusButton == 0 {
//            //screen.status = 0
//            screen.statusText = "Ongoing"
//        }else{
//            //screen.status = 1
//            screen.statusText = "Completed"
//        } 
        screen.booking_id = modal?[indexPath.row].bookingID ?? ""
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
}

