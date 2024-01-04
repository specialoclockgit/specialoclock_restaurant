//
//  bookingDetailsVC.swift
//  Spacial OClock
//
//  Created by cql99 on 19/06/23.
//

import UIKit
import SDWebImage

class bookingDetailsVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var btnReportUser: UIButton!
    @IBOutlet weak var lblDis: UILabel!
    @IBOutlet weak var lblSOffer: UILabel!
    @IBOutlet weak var lblUDPhoneNumber: UILabel!
    @IBOutlet weak var lblUDEmail: UILabel!
    @IBOutlet weak var lblUDNAme: UILabel!
    @IBOutlet weak var viewOffer: UIView!
    @IBOutlet weak var imgUser : UIImageView!
    @IBOutlet weak var lblStatus : UILabel!
    @IBOutlet weak var tbItem : UITableView!
    @IBOutlet weak var lblBookingNumebr : UILabel!
    @IBOutlet weak var lblBookingTime : UILabel!
    @IBOutlet weak var lblBookingDate : UILabel!
    @IBOutlet weak var lblNumberOfPeople : UILabel!
    @IBOutlet weak var lblOfferTime : UILabel!
    @IBOutlet weak var btnComplete : UIButton!
    @IBOutlet weak var heightTBItem : NSLayoutConstraint!
    
    //MARK: - VARIABELS
    var offershow = -1
    var status = Int()
    var imgstring = "Ellipse 119"
    var statusText = String()
    var bookingNumber = "05"
    var bookingTime = "16:00 to 22:00"
    var bookingDate = "21 May 2023 "
    var isHidden = Bool()
    var restoid = Int()
    var viewmodal = restoViewModal()
    var modalDetail : restoDetailModalsBody?
    var APIcall = AuthViewModel()
    var productsUnderOffer: [ProductDetail]?
    var booking_id = String()
    var bookingnumber = Int()
    var totalamount = Int()
    var prsents = Int()
    var prsentsamount = Int()
    var specailofferless = Int()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        initialLoad()
        tbItem.delegate = self
        tbItem.dataSource = self
        resto_Detail_Api()
    }
    

    //MARK: - FUCNTIONS
    func resto_Detail_Api(){
        viewmodal.homeRestoDetailAPI(restoid: restoid) { data in
            self.modalDetail = data
            
            self.productsUnderOffer = data?.productsUnderOffer ?? []
            let imageIndex = (imageURL) + (self.modalDetail?.user?.image ?? "")
            self.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgUser.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            if self.status == 0{
                self.lblStatus.text = "Ongoing"
            }else if self.status == 1{
                self.lblStatus.text = "Complete"
                self.lblStatus.textColor = UIColor(named: "themeGreen")
//                self.btnComplete.isHidden = true
//                self.btnReportUser.isHidden = true
            }else{
                self.lblStatus.textColor = UIColor(named: "themeAlert")
                self.lblStatus.text = "Cancelled"
            }
            self.lblUDNAme.text = self.modalDetail?.user?.name ?? ""
            self.lblUDEmail.text = self.modalDetail?.user?.email ?? ""
            self.lblUDPhoneNumber.text = "\(self.modalDetail?.user?.countryCode ?? "") " + "\(self.modalDetail?.user?.phone ?? 0)"
            self.lblSOffer.text = "Special offer -\(self.modalDetail?.restrorant?.offers?.first?.offerPrice?.description ?? "")%"
            self.lblDis.text = self.modalDetail?.restrorant?.offers?.first?.description ?? ""
            self.lblBookingDate.text = self.modalDetail?.bookingDate ?? ""
            self.lblBookingTime.text = self.modalDetail?.bookingSlot ?? ""
            self.lblNumberOfPeople.text = "\(self.modalDetail?.numberOfPeople ?? 0)"
            self.lblBookingNumebr.text = self.modalDetail?.bookingID ?? ""
            self.totalamount = self.productsUnderOffer?.first?.price ?? 0
            self.prsents = self.modalDetail?.restrorant?.offers?.first?.offerPrice ?? 0
            self.prsentsamount = self.totalamount * self.prsents/100
            self.specailofferless = self.totalamount - self.prsentsamount
            self.tbItem.reloadData()
        }
    }
    
    func complete_booking(){
        viewmodal.Complete_bookingAPI(bookingid: "\(self.booking_id)") { dataa in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnCheckOffer(_ sender: UIButton) {
        viewOffer.isHidden = sender.isSelected == false ? true : false
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueAct(_ sender : UIButton){
        complete_booking()
    }
    
    
    @IBAction func onClickReportUser(_ sender: UIButton) {
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "ReportUserPopUpVC") as! ReportUserPopUpVC
        screen.callBack = {
            let vw = self.storyboard?.instantiateViewController(withIdentifier: "ReportUserReasonVC") as! ReportUserReasonVC
            vw.callBack = { [weak self] val in
                if val.trimWhiteSpace.isEmpty {
                    CommonUtilities.shared.showAlert(message: "Please enter reason", isSuccess: .error)
                } else {
                    self?.viewmodal.homeReportUser(restoid: self?.modalDetail?.bookingID ?? "", reason: val) { response in
                        if response?.code == 200 {
                            CommonUtilities.shared.showAlert(message: response?.message ?? "", isSuccess: .success)
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            self.present(vw, animated: true)
        }
        
        self.present(screen, animated: true)
    }
    
}
extension bookingDetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsUnderOffer?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellBookingDetailTB, for: indexPath) as! CellBookingDetailTB
        let imageIndex = (productImgURL) + (self.productsUnderOffer?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Default_Image"))
        cell.lblPrevPrice.text = "R\(self.productsUnderOffer?[indexPath.row].price ?? 0)"
        cell.lblNewPrice.text = "R\(calCulateDiscount(actualPrice: Double(productsUnderOffer?[indexPath.row].price ?? 0), discount: Double(self.prsents)).description)"
        cell.lblItemName.text = productsUnderOffer?[indexPath.row].productName ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [self] in
            heightTBItem.constant = tbItem.contentSize.height
        }
    }
}

extension bookingDetailsVC{
    func initialLoad(){
        imgUser.image = UIImage(named: imgstring)
        lblStatus.text = statusText
        lblBookingNumebr.text = bookingNumber
        lblBookingTime.text = bookingTime
        lblBookingDate.text = bookingDate
        lblOfferTime.text = "Offer from " + bookingTime
        viewOffer.isHidden = true
        
        //Complete Buuton Hide and Show
        if status == 0{
            lblStatus.textColor = UIColor(named: "themeAlert")
            //btnComplete.isHidden = false
        }else{
            lblStatus.textColor = UIColor(named: "themeGreen")
           // btnComplete.isHidden = true
            //Invoice Button
            let barStatus = UserDefaults.standard.status
            if barStatus == 1 {
                btnComplete.isHidden = false
                btnComplete.setTitle("Invoice", for: .normal)
                btnComplete.backgroundColor = UIColor(named: "themeOrange")
            }
        }
        if isHidden == true {
            btnComplete.isHidden = true
        }
    }
}
