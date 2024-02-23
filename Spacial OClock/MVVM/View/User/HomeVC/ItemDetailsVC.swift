//
//  ItemDetailsVC.swift
//  Spacial OClock
//
//  Created by cql211 on 28/06/23.
//

import UIKit
import SDWebImage
import IQKeyboardManagerSwift
import Cosmos
import CoreLocation
import QuartzCore

struct ModelMenuCollView {
    var name : [String]
    var time :[String]
}

struct ModelMenuTBCell {
    var heading : String
    var image : [String]
    var itemName : [String]
    var prevPrice : [String]
    var newPrice : [String]
}

class ItemDetailsVC: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlet
    @IBOutlet weak var imgViewGifReview: UIImageView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var lblOfferDiscription: UILabel!
    @IBOutlet weak var collView : UICollectionView!
    @IBOutlet weak var tbReview : UITableView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var viewAbout : UIView!
    @IBOutlet weak var viewMenu : UIView!
    @IBOutlet weak var viewRestoRating: UIView!
    @IBOutlet weak var lblAbout : UILabel!
    @IBOutlet weak var lblMenu : UILabel!
    @IBOutlet weak var lblReview : UILabel!
    @IBOutlet weak var viewA : UIView!
    @IBOutlet weak var lblAboutDetail : UILabel!
    @IBOutlet weak var viewM : UIView!
    @IBOutlet weak var viewR : UIView!
    @IBOutlet weak var viewSV : UIView!
    @IBOutlet weak var lblNameREsto: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var viewReview: UIView!
    @IBOutlet weak var imgBottomView : UIImageView!
    @IBOutlet weak var viewFCHeight: NSLayoutConstraint!
    @IBOutlet weak var viewFullMenu: UICollectionView!
    @IBOutlet weak var viewFullMeny: UIView!
    //MENU Outlets
    @IBOutlet weak var ImgViewgifReview: UIImageView!
    @IBOutlet weak var collViewMenu : UICollectionView!
    @IBOutlet weak var tbMenu : UITableView!
    @IBOutlet weak var heightTBMenu : NSLayoutConstraint!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var heightTBReview : NSLayoutConstraint!
    @IBOutlet weak var txtFldDate: UITextField!
    @IBOutlet weak var lblTotalRes: UILabel!
    @IBOutlet weak var imgFav : UIImageView!
    @IBOutlet weak var btnFav : UIButton!
    @IBOutlet weak var btnBook : UIButton!
    @IBOutlet weak var viewButton : UIView!
    @IBOutlet weak var heightViewButton : NSLayoutConstraint!
    @IBOutlet weak var collViewMenuHeight : NSLayoutConstraint!
    @IBOutlet weak var viewFM: UIView!
    @IBOutlet weak var lblFullMenu: UILabel!
    @IBOutlet weak var lblUserLOcation: UILabel!
    @IBOutlet weak var lblOpenClose: UILabel!
    @IBOutlet weak var favIconVw: UIView!
    //MARK: Variable
    let promotionTxt = "Promotion cannot be applied with any other in-house promotions.Please refer to the special condition below for more details."
    var offerDescription = String()
    var lat : Double?
    var long : Double?
    var discount : Int?
    let locationManager = CLLocationManager()
    var ProductID = Int()
    var pendingSlots = Int()
    var datePicker = UIDatePicker()
    var viewmodal = HomeViewModel()
    var modal : productDetailModalBody?
    var images: [Imaged]?
    var reviews: [Reviewsd]?
    var ourMenu: [OurMenud]?
    var products: [Product]?
    var productModal : menuProductModalBody?
    var arrCollMenu : [ModelMenuCollView] = []
    var offerID = Int()
    var arrTBMenu : [ModelMenuTBCell] = [ModelMenuTBCell(heading: "Sandwich", image: ["goose" , "belveder",                                            "Ciroc" ],
                                                         itemName: ["Plain Sandwich" , "Grilled Sandwich" ,                                   "Club Sandwich"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00",  "R20.00" ,"R30.00"]) ,
                                         
                                         ModelMenuTBCell(heading: "Burgers", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""]),
                                         ModelMenuTBCell(heading: "Pizzas", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""]),
                                         ModelMenuTBCell(heading: "Soups", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""])]
    var imgName = UIImage()
    var arrCheck : [Bool] = []
    var btnBookStatus = Int()
    let status = Store.screenType
    //UserDefaults.standard.value(forKey: "dineDrinkStatus") as? Int
    var actualprice = String()
    var offerlessprice = String()
    var idsave = Int()
    var menuid = Int()
    var numberofperson = Int()
    var valueSelect = false
    var isselectedoffer = -1
    var restrorant_bar_id = Int()
    var offer : [OfferTimingDetail]?
    
    var currentDate = Date()
    var datecuurent = String()
    var slottime = String()
    var slotid = Int()
    var screenCheck = Int()
    var timeZone = String()
    var selectOffer = String()
    //full menu
    var modalfullmenu : [allMenuModalBody]?
    var restoid = Int()
    var offerpresents = Int()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeZone = TimeZone.current.identifier
        print(timeZone)
        viewFullMenu.delegate = self
        viewFullMenu.dataSource = self
        fetchdata()
        self.datecuurent = string(format: "yyyy-MM-dd")
        txtFldDate.text = datecuurent
        viewRestoRating.layer.cornerRadius = 12
        viewRestoRating.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMaxXMaxYCorner]
        txtFldDate.delegate = self
        showDatePicker()
        tbMenu.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        initialLoad()
        img.image = imgName
        collView.delegate = self
        collView.dataSource = self
        
        let nib = UINib(nibName: Cell.CellItemDetailReviewTB, bundle: nil)
        tbReview.register(nib, forCellReuseIdentifier: Cell.CellItemDetailReviewTB)
        tbReview.delegate = self
        tbReview.dataSource = self
        
        //Menu view
        collViewMenu.delegate = self
        collViewMenu.dataSource = self
        let nibMenu = UINib(nibName: Cell.CellMenuCV, bundle: nil)
        self.collViewMenu.register(nibMenu, forCellWithReuseIdentifier: Cell.CellMenuCV)
        
        let nibMenuTB = UINib(nibName: Cell.CellMenuTV, bundle: nil)
        self.tbMenu.register(nibMenuTB, forCellReuseIdentifier: Cell.CellMenuTV)
        tbMenu.delegate = self
        tbMenu.dataSource = self
        
        
        for i in 0...(self.products?.count ?? 0){
            self.arrCheck.append(false)
        }
   
        
    }
    
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateFormat = format
        return formatter.string(from: self.currentDate)
    }
        
    //MARK: - FUNCTION
    func product_detail(){
        viewmodal.restoDetial_API(resto_id: ProductID, currentdate: self.txtFldDate.text ?? "",timezone: self.timeZone ) { data in
            self.modal = data
           
            self.images = data?.images ?? []
            self.reviews = data?.reviews?.reversed() ?? []
            self.ourMenu = data?.ourMenu ?? []
            if self.status == 1 {
                self.offer = data?.offer_timings ?? []
            } else {
               // self.offer = self.processOfferResponse()
                self.offer = data?.offer_timings?.unique(map: {$0.offerID})
                    //
            }
         
            let imageIndex = (imageURL) + (self.modal?.images?.first?.image?.replacingOccurrences(of: " ", with: "%20") ?? "")
            self.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            self.lblNameREsto.text = self.modal?.name ?? ""
            self.lblLocation.text = self.modal?.location ?? ""
            self.lblUserLOcation.text = self.modal?.city ?? ""
            self.lblOpenClose.text = "\((self.modal?.openTime ?? "").components(separatedBy: " ").first ?? "") - " + "\((self.modal?.closeTime ?? "").components(separatedBy: " ").first ?? "")"
            if self.modal?.isLiked == 0{
                self.imgFav.image = UIImage(named: "white h")
            }else{
                self.imgFav.image = UIImage(named: "red h")
            }
            
            if self.modal?.userID == Store.userDetails?.id {
                self.viewButton.isHidden = true
            }
            
          //  self.viewButton.isHidden = self.modal?.userID == Store.userDetails?.id ? true : false
            self.favIconVw.isHidden = self.modal?.userID == Store.userDetails?.id ? true : false
            self.lblAboutDetail.text = self.ourMenu?.first?.offers?.description ?? ""
            self.lblRating.text = self.modal?.avgRating ?? ""
            self.lblAboutDetail.text = self.modal?.shortDescription ?? ""
            self.lblTotalRes.text = "\(self.modal?.totalBookings ?? "") Reservations"
            self.cosmosView.rating = Double(self.modal?.avgRating ?? "") ?? 0.0
            self.getUpdatedLocation()
            self.collViewMenu.reloadData()
            self.collView.reloadData()
            self.tbReview.reloadData()
            self.tbMenu.reloadData()
            self.view.layoutIfNeeded()
            if self.offer?.count ?? 0 > 0 {
                self.discount = self.offer?[0].percentage ?? 0
                //if Store.screenType == 1 {
                    self.menuProductAPI(id: self.offer?[0].menuID ?? 0,index: 0,isfifty: self.offer?[0].is_fifty ?? 0,offerID: self.offer?[0].offerID ?? 0)
               // }else {
                //   self.menuProductForBarAPI(id: self.offer?[0].menuID ?? 0,index: 0,isfifty: self.offer?[0].is_fifty ?? 0,offerID: self.offer?[0].offerID ?? 0)
             // }
             
                
            }
        }
    }
    
    
    
    
    //MARK: - FUNCTION
    func fetchdata(){
        viewmodal.allMenu_API(resto_bar_id: ProductID) { [weak self] data in
            self?.modalfullmenu =  data
            self?.viewFullMenu.reloadData()
        }
    }
    
    //MARK: - SHOW DATE PICKER
    func showDatePicker(){
        datePicker.datePickerMode = .date
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        txtFldDate.inputAccessoryView = toolbar
        txtFldDate.inputView = datePicker
    }
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtFldDate.text = formatter.string(from: datePicker.date)
        product_detail()
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    //MARK: - MENU PRODUCT API
    func menuProductForBarAPI(id: Int,index:Int,isfifty:Int,offerID:Int){
        viewmodal.menuProductForBarAPI(offerID:offerID,restoid: ProductID, menutypeid: id, isfifty:isfifty) { resp in
            
        }
    }
    
    
    func menuProductAPI(id: Int,index:Int,isfifty:Int,offerID:Int){
        viewmodal.menuProductAPI(offerID:offerID,restoid: ProductID, menutypeid: id, isfifty:isfifty) { dataa in
            self.productModal = dataa
            self.offerpresents = dataa?.products?.first?.offerPercentage ?? 0
            self.products = dataa?.products ?? []
            self.lblOfferDiscription.text = dataa?.offerdetails?.description ?? ""
            self.numberofperson = dataa?.offerdetails?.numberOfUserPerBooking ?? 0
            self.actualprice = "\(self.products?.first?.price ?? 0)"
            self.offerlessprice = "\(dataa?.offerdetails?.offerPrice ?? 0)"
            self.offerDescription = dataa?.offerdetails?.description ?? ""
            self.lblOfferDiscription.text = dataa?.offerdetails?.description ?? ""
            self.pendingSlots = dataa?.offerdetails?.numberOfUserBook ?? 0
            self.tbMenu.reloadData()
            self.collViewMenu.reloadData()
            self.arrCheck.removeAll()
            
            for i in 0...(self.products?.count ?? 0){
                if i == 0 {
                    if self.viewButton.isHidden == true {
                        self.arrCheck.append(false)
                    } else {
                        self.arrCheck.append(true)
                    }
                    
                } else {
                    self.arrCheck.append(false)
                }
                self.tbMenu.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        product_detail()
//        if Store.userDetails?.role == 1{
//            self.viewButton.isHidden = false
//        }else{
//            self.viewButton.isHidden = true
//        }
        valueSelect = false
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: Button Action
    @IBAction func btnAudioCall(_ sender: UIButton) {
        if let phoneURL = URL(string: "\(Store.userDetails?.phone ?? 0)") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }else {
                
            }
        }

    }
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnLocation(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "mapViewController") as! mapViewController
        vc.iscomeFrom = 0
        vc.latitude = Double(Store.userDetails?.latitude ?? "") ?? 0.0
        vc.longitude = Double(Store.userDetails?.longitude ?? "") ?? 0.0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func isSelected(sender : UIButton){
        
        switch sender.tag {
        case 0 :
            ChangebgColor(viewSelected: viewAbout, viewUnselected: viewMenu, viewUnselected2: viewReview, ViewUnselected3: viewFullMeny, labelSelected: lblAbout, labelUnselected: lblMenu, labelUnselecte2: lblReview,lblUnselected3: lblFullMenu)
            viewA.layoutSubviews()
            viewA.isHidden = false
            viewM.isHidden = true
            viewR.isHidden = true
            viewFM.isHidden = true
            viewButton.isHidden = true
            debugPrint("0")
            
        case 1 :
            ChangebgColor(viewSelected: viewMenu, viewUnselected: viewAbout, viewUnselected2: viewReview,ViewUnselected3: viewFullMeny, labelSelected: lblMenu, labelUnselected: lblAbout, labelUnselecte2: lblReview,lblUnselected3: lblFullMenu)
            viewA.isHidden = true
            viewM.isHidden = false
            viewR.isHidden = true
            viewFM.isHidden = true
            viewButton.isHidden = false
            btnBookStatus = 0
            btnBook.setTitle("Book", for: .normal)
            //MARK: Set Menu tabel Data
            if status == 0 {
                product_detail()
            }else if status == 1 {
                product_detail()
            }
            tbMenu.reloadData()
            
        case 2 :
            product_detail()
            ChangebgColor(viewSelected: viewReview, viewUnselected: viewAbout, viewUnselected2: viewMenu,ViewUnselected3: viewFullMeny, labelSelected: lblReview, labelUnselected: lblAbout, labelUnselecte2: lblMenu,lblUnselected3: lblFullMenu)
            viewA.isHidden = true
            viewM.isHidden = true
            viewR.isHidden = false
            viewFM.isHidden = true
            viewButton.isHidden = self.modal?.userID == Store.userDetails?.id ? true : false
            btnBookStatus = 1
            btnBook.setTitle("Write a Review", for: .normal)
            debugPrint("2")
    
            
        case 3 :
            fetchdata()
            ChangebgColor(viewSelected: viewFullMeny, viewUnselected: viewAbout, viewUnselected2: viewMenu,ViewUnselected3: viewReview, labelSelected: lblFullMenu, labelUnselected: lblAbout, labelUnselecte2: lblMenu,lblUnselected3: lblReview)
            viewA.isHidden = true
            viewM.isHidden = true
            viewR.isHidden = true
            viewFM.isHidden = false
            viewButton.isHidden = true
            btnBookStatus = 1
           // viewFM.backgroundColor = UIColor.clear
            btnBook.setTitle("Write a Review", for: .normal)
            debugPrint("2")
        default:
            debugPrint("Default Run IsSelected")
        }
    }
    
    //Hide And show Offer Description
    @IBAction func isViewHide(sender : UIButton){
        if sender.isSelected  == false{
            debugPrint("True")
            viewSV.isHidden = true
            sender.isSelected = true
        }else{
            debugPrint("False")
            viewSV.isHidden = false
            sender.isSelected = false
        }
    }
    
    //Book Button
    @IBAction func btnBookAct(_ sender : UIButton){
        if btnBookStatus == 0{
            if self.pendingSlots != 0 {
                let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.NewBookingVC) as! NewBookingVC
                screen.offerSelectePretns = self.offerpresents
                screen.slotId = self.slotid
                screen.selectslot = self.slottime
                screen.oldDateSelect = txtFldDate.text ?? ""
                screen.pickmenuid = self.menuid
                screen.numberofperson = self.numberofperson
                screen.resto_id = ProductID
                screen.offer_id = "\(self.offerID)"
                screen.restrorant_bar_id = self.restrorant_bar_id
                screen.bookingType = Store.screenType == 1 ? .restaurant : .bar
                self.navigationController?.pushViewController(screen, animated: true)
            } else {
                CommonUtilities.shared.showAlert(message: "No more bookings available for this slot", isSuccess: .error)
            }
           
        }
        else if btnBookStatus == 1{
            let screenReview = storyboard?.instantiateViewController(withIdentifier: "AddRatingVC") as! AddRatingVC
            screenReview.restoID = ProductID
            screenReview.imgUrl = self.modal?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? ""
            self.navigationController?.pushViewController(screenReview, animated: true)
        }
    }
    @IBAction func btnMap(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "directionVC") as! directionVC
        vc.lat = Double(self.modal?.latitude ?? "") ?? 0.0
        vc.lng = Double(self.modal?.longitude ?? "") ?? 0.0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnAllMenu(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "allMenuVC") as! allMenuVC
        vc.restoid = ProductID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnFavAct(_ sender : UIButton) {
        if let type = self.modal?.isLiked {
            let likeType = type == 0 ? 1 : 0
            let img = type == 0 ? UIImage(named: "red h") : UIImage(named: "white h")
            viewmodal.resto_likeAPI(Restoid: ProductID, status: likeType) { resp in
                self.modal?.isLiked = likeType
                self.imgFav.image = img
            }
        }
    }
}

extension ItemDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collView{
            if images?.count == 0 {
                collView.setNoDataMessage("No Data found", txtColor: .white)
            }else{
                collView.backgroundView = nil
                return images?.count ?? 0
            }
        }
        else if collectionView == collViewMenu
        {
            //new ourMenu old : offer
            
            if status == 1{
                if offer?.count == 0 {
                    collView.setNoDataMessage("No Data found", txtColor: .black)
                }else{
                    collView.backgroundView = nil
                    return offer?.count ?? 0
                }
            }else{
                if offer?.count == 0 {
                    collView.setNoDataMessage("No Data found", txtColor: .black)
                }else{
                    collView.backgroundView = nil
                    return offer?.count ?? 0
                }
            }
            
            
        }else if collectionView == viewFullMenu{
            if modalfullmenu?.count == 0{
                viewFullMenu.setNoDataMessage("No full menu found", txtColor: .black)
            }else{
                viewFullMenu.backgroundView = nil
                return modalfullmenu?.count ?? 0
            }
        }
        else {
            return 3
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellItemDetailVC", for: indexPath) as! CellItemDetailVC
            let imageIndex = (imageURL) + (self.images?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            return cell
        } else if collectionView == collViewMenu {
            let cell =  collViewMenu.dequeueReusableCell(withReuseIdentifier: Cell.CellMenuCV, for: indexPath) as! CellMenuCV
            if status == 1{
                cell.lblSpecial.isHidden = false
                if indexPath.row == isselectedoffer{
                    self.viewButton.isHidden = Store.userDetails?.role == 1 ? false : true
                    
                    cell.img.image = UIImage(named: "greenRectangle")
                    cell.lblTime.backgroundColor = UIColor(named: "themeGreen")
                    cell.lblTime.text = ""
                    cell.lblOffer.isHidden = false
                    cell.lblOffer.backgroundColor = UIColor(named: "themeGreen")
                } else {
                    cell.img.image = UIImage(named: "BgOfferImg")
                    cell.lblTime.backgroundColor = UIColor(named: "themeOrange")
                    cell.lblTime.text = ""
                    cell.lblOffer.isHidden = false
                  //  cell.lblOffer.backgroundColor = offer?[indexPath.row].is_fifty == 0 ? UIColor(named: "themeOrange") : UIColor.red.withAlphaComponent(0.65)
                    cell.lblOffer.backgroundColor = UIColor(named: "themeOrange")
                }
                let data = offer?[indexPath.row]
                cell.lblMenuSchedule.text = data?.menuName ?? ""
                cell.lblTime.text = data?.offer ?? ""
                cell.lblOffer.text = data?.is_fifty == 0 ? "-\(data?.percentage ?? 0)%" : "%\(50)"
               // cell.lblOffer.backgroundColor = data?.is_fifty == 0 ? UIColor(named: "themeOrange") : UIColor.red
                
            } else {
                cell.lblSpecial.isHidden = true
                if indexPath.row == isselectedoffer{
                    self.viewButton.isHidden = Store.userDetails?.role == 1 ? false : true
                    
                    cell.img.image = UIImage(named: "greenRectangle")
                    cell.lblTime.backgroundColor = UIColor(named: "themeGreen")
                    cell.lblTime.text = ""
                    cell.lblOffer.isHidden = true
                    // cell.lblOffer.backgroundColor = UIColor(named: "themeGreen")
                } else {
                    cell.img.image = UIImage(named: "BgOfferImg")
                    cell.lblTime.backgroundColor = UIColor(named: "themeOrange")
                    cell.lblTime.text = ""
                    cell.lblOffer.isHidden = true
                    //cell.lblOffer.backgroundColor = UIColor(named: "themeOrange")
                }
                let data = offer?[indexPath.row]
                cell.lblMenuSchedule.text = data?.menuName ?? ""
                cell.lblTime.text = "\(data?.openTime ?? "") - \(data?.closeTime ?? "")"
                
            }
            return cell
        } else if collectionView == viewFullMenu {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allMenuCVC", for: indexPath) as! allMenuCVC
            let imageIndex = (self.modalfullmenu?[indexPath.row].baseurl ?? "") + (self.modalfullmenu?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.CellItemDetailVC, for: indexPath) as! CellItemDetailVC
            cell.img.image = imgName
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collViewMenu {
            if status == 1{
                return CGSize (width: 100, height: 200.0)
            }else{
                return CGSize (width: 100, height: 162)
            }
            
        } else if collectionView == viewFullMenu {
            return CGSize(width: viewFullMenu.frame.width / 2.1, height: 166)
        }
        return CGSize(width: 120.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // print(status)
        //debugPrint(indexPath.row)
        if collectionView == collView{
            let vc = storyboard?.instantiateViewController(withIdentifier: "fullImageView") as! fullImageView
            vc.settype = 0
            vc.setImage = self.images?[indexPath.row].image ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else if collectionView == viewFullMenu{
            let vc = storyboard?.instantiateViewController(withIdentifier: "fullImageView") as! fullImageView
            vc.settype = 1
            vc.url = self.modalfullmenu?[indexPath.row].baseurl ?? ""
            vc.setImage = self.modalfullmenu?[indexPath.row].image ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        _ = indexPath.row
        if status == 1 {
            
            if collectionView == collViewMenu{
                isselectedoffer = indexPath.row
                
                collViewMenu.reloadData()
            }
            //valueSelect = true
            if let id = offer?[indexPath.row].menuID,let offerId = offer?[indexPath.row].offerID{
                self.discount = offer?[indexPath.row].percentage ?? 0
             // if Store.screenType == 1 {
                   menuProductAPI(id: id,index: indexPath.row,isfifty: offer?[indexPath.row].is_fifty ?? 0,offerID: offerId)
              // }else {
              //     menuProductForBarAPI(id: id,index: indexPath.row,isfifty: offer?[indexPath.row].is_fifty ?? 0,offerID: offerId)
            // }
                
            }
            self.slottime = offer?[indexPath.row].offer ?? ""
            self.slotid = offer?[indexPath.row].id ?? 0
            self.menuid = offer?[indexPath.row].menuID ?? 0
            self.restrorant_bar_id = offer?[indexPath.row].restrorantBarID ?? 0
            self.offerID = offer?[indexPath.row].offerID ?? 0
            
        } else if status == 2 {
            if collectionView == collViewMenu{
                isselectedoffer = indexPath.row
                collViewMenu.reloadData()
            }
            //valueSelect = true
            
            if let id = offer?[indexPath.row].menuID,let offerId = offer?[indexPath.row].offerID{
                self.discount = offer?[indexPath.row].percentage ?? 0
              // if Store.screenType == 1 {
                   menuProductAPI(id: id,index: indexPath.row,isfifty: offer?[indexPath.row].is_fifty ?? 0,offerID: offerId)
              // }else {
                //   menuProductForBarAPI(id: id,index: indexPath.row,isfifty: offer?[indexPath.row].is_fifty ?? 0,offerID: offerId)
              // }
            }
            self.slottime = offer?[indexPath.row].offer ?? ""
            self.slotid = offer?[indexPath.row].id ?? 0
            self.menuid = offer?[indexPath.row].menuID ?? 0
            self.restrorant_bar_id = offer?[indexPath.row].restrorantBarID ?? 0
          //  self.numberofperson = offer?[indexPath.row].slotsleft ?? 0
            self.offerID = offer?[indexPath.row].offerID ?? 0

        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if self.modalfullmenu?.count == 0 {
                self.viewFCHeight.constant = 260
               // self.ImgViewgifReview.image = UIImage.gif(name: "nodataFound")
               // self.ImgViewgifReview.isHidden = false
            }else{
               // self.ImgViewgifReview.isHidden = true
                self.viewFCHeight.constant = self.viewFullMenu.contentSize.height
            }
            //self.collViewMenuHeight.constant  = self.collViewMenu.contentSize.height
        }
    }
}
extension ItemDetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbMenu {
            if arrCheck[section] == false {
                return 0
            } else {
                return products?.count ?? 0
            }
        } else {
            if reviews?.count == 0{
                tbReview.setNoDataMessage("No review found", txtColor: .black)
                //ImgViewgifReview.image = UIImage.gif(name: "nodataFound")
               // ImgViewgifReview.isHidden = false
            }else{
                tbReview.backgroundView = nil
               // ImgViewgifReview.isHidden = true
                return reviews?.count ?? 0
            }
        }
        return 0
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if tableView == tbReview{
//            return reviews?.count ?? 0
//        }  else{
//            return  0
//        }
//    }
    
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tbMenu{
            let sectionV1 = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50) )
            sectionV1.backgroundColor = UIColor.clear
            let sectionV = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40) )
            sectionV.layer.cornerRadius = 10
            let titleLbl = UILabel.init(frame: CGRect(x: 12, y: 10, width: tableView.frame.width-50, height: 20) )
            titleLbl.numberOfLines = 0
            if status == 1{
                titleLbl.text = "Recommended \(products?[section].menuTypeName ?? "") Special"
            }else{
                titleLbl.text = products?[section].menuTypeName ?? ""
            }
           
//            \n\(self.promotionTxt)"
            titleLbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
            let viewAllBtn = UIButton.init(frame: CGRect(x: tableView.frame.width-30, y: 6, width: 30, height: 30))
            viewAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            if arrCheck[section] == true {
                sectionV.backgroundColor = .systemGray5
                viewAllBtn.setImage(UIImage(named: "arrowIcon"), for: .normal)
            }else{
                sectionV.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
                viewAllBtn.setImage(UIImage(named: "arrowDefault"), for: .normal)
            }
            viewAllBtn.setTitleColor(.black, for: .normal)
            viewAllBtn.tag = section
            viewAllBtn.addTarget(self, action: #selector(isHidden), for: .touchUpInside)
            viewAllBtn.tag = section
            sectionV.addSubview(titleLbl)
            sectionV.addSubview(viewAllBtn)
            sectionV.bringSubviewToFront(viewAllBtn)
            sectionV1.addSubview(sectionV)
            return sectionV1
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tbMenu{
            return 50
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbMenu{
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellMenuTV, for: indexPath) as! CellMenuTV
           // let arrSection = products?[indexPath.section]
            let imageIndex = (productImgURL) + (products?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
           
            
            
            if status == 1 {
                cell.desLbl.text = ""
                cell.itemNameTop.constant = 5
                cell.lblItemName.text = products?[indexPath.row].productName ?? ""
                cell.lblNewPrice.text = "R\(calCulateDiscount(actualPrice: Double(products?[indexPath.row].price ?? 0), discount: Double(products?[indexPath.row].offerPercentage ?? 0)).description)"
                cell.lblDiscount.text = "\(products?[indexPath.row].offerPercentage ?? 0)% Discount"
                cell.lblPrePrice.text = "R\(products?[indexPath.row].price ?? 0)"
            } else {
                if products?[indexPath.row].discounted_price == 0 || products?[indexPath.row].actual_price == 0 {
                    cell.lblNewPrice.text = ""
                    cell.lblPrePrice.text = ""
                    cell.itemNameTop.constant = 14
                    cell.lblItemName.text = (products?[indexPath.row].productName ?? "")
                    cell.desLbl.text =  "" /*(self.offerDescription)*/
                    
                } else {
                    cell.desLbl.text = ""
                    cell.itemNameTop.constant = 5
                    cell.lblItemName.text = products?[indexPath.row].productName ?? ""
                    cell.lblPrePrice.text = "R\(products?[indexPath.row].actual_price ?? 0)"
                    cell.lblNewPrice.text = "R\(products?[indexPath.row].discounted_price ?? 0)"
                }
                cell.lblDiscount.text = ""
                cell.lblDiscount.isHidden = true
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellItemDetailReviewTB, for: indexPath) as! CellItemDetailReviewTB
            let imageIndex = (imageURL) + (self.reviews?[indexPath.row].user?.image?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            cell.lblName.text = self.reviews?[indexPath.row].user?.name ?? ""
            cell.lblReview.text = self.reviews?[indexPath.row].review ?? ""
            cell.cosmosView.rating = Double(self.reviews?[indexPath.row].rating ?? "") ?? 0.0
            cell.lblDate.text = string_date_ToDate(reviews?[indexPath.row].createdAt ?? "", currentFormat: .BackEndFormat, requiredFormat: .mon_dd_yyyy)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if self.reviews?.count == 0{
                self.heightTBReview.constant = 220
               // self.imgViewGifReview.image = UIImage.gif(name: "nodataFound")
               // self.imgViewGifReview.isHidden = false
            } else {
                //self.imgViewGifReview.isHidden = true
                self.heightTBReview.constant = self.tbReview.contentSize.height
            }
            
            self.heightTBMenu.constant = self.tbMenu.contentSize.height
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tbMenu{
            let vc = storyboard?.instantiateViewController(withIdentifier: "fullImageView") as! fullImageView
            vc.settype = 2
            vc.setImage = products?[indexPath.row].image ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                heightTBMenu.constant = newsize.height
            }
        }
    }
}

//MARK: InitialLoad Fnction
extension ItemDetailsVC{
    func initialLoad(){
        viewMenu.layer.cornerRadius = viewAbout.frame.height / 2
        viewMenu.layer.maskedCorners = [.layerMaxXMinYCorner]
        viewAbout.cornerRadius(cornerRadius: 30)
        viewReview.layer.cornerRadius = viewReview.frame.height / 2
        viewReview.layer.maskedCorners = [.layerMinXMinYCorner]
        imgBottomView.layer.cornerRadius = 30.0
        imgBottomView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
        viewFullMeny.layer.cornerRadius = 30
        viewFullMeny.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
        lblFullMenu.lblCornerRadius(cornerRadius: 15.0)
        lblMenu.lblCornerRadius(cornerRadius: 15.0)
        lblAbout.lblCornerRadius(cornerRadius: 15.0)
        lblReview.lblCornerRadius(cornerRadius: 15.0)
        btnFav.layer.cornerRadius = btnFav.frame.height / 2
        viewA.isHidden = true
        viewM.isHidden = false
        viewR.isHidden = true
        viewFM.isHidden = true
        viewButton.isHidden = true
        ChangebgColor(viewSelected: viewMenu, viewUnselected: viewAbout, viewUnselected2: viewReview,ViewUnselected3: viewFullMenu, labelSelected: lblMenu, labelUnselected: lblAbout, labelUnselecte2: lblReview,lblUnselected3: lblFullMenu)
        
        //MARK: Menu Offer Arr
        if status == 0 {
            let collDineData : [ModelMenuCollView] = [ModelMenuCollView(name: ["Breakfast" , "Lunch" , "Dinner" , "Special"], time: ["08:00 to 10:00" , "13:00 to 13:30" , "19:00 to 20:00" , "13:00 to 13:30"])]
            arrCollMenu.removeAll()
            arrCollMenu.append(contentsOf: collDineData)
        }else{
            let collDrinkData : [ModelMenuCollView] = [ModelMenuCollView(name: ["Tonight" , "Happy Hour" ,                                           "Today" , "Tommorow"],
                                                                         time: ["08:00 to 10:00" , "13:00 to 13:30" , "19:00 to 20:00" , "13:00 to 13:30"])]
            arrCollMenu.removeAll()
            arrCollMenu.append(contentsOf: collDrinkData)
        }
    }
    func ChangebgColor(viewSelected : UIView , viewUnselected : UIView, viewUnselected2: UIView ,ViewUnselected3:UIView, labelSelected : UILabel , labelUnselected : UILabel , labelUnselecte2 : UILabel, lblUnselected3:UILabel){
        viewSelected.backgroundColor = UIColor.systemGray5
        viewUnselected.backgroundColor = UIColor.white
        viewUnselected2.backgroundColor = UIColor.white
        ViewUnselected3.backgroundColor = UIColor.white
        labelSelected.backgroundColor = UIColor.white
        labelUnselected.backgroundColor = UIColor.systemGray5
        labelUnselecte2.backgroundColor = UIColor.systemGray5
        lblUnselected3.backgroundColor = UIColor.systemGray5
    }
}

//MARK: Objective function
extension ItemDetailsVC{
    @objc func isHidden(sender : UIButton){
        debugPrint(sender.tag)
//        switch sender.tag {
//        case 0 :
            if sender.isSelected  == false{
                if arrCheck[sender.tag] == true{
                    arrCheck[sender.tag] = false
                    debugPrint(arrCheck)
                    debugPrint(sender.tag)
                    sender.isSelected = false
                    sender.setImage(UIImage(named: "aarrowIcon"), for: .selected)
                }else{
                    arrCheck[sender.tag] = true
                    debugPrint(arrCheck)
                    debugPrint(sender.tag)
                    sender.isSelected = true
                    sender.setImage(UIImage(named: "arrowDefault"), for: .selected)
                }
            }
            debugPrint("Case 0")
//        case 1 :
//            if sender.isSelected  == false{
//                if arrCheck[sender.tag] == false{
//                    arrCheck[sender.tag] = true
//                    sender.isSelected = true
//                }else{
//                    arrCheck[sender.tag] = false
//                    sender.isSelected = false
//                }
//            }
//            debugPrint("Case 1")
//        case 2 :
//            if sender.isSelected  == false{
//                if arrCheck[sender.tag] == false{
//                    arrCheck[sender.tag] = true
//                    sender.isSelected = true
//                }else{
//                    arrCheck[sender.tag] = false
//                    sender.isSelected = false
//                }
//            }
//            debugPrint("Case 2")
//        case 3 :
//            if sender.isSelected  == false{
//                if arrCheck[sender.tag] == false{
//                    arrCheck[sender.tag] = true
//                    sender.isSelected = true
//                }else{
//                    arrCheck[sender.tag] = false
//                    sender.isSelected = false
//                }
//            }
//            debugPrint("Case 3")
            
//        default:
//            debugPrint("Is Hideen default run")
//        }
        tbMenu.reloadData()
    }
    
}


extension ItemDetailsVC : CLLocationManagerDelegate{
    func getUpdatedLocation() {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            //   locationManager.distanceFilter = 100.0
            if #available(iOS 14.0, *) {
                locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            } else {
                // Fallback on earlier versions0000
            }
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lat = locValue.latitude
        self.long = locValue.longitude
        let distance =  distanceBetween(lat1: locValue.latitude, lon1: locValue.longitude, lat2: Double(self.modal?.latitude ?? "") ?? 0, lon2: Double(self.modal?.longitude ?? "") ?? 0)
        let miles = "\(String(format:"%.1f",distance)) Km"
        self.lblHeading.text = "Location " + "\(miles)"
       // "\(self.modal?.location ?? "") \n\(miles)"
        locationManager.stopUpdatingLocation()
    }
    
    
}

func calCulateDiscount (actualPrice: Double,discount: Double) -> Int {
    let result = (actualPrice * discount) / 100
    //(actualPrice / 100) * discount
    let finalAmount = actualPrice - result
    print("oferr data----------",actualPrice,discount,finalAmount)
    return Int(finalAmount)
}

func degreesToRadians(_ degrees: Double) -> Double {
    return degrees * .pi / 180.0
}

func distanceBetween(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
    let earthRadius = 6371.0 // Radius of the Earth in kilometers

    let dLat = degreesToRadians(lat2 - lat1)
    let dLon = degreesToRadians(lon2 - lon1)

    let a = sin(dLat/2) * sin(dLat/2) + cos(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) * sin(dLon/2) * sin(dLon/2)
    let c = 2 * atan2(sqrt(a), sqrt(1-a))

    let distanceInKilometers = earthRadius * c
    let distanceInMiles = distanceInKilometers * 0.621371 // Convert to miles

    return distanceInMiles
}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}


