//
//  bookingDetailVC.swift
//  Spacial OClock
//
//  Created by cql99 on 26/06/23.
//

import UIKit
import SDWebImage
import Cosmos

struct ModelItemDetail {
    var img : String
    var itmeName : String
    var newPrice : String
}

class bookingDetailVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSpeOffer: UILabel!
    @IBOutlet weak var lblBookingNumber: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblOpenClosetime: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var viewCosmos: CosmosView!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblRestoName: UILabel!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewReview: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var VeiwOfferCheck: UIView!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var btnMain : UIButton!
    @IBOutlet weak var lblBookingtime: UILabel!
    @IBOutlet weak var lblstatus : UILabel!
    @IBOutlet weak var lblOfferDis: UILabel!
    @IBOutlet weak var lblNOP: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var bookingSlotStartEndTime : UILabel!
    @IBOutlet weak var reviewUserImgVw: UIImageView!
    @IBOutlet weak var reviewUserNamelbl: UILabel!
    @IBOutlet weak var reviewUserTimeLbl: UILabel!
    @IBOutlet weak var reviewUserCommentLbl: UILabel!
    @IBOutlet weak var reviewUserRatingVw: CosmosView!
    @IBOutlet weak var reviewUserVw: UIView!
    @IBOutlet weak var replyVw: UIView!
    @IBOutlet weak var replyRestroImgVw: UIImageView!
    @IBOutlet weak var replyRestroNameLbl: UILabel!
    @IBOutlet weak var replyTimeLbl: UILabel!
    @IBOutlet weak var replyCommentLbl: UILabel!
    @IBOutlet weak var replyRestroType: UILabel!
    //MARK: - VARIABLES
    var buttonTitle = String()
    var buttonColor = String()
    var status = Int()
    var statusColor = String()
    var image = String()
    var statusVerify = Int()
    var arrData  : [ModelItemDetail] = [ ModelItemDetail(img: "planeSanwich", itmeName: "Sandwich", newPrice: "40.00") , ModelItemDetail(img: "grilledSandwich", itmeName: "Grilled Sandwich", newPrice: "20.00")]
    var viewmodal = HomeViewModel()
    var modal : bookingDetailModalBody?
    var products: [Product]?
    var booking_id = Int()
    var actualprice = Int()
    var presntsPrice = String()
    var canceltext = String()
    var cancelid = String()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewReview.layer.cornerRadius = 12
        viewReview.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMaxXMaxYCorner]
        tabBarController?.tabBar.isHidden = true
        btnMain.backgroundColor = UIColor(named : buttonColor)
        lblstatus.textColor = UIColor(named: statusColor)
        img.image = UIImage(named: image)
        bookingDetial()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tblView.removeObserver(self, forKeyPath: "contentSize")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if(keyPath == "contentSize"){
                if let newvalue = change?[.newKey]
                {
                    let newsize  = newvalue as! CGSize
                    tblViewHeight.constant = newsize.height
                    //newsize.height
                }
            }
        }
    
    //MARK: - FUNCTIONS
    func bookingDetial(){
        viewmodal.bookingDetail_API(bookingId: booking_id) { fetchdata in
            self.modal = fetchdata
            self.products = fetchdata?.productsUnderOffer ?? []
            
            let imageIndex = (imageURL) + (fetchdata?.restrorant?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            self.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            self.lblCity.text = fetchdata?.restrorant?.city ?? ""
            self.lblLocation.text = fetchdata?.restrorant?.location ?? ""
            self.lblRestoName.text = fetchdata?.restrorant?.name ?? ""
            if self.modal?.status == 0{
                self.reviewUserVw.isHidden = true
                self.replyVw.isHidden = true
                self.lblstatus.text = "Ongoing"
                self.btnMain.setTitle("Cancel Booking", for: .normal)
            }else if self.modal?.status == 1{
                if let review = self.modal?.review, review.review != ""{
                    self.btnMain.isHidden = true
                    self.reviewUserVw.isHidden = false
                    self.reviewUserTimeLbl.text = self.string_date_ToDate(review.createdAt ?? "", currentFormat: .BackEndFormat, requiredFormat: .mon_dd_yyyy)
                    self.reviewUserNamelbl.text = review.userName ?? ""
                    self.reviewUserImgVw.showIndicator(baseUrl: imageURL, imageUrl: review.userImage ?? "")
                    self.reviewUserRatingVw.rating = Double(review.rating ?? "") ?? 0
                    self.reviewUserCommentLbl.text = review.review ?? ""
                    
                    self.replyVw.isHidden = review.reply == "" ? true : false
                    self.replyTimeLbl.text = self.string_date_ToDate(review.updatedAt ?? "", currentFormat: .BackEndFormat, requiredFormat: .mon_dd_yyyy)
                    self.replyCommentLbl.text = review.reply ?? ""
                    self.replyRestroNameLbl.text = self.modal?.restrorant?.name ?? ""
                    self.replyRestroImgVw.showIndicator(baseUrl: imageURL, imageUrl: self.modal?.restrorant?.profileImage ?? "")
                    self.replyRestroType.text = self.modal?.restrorant?.type == 1 ? "Restaurant Reply" : "Bar Reply"
                }else {
                    self.replyVw.isHidden = true
                    self.btnMain.isHidden = false
                    self.reviewUserVw.isHidden = true
                }
                self.lblstatus.text = "Complete"
                self.btnMain.setTitle("Add Rating & Review", for: .normal)
            }else{
                self.reviewUserVw.isHidden = true
                self.replyVw.isHidden = true
                self.btnMain.isHidden = true
                self.lblstatus.text = "Cancelled"
            }
            if fetchdata?.restrorant?.type == 2 {
              
                self.bookingSlotStartEndTime.text = "Offer from \(fetchdata?.restrorant?.offers?.first?.openTime ?? "") to \(fetchdata?.restrorant?.offers?.first?.closeTime ?? "")"
                self.lblSpeOffer.text = fetchdata?.restrorant?.offers?.first?.menuName ?? ""
                self.lblBookingtime.text = "\(fetchdata?.restrorant?.offers?.first?.openTime ?? "")-\(fetchdata?.restrorant?.offers?.first?.closeTime ?? "")"
            }else {
                self.lblSpeOffer.text = fetchdata?.offerName ?? "" + (fetchdata?.offerPercentage ?? "")
                self.bookingSlotStartEndTime.text = fetchdata?.bookingSlot ?? ""
                self.lblBookingtime.text = fetchdata?.bookingSlot ?? ""
            }
            self.lblOpenClosetime.text = "\(fetchdata?.restrorant?.openTime ?? "") to " + "\(fetchdata?.restrorant?.closeTime ?? "")"
            
            self.lblAvgRating.text = "\(fetchdata?.restrorant?.avgRating ?? 0)"
            //self.viewCosmos.rating = Double(fetchdata?.restrorant?.avgRating ?? 0)
            self.lblBookingNumber.text = fetchdata?.bookingID ?? ""
            
            self.lblOfferDis.text = fetchdata?.restrorant?.shortDescription ?? ""
           
            self.lblDate.text = fetchdata?.bookingDate ?? ""
            self.lblNOP.text = "\(fetchdata?.numberOfPeople ?? 0)"
            self.actualprice = fetchdata?.restrorant?.offers?.first?.offerPrice ?? 0
            self.presntsPrice = fetchdata?.offerPercentage ?? ""
           // self.tblView.reloadData()
        }
    }
    
    //MARK: - FUNCTION
    func calculation(actualPrice : Int, offerPrice: Int) -> Int {
        let valueget = actualPrice * offerPrice / 100
        return valueget
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnOffer(_ sender: UIButton) {
        if sender.isSelected == false{
            VeiwOfferCheck.isHidden = true
        }else{
            VeiwOfferCheck.isHidden = false
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btnMainAct(_ sender : UIButton){
        debugPrint(statusVerify)
        //Add Ratting
        if self.modal?.status == 1{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.AddRatingVC) as! AddRatingVC
            screen.restoID = self.modal?.restrorant?.id ?? 0
            screen.imgUrl = self.modal?.restrorant?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? ""
            screen.bookingID = self.booking_id
            self.navigationController?.pushViewController(screen, animated: true)
        }
        //Cancel Booking
        else if self.modal?.status == 0{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.CancelBookingAlertVC) as! CancelBookingAlertVC
            screen.callBack = {
                let reasonScreen = self.storyboard?.instantiateViewController(withIdentifier: ViewController.CancelBookingReasonVC) as! CancelBookingReasonVC
                reasonScreen.callBack = { dataa in
                    self.canceltext = dataa
                    self.viewmodal.cancelBookig_API(bookingId: self.cancelid , reson: self.canceltext) { dataa in
                        let bookingScreen = self.storyboard?.instantiateViewController(withIdentifier: ViewController.BookingVC) as! BookingVC
                        self.navigationController?.pushViewController(bookingScreen, animated: true)
                    }
                }
                self.navigationController?.present(reasonScreen, animated: true)
            }
            self.navigationController?.present(screen, animated:true)
            
        }
    }
    
}
//MARK: - EXTENSION
extension bookingDetailVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookingDetailTVC", for: indexPath) as! bookingDetailTVC
        let dataIs = products?[indexPath.row]
        if self.modal?.restrorant?.type == 2 {
            
            if products?[indexPath.row].discounted_price == 0 || products?[indexPath.row].actual_price == 0 {
                cell.lblPreviousPrice.text = ""
                cell.lblNewPrice.text = ""
            } else {
                cell.lblPreviousPrice.text = "R"+(dataIs?.actual_price?.description ?? "")
                cell.lblNewPrice.text = "R"+(dataIs?.discounted_price?.description ?? "")
            }
            
        } else {
            cell.lblPreviousPrice.text = "R\(products?[indexPath.row].price ?? 0)"
            let offer = calculation(actualPrice: dataIs?.price ?? 0, offerPrice: Int(self.presntsPrice) ?? 0)
            cell.lblNewPrice.text = "R"+String((products?[indexPath.row].price ?? 0) - offer)+".00"
            
        }
        
        cell.imgItem.showIndicator(baseUrl: productImgURL, imageUrl: dataIs?.image?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.lblItmeName.text = products?[indexPath.row].productName ?? ""
        return cell
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        DispatchQueue.main.async {
//            self.tblViewHeight.constant = self.tblView.contentSize.height
//        }
//    }
}
