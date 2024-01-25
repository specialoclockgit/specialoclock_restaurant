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
        btnMain.setTitle(buttonTitle, for: .normal)
        btnMain.backgroundColor = UIColor(named : buttonColor)
        lblstatus.textColor = UIColor(named: statusColor)
        img.image = UIImage(named: image)
        bookingDetial()
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
            if self.status == 0{
                self.lblstatus.text = "Ongoing"
            }else if self.status == 1{
                self.lblstatus.text = "Complete"
            }else{
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
            self.tblView.reloadData()
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
        if statusVerify == 1{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.AddRatingVC) as! AddRatingVC
            self.navigationController?.pushViewController(screen, animated: true)
        }
        //Cancel Booking
        else if statusVerify == 0{
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
            
        }else {
            cell.lblPreviousPrice.text =  "R"+String(calculation(actualPrice: dataIs?.price ?? 0, offerPrice: Int(self.presntsPrice) ?? 0))+".00"
            cell.lblNewPrice.text = "R\(products?[indexPath.row].price ?? 0)"
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
