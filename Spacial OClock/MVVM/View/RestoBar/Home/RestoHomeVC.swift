//
//  RestoHomeVC.swift
//  Spacial OClock
//
//  Created by cqlios on 28/11/23.
//

import UIKit
import SDWebImage
import SwiftGifOrigin


class RestoHomeVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tableVW: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var lblNoOfuser: UILabel!

    //MARK: - VARIABLES
    var viewmodel = restoViewModal()
    var modal : [Rows]?
    var filterdata : [Rows]?
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tfSearch.delegate = self
        
    }
    //MARK: - FUNCTIONS API'S
    func setupAPI(){
        viewmodel.homeRestoAPI(restobarID: Store.userDetails?.id ?? 0) { dataa in
            self.modal = dataa?.rows ?? []
            self.filterdata = dataa?.rows ?? []
            self.lblNoOfuser.text = "Total number of bookings : \(dataa?.count ?? 0)"
            self.tableVW.reloadData()
        }
    }
    //MARK: - ACTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if self.accessibilityHint == "Restaurant"{
//            setupAPI()
//        }else{
//            setupAPI()
//        }
        setupAPI()
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnNotification(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.NotificationRestoVC) as! NotificationRestoVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
//MARK: - EXTENSIONS
extension RestoHomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterdata?.count == 0 {
            img.image = UIImage.gif(name: "nodataFound")
            img.isHidden = false
        }else{
            img.isHidden = true
            return filterdata?.count ?? 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestoHomeTVC", for: indexPath) as! RestoHomeTVC
        let imageIndex = (imageURL) + (filterdata?[indexPath.row].user?.image ?? "")
        cell.imgVW.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgVW.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Default_Image"))
        cell.lblDate.text = filterdata?[indexPath.row].bookingDate ?? ""
        cell.lblTime.text = filterdata?[indexPath.row].bookingSlot ?? ""
        if filterdata?[indexPath.row].status == 0{
            cell.lblStatus.text = "Ongoing"
            cell.lblStatus.textColor = UIColor(named: "themeAlert")
        }else{
            cell.lblStatus.text = "Completed"
            cell.lblStatus.textColor = UIColor(named: "themeGreen")
        }
        cell.lblBookingNO.text = filterdata?[indexPath.row].bookingID ?? ""
        cell.lblUserNo.text = filterdata?[indexPath.row].user?.name ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.bookingDetailsVC) as! bookingDetailsVC
        //screen.restoid = filterdata?[indexPath.row].id ?? 0
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
        }else{
            filterdata = modal
        }
        tableVW.reloadData()
        return true
    }
}
