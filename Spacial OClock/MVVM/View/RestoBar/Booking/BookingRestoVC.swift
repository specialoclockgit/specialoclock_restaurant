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

class BookingRestoVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var btnCurrent : UIButton!
    @IBOutlet weak var btnPast : UIButton!
    @IBOutlet weak var tbBooking : UITableView!
    
    //MARK: Variable
    var viewmodal = restoViewModal()
    var modal : [rstoCurrentModalBody]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: Cell.CellBookingRestoTB, bundle: nil)
        tbBooking.register(nib, forCellReuseIdentifier: Cell.CellBookingRestoTB)
        tbBooking.delegate = self
        tbBooking.dataSource =  self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    
    }
    
    //MARK: - FUCNTIONS
    func currentpastAPI(status:Int) {
        tbBooking.showAnimatedGradientSkeleton()
        viewmodal.resto_currentPast_API(type: status, genre: "1") { [weak self] dataa in
            self?.modal = dataa?.reversed()
            self?.tbBooking.hideSkeleton()
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
    }
    
    //MARK: Button Action
    @IBAction func btnCurrentAct(_ sender : UIButton) {
        currentpastAPI(status: 0)
        btnPast.backgroundColor = UIColor.white
        btnPast.setTitleColor(UIColor.black, for: .normal)
        btnCurrent.backgroundColor = UIColor(named: "themeOrange")
        btnCurrent.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func btnPastAct(_ sender : UIButton) {
        currentpastAPI(status: 1)
        btnPast.backgroundColor = UIColor(named: "themeOrange")
        btnPast.setTitleColor(UIColor.white, for: .normal)
        btnCurrent.backgroundColor = UIColor.white
        btnCurrent.setTitleColor(UIColor.black, for: .normal)
    }
}
extension BookingRestoVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if modal?.count == 0 {
            tableView.setNoDataMessage("No booking found", txtColor: .black)
        } else {
            tableView.backgroundView = nil
            return modal?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbBooking.dequeueReusableCell(withIdentifier: Cell.CellBookingRestoTB, for: indexPath) as! CellBookingRestoTB
        cell.bookingListing = modal?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: "bookingDetailsVC") as! bookingDetailsVC
        screen.restoid = modal?[indexPath.row].id ?? 0
        screen.status = modal?[indexPath.row].status ?? 0
        screen.booking_id = modal?[indexPath.row].bookingID ?? ""
        screen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
}

