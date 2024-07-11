//
//  RestoHomeVC.swift
//  Spacial OClock
//
//  Created by cqlios on 28/11/23.
//

import UIKit
import SDWebImage
import SwiftGifOrigin
import SkeletonView
class RestoHomeVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tableVW: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var lblNoOfuser: UILabel!

    //MARK: - VARIABLES
    var viewmodel = restoViewModal()
    var modal : [Rows]?
    var filterdata : [Rows]?
    var selectedDate : String?
    let refresh = UIRefreshControl()
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVW.isSkeletonable = true
        tfSearch.delegate = self
        img.isHidden = true
        refresh.addTarget(self, action: #selector(swipeRefresh(_:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "Refreshing...")
        tableVW.addSubview(refresh)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
   
    @objc func swipeRefresh(_ sender: UIRefreshControl){
        sender.beginRefreshing()
        setupAPI(date: "")
    }
    
    //MARK: - FUNCTIONS API'S
    func setupAPI(date:String) {
        self.tableVW.showAnimatedGradientSkeleton()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        selectedDate = date == "" ? formatter.string(from: Date()) : date
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            self.viewmodel.homeRestoAPI(restobarID: Store.userDetails?.restoid ?? 0,date: self.selectedDate ?? "") { dataa in
                self.modal = dataa?.rows ?? []
                self.filterdata = dataa?.rows ?? []
                self.lblNoOfuser.text = "Total number of bookings : \(dataa?.rows?.count ?? 0)"
                if self.refresh.isRefreshing {
                    self.refresh.endRefreshing()
                }
                self.tableVW.hideSkeleton()
                self.tableVW.reloadData()
                self.checkProfileCompleted()
            }
        }
    }
    
    private func checkProfileCompleted() {
        if Store.userDetails?.name == "" || Store.userDetails?.phone == 0{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "CompleteProfilePopupVC") as? CompleteProfilePopupVC else { return }
            vc.callBack = { [weak self] in
                let storyBoard = UIStoryboard(name: "RestoBar", bundle: nil)
                guard let vc = storyBoard.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC else { return }
                vc.callBack = { [weak self] in
                    self?.checkProfileCompleted()
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    
    //MARK: - ACTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAPI(date: "")
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnNotification(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.NotificationRestoVC) as! NotificationRestoVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    @IBAction func btnCalendar(_ sender : UIButton){
        let stry = UIStoryboard(name: "Main", bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier: "selectDateVC") as! selectDateVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.callBack = { date in
            print(date)
            self.setupAPI(date: date)
        }
        self.navigationController?.present(vc, animated: true)
    }
}



//MARK: - EXTENSIONS
extension RestoHomeVC : SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RestoHomeTVC"
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}


extension RestoHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterdata?.count == 0 {
            if isToday(dateString: selectedDate ?? ""){
                tableView.setNoDataMessage("Currently there is no booking for today", txtColor: .black)
            }else {
                tableView.setNoDataMessage("Currently there is no booking for date \(selectedDate ?? "")", txtColor: .black)
            }
           
        } else {
            tableView.backgroundView = nil
            return filterdata?.count ?? 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestoHomeTVC", for: indexPath) as! RestroHomeTVC
        let imageIndex = (imageURL) + (filterdata?[indexPath.row].user?.image?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.imgVW.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgVW.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Default_Image"))
        cell.lblDate.text = filterdata?[indexPath.row].bookingDate ?? ""
        
        if filterdata?[indexPath.row].status == 0{
            cell.lblStatus.text = "Ongoing"
            cell.lblStatus.textColor = UIColor(named: "themeAlert")
        } else if filterdata?[indexPath.row].status == 1{
            cell.lblStatus.text = "Completed"
            cell.lblStatus.textColor = UIColor(named: "themeGreen")
        } else{
            cell.lblStatus.text = "Cancelled"
            cell.lblStatus.textColor = UIColor(named: "themeAlert")
        }
        
        if filterdata?[indexPath.row].restrorant?.type == 1 {
            cell.offerNameLbl.text = filterdata?[indexPath.row].offerName ?? ""
            cell.lblBookingNO.text = "-\(filterdata?[indexPath.row].offer_discount ?? "")%"
            cell.lblTime.text = filterdata?[indexPath.row].bookingSlot ?? ""
        } else {
            let offer = filterdata?[indexPath.row].restrorant?.offers?.first(where: {$0.id == filterdata?[indexPath.row].offerID})
            cell.lblTime.text = "\(offer?.openTime ?? "") - \(offer?.closeTime ?? "")"
            cell.lblBookingNO.text = ""
            cell.offerNameLbl.text = ""
        }
        
        cell.lblUserNo.text = filterdata?[indexPath.row].user?.name?.capitalized ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.bookingDetailsVC) as! bookingDetailsVC
        screen.restoid = filterdata?[indexPath.row].id ?? 0
        screen.booking_id = filterdata?[indexPath.row].bookingID ?? ""
        screen.status = filterdata?[indexPath.row].status ?? 0
        screen.isHidden = true
        self.navigationController?.pushViewController(screen, animated: true)
    }
}

extension RestoHomeVC : UITextFieldDelegate {
    //MARK: - Search
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultString = tfSearch.text ?? ""
        if (resultString.count) > 1{
            if let searchText = tfSearch.text {
                filterdata = modal?.filter {$0.user?.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
            }
        } else {
            filterdata = modal
        }
        tableVW.reloadData()
        return true
    }
}
