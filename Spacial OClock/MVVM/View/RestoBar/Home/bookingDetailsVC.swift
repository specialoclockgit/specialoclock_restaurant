//
//  bookingDetailsVC.swift
//  Spacial OClock
//
//  Created by cql99 on 19/06/23.
//

import UIKit
import SDWebImage
import Cosmos

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
    @IBOutlet weak var cnclTitleVw: UIView!
    @IBOutlet weak var replyBottom : NSLayoutConstraint!
    @IBOutlet weak var reviewVw: UIView!
    @IBOutlet weak var reviewImgVw: UIImageView!
    @IBOutlet weak var reviewUserName: UILabel!
    @IBOutlet weak var reviewTimelbl: UILabel!
    @IBOutlet weak var reviewRatingVw: CosmosView!
    @IBOutlet weak var reviewCommentLbl: UILabel!
    @IBOutlet weak var replyTF: UITextField!
    @IBOutlet weak var replyVw: UIView!
    @IBOutlet weak var btnShowSendReply: UIButton!
    //MARK: - VARIABELS
    var status = Int()
    var isHidden = Bool()
    var restoid = Int()
    var viewmodal = restoViewModal()
    var modalDetail : restoDetailModalsBody?
    var APIcall = AuthViewModel()
    var productsUnderOffer: [ProductDetail]?
    var booking_id = String()
    var totalamount = Double()
    var prsents = Double()
    var prsentsamount = Double()
    var specailofferless = Double()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHandling()
      
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
            let imageIndex = (imageURL) + (self.modalDetail?.user?.image?.replacingOccurrences(of: " ", with: "%20") ?? "")
            self.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgUser.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            if data?.status == 0{
                self.lblStatus.text = "Ongoing"
                self.cnclTitleVw.isHidden = true
                self.viewOffer.isHidden = true
                self.btnComplete.isHidden = false
                self.btnReportUser.isHidden = false
            }else if data?.status == 1{
                self.lblStatus.text = "Complete"
                self.lblStatus.textColor = UIColor(named: "themeGreen")
                self.btnComplete.isHidden = true
                self.btnReportUser.isHidden = true
//                self.btnReportUser.isHidden = true
                self.cnclTitleVw.isHidden = true
                self.viewOffer.isHidden = true
            } else {
                self.lblStatus.textColor = UIColor(named: "themeAlert")
                self.lblStatus.text = "Cancelled"
                self.btnComplete.isHidden = true
                self.btnReportUser.isHidden = true
                self.cnclTitleVw.isHidden = false
                self.viewOffer.isHidden = false
                self.lblDis.text = data?.cancelationReason ?? ""
            }
            self.lblUDNAme.text = self.modalDetail?.user?.name?.capitalized ?? ""
            self.lblUDEmail.text = self.modalDetail?.user?.email ?? ""
            self.lblUDPhoneNumber.text = "\(self.modalDetail?.user?.countryCode ?? "") " + "\(self.modalDetail?.user?.phone ?? 0)"
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.callToUser(_:)))
            self.lblUDPhoneNumber.addGestureRecognizer(gesture)
            self.lblUDPhoneNumber.isUserInteractionEnabled = true
            //self.lblDis.text = self.modalDetail?.restrorant?.offers?.first?.description ?? ""
            self.lblBookingDate.text = self.modalDetail?.bookingDate ?? ""
            self.lblNumberOfPeople.text = "\(self.modalDetail?.numberOfPeople ?? 0)"
            self.lblBookingNumebr.text = self.modalDetail?.bookingID ?? ""
            self.totalamount = Double(self.productsUnderOffer?.first?.price ?? "0") ?? 0
            self.prsents = Double(self.modalDetail?.bookingAmount ?? "") ?? 0
            self.prsentsamount = self.totalamount * self.prsents / 100
            self.specailofferless = self.totalamount - self.prsentsamount
            
            
            if let reviewData = self.modalDetail?.review, reviewData.review != "" {
                
                self.reviewVw.isHidden = reviewData.reply == "" ? false : true
                self.reviewRatingVw.rating = Double(reviewData.rating ?? "") ?? 0.0
                self.reviewUserName.text = reviewData.userName ?? ""
                let imageIndex = (imageURL) + (reviewData.userImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
                self.reviewImgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.reviewImgVw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
                self.reviewTimelbl.text = convertDateToString(formatString: reviewData.createdAt ?? "")
                self.reviewCommentLbl.text = reviewData.review ?? ""
            } else {
                self.reviewVw.isHidden = true
            }
            
            
            if self.modalDetail?.restrorant?.type == 1 {
                self.lblSOffer.text = "\(self.modalDetail?.offerName ?? "") -\(self.modalDetail?.offer_discount ?? "")%"
                self.lblOfferTime.text = "Offer from " + (self.modalDetail?.bookingSlot ?? "")
                let timeString = self.modalDetail?.bookingSlot ?? ""
                let components = timeString.components(separatedBy: "-")
                if let startTime = components.first, let endTime = components.last {
                    if let startTimeConverted = convertTimeFormat(startTime), let endTimeConverted = convertTimeFormat(endTime) {
                        print("\(startTimeConverted)-\(endTimeConverted)")
                        self.lblBookingTime.text = "\(startTimeConverted)-\(endTimeConverted)"
                    }
                }
                
                let dateString = self.modalDetail?.bookingDate ?? ""
                let dateTimeString = "\(dateString) \(timeString.components(separatedBy: "-").last ?? "")"
                if isDateTimePassed(dateTimeString: dateTimeString) {
                    print("Complete button enabled")
                    self.btnComplete.isUserInteractionEnabled = true
                    self.btnReportUser.isUserInteractionEnabled = true
                    self.btnComplete.backgroundColor = UIColor(named: "themeGreen")
                    self.btnReportUser.backgroundColor = UIColor(named: "themeOrange")
                } else {
                    self.btnComplete.isUserInteractionEnabled = false
                    self.btnReportUser.isUserInteractionEnabled = false
                    self.btnComplete.backgroundColor = .lightGray
                    self.btnReportUser.backgroundColor = .lightGray
                    print("Complete button disabled")
                }
                
            } else {
                let offer = self.modalDetail?.restrorant?.offers?.filter({$0.id == self.modalDetail?.offerID ?? 0})
                self.lblOfferTime.text = "Offer from  \(offer?.first?.openTime ?? "") \(offer?.first?.closeTime ?? "")"
                self.lblBookingTime.text = "\(offer?.first?.openTime ?? "")-\(offer?.first?.closeTime ?? "")"
                self.lblSOffer.text = ""
                let timeString = self.lblBookingTime.text ?? ""
                let dateString = self.modalDetail?.bookingDate ?? ""
                let dateTimeString = "\(dateString) \(timeString.components(separatedBy: "-").last ?? "")"
                if isDateTimePassed(dateTimeString: dateTimeString) {
                    print("Complete button enabled")
                    self.btnComplete.isUserInteractionEnabled = true
                    self.btnReportUser.isUserInteractionEnabled = true
                    self.btnComplete.backgroundColor = UIColor(named: "themeGreen")
                    self.btnReportUser.backgroundColor = UIColor(named: "themeOrange")
                } else {
                    self.btnComplete.isUserInteractionEnabled = false
                    self.btnReportUser.isUserInteractionEnabled = false
                    self.btnComplete.backgroundColor = .lightGray
                    self.btnReportUser.backgroundColor = .lightGray
                    print("Complete button disabled")
                }
            }
           // self.tbItem.reloadData()
        }
    }
    
    func complete_booking(){
        viewmodal.Complete_bookingAPI(bookingid: "\(self.booking_id)") { dataa in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - ACTIONS
    
    @objc func callToUser(_ sender: UITapGestureRecognizer) {
        if let number = self.modalDetail?.user?.phone?.description, let code = self.modalDetail?.user?.countryCode?.description  {
            if let phoneURL = URL(string: "tel://\(code)\(number)") {
                if UIApplication.shared.canOpenURL(phoneURL){
                    UIApplication.shared.open(phoneURL)
                }else {
                    CommonUtilities.shared.showAlert(message: "Invalid phone number")
                }
            }
        }
    }
    
    
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
    @IBAction func btnShowReplyVw(_ sender: UIButton) {
        replyVw.isHidden = false
        replyTF.becomeFirstResponder()
    }
    
    @IBAction func btnSendReply(_ sender: UIButton) {
        viewmodal.replyReviewAPI(review_id: self.modalDetail?.review?.id ?? 0, reply: replyTF.text ?? "") {
            self.replyVw.isHidden = true
            CommonUtilities.shared.showAlert(message: "Review reply submitted successfully", isSuccess: .success)
            self.resto_Detail_Api()
        }
    }
    
    
    @IBAction func onClickReportUser(_ sender: UIButton) {
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "ReportUserPopUpVC") as! ReportUserPopUpVC
        screen.callBack = {
            let vw = self.storyboard?.instantiateViewController(withIdentifier: "ReportUserReasonVC") as! ReportUserReasonVC
            vw.callBack = { [weak self] val in
                if val.trimWhiteSpace.isEmpty {
                    CommonUtilities.shared.showAlert(message: "Please enter a reason", isSuccess: .error)
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
        
        if self.modalDetail?.restrorant?.type == 2 || self.modalDetail?.restrorant?.type == 3{
            cell.lblPrevPrice.text = "R\(self.productsUnderOffer?[indexPath.row].actual_price ?? "0")"
            cell.lblNewPrice.text = "R\(self.productsUnderOffer?[indexPath.row].discounted_price ?? "0")"
        }else {
            cell.lblPrevPrice.text = "R\(self.productsUnderOffer?[indexPath.row].price ?? "0")"
            cell.lblNewPrice.text = "R\(calCulateDiscount(actualPrice: Double(productsUnderOffer?[indexPath.row].price ?? "0" ) ?? 0, discount: (self.prsents)).description)"
        }
        
        cell.lblItemName.text = productsUnderOffer?[indexPath.row].productName ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        DispatchQueue.main.async { [self] in
//           // heightTBItem.constant = tbItem.contentSize.height
//        }
//    }
}

extension bookingDetailsVC{
    func initialLoad(){
        //imgUser.image = UIImage(named: imgstring)
       // lblStatus.text = statusText
       // lblBookingNumebr.text = bookingNumber
      //  lblBookingTime.text = bookingTime
      //  lblBookingDate.text = bookingDate
       // lblOfferTime.text = "Offer from " + bookingTime
        viewOffer.isHidden = true
        
        //Complete Buuton Hide and Show
//        if status == 0{
//            lblStatus.textColor = UIColor(named: "themeAlert")
//            btnComplete.isHidden = false
//        }else{
//            lblStatus.textColor = UIColor(named: "themeGreen")
//            btnComplete.isHidden = true
//            //Invoice Button
//            let barStatus = UserDefaults.standard.status
//            if barStatus == 1 {
//                //btnComplete.isHidden = false
//                btnComplete.setTitle("Invoice", for: .normal)
//                btnComplete.backgroundColor = UIColor(named: "themeOrange")
//            }
//        }
        if isHidden == true {
           // btnComplete.isHidden = true
        }
    }
}
func convertTimeFormat(_ timeString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    if let time = dateFormatter.date(from: timeString) {
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: time)
    }
    
    return nil
}
func isDateTimePassed(dateTimeString: String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    
    if let dateTime = dateFormatter.date(from: dateTimeString) {
        let currentDate = Date()
        return currentDate > dateTime
    }
    
    return false
}



extension bookingDetailsVC {
    private func keyboardHandling(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    
        self.replyBottom.constant = 10
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136,1334,1920, 2208:
                    self.replyBottom.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom+3)
                case 2436,2688,1792:
                    self.replyBottom.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom+10)
                default:
                    self.replyBottom.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom+10)
                }
            }
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        }
    }
}


func convertDateToString(formatString:String) -> String {
    let dateString = formatString
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: dateString)
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMM d, yyyy h:mm a"
    return outputFormatter.string(from: date ?? Date())
    
}
