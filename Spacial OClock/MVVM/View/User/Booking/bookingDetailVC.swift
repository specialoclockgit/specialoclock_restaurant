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
    var products: [Productx]?
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
    }
    
    //MARK: - FUNCTIONS
    func bookingDetial(){
        viewmodal.bookingDetail_API(bookingId: booking_id) { fetchdata in
            self.modal = fetchdata
            self.products = fetchdata?.restrorant?.products ?? []
            let imageIndex = (imageURL) + (fetchdata?.restrorant?.profileImage ?? "")
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
            self.lblOpenClosetime.text = "\(fetchdata?.restrorant?.openTime ?? "") to " + "\(fetchdata?.restrorant?.closeTime ?? "")"
            self.lblAvgRating.text = "\(fetchdata?.restrorant?.avgRating ?? 0)"
            //self.viewCosmos.rating = Double(fetchdata?.restrorant?.avgRating ?? 0)
            self.lblBookingNumber.text = fetchdata?.bookingID ?? ""
            self.lblSpeOffer.text = fetchdata?.offerName ?? "" + (fetchdata?.offerPercentage ?? "")
            self.lblOfferDis.text = fetchdata?.restrorant?.shortDescription ?? ""
            self.lblBookingtime.text = fetchdata?.bookingSlot ?? ""
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
        
        cell.lblPreviousPrice.text =  "R"+String(calculation(actualPrice: dataIs?.price ?? 0, offerPrice: Int(self.presntsPrice) ?? 0))+".00"
        cell.lblNewPrice.text = "R\(products?[indexPath.row].price ?? 0)"
        //cell.imgItem.image = UIImage(named: arrData[indexPath.row].img) // arrData[indexPath.row]
        cell.lblItmeName.text = products?[indexPath.row].productName ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tblViewHeight.constant = self.tblView.contentSize.height
        }
    }
}
