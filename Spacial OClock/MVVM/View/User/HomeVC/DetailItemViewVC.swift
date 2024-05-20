//
//  DetailItemViewVC.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit
import SDWebImage
import SwiftGifOrigin
import SkeletonView

class DetailItemViewVC: UIViewController , SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {

    //MARK: Outlets
    @IBOutlet weak var txtFldSearch: CustomTextField!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var imgViewHead: UIImageView!
    @IBOutlet weak var clubVw: UIView!
    @IBOutlet weak var clubBgImgVw: UIImageView!
    @IBOutlet weak var barVw: UIView!
    @IBOutlet weak var barBgImgVw: UIImageView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var barlbl: UILabel!
    
    //MARK: Variables
    var country = String()
    var city = String()
    var iconImage = String()
    var heading = String()
    var cusinessID = Int()
    var themeID = Int()
    var location : [locationByRestoModalBody]?
    var filterlocations : [locationByRestoModalBody]?
    var cuisine = [Cuisine]()
    var viewmodal = HomeViewModel()
    var modal: [CussinesRestoModalBody]?
    var filtercusin : [CussinesRestoModalBody]?
    var thememodla : [themeRestolistModalBody]?
    var filtertheme : [themeRestolistModalBody]?
    var categoryModal : [CategoryByRModalBody]?
    var filterCategory : [CategoryByRModalBody]?
    var tempHighilyRatedBarsRestos : [AllBarsResto]?
    var highilyRatedBarsRestos : [AllBarsResto]?
    var filterHighilyRatedBarsRestos : [AllBarsResto]?
    var tempAllBarsRestos : [AllBarsResto]?
    var allBarsRestos : [AllBarsResto]?
    var filterAllBarsRestos : [AllBarsResto]?
    
    var lblName = ""
    var setimage = ""
    var setValue = ""
    var all_bars_restos = [AllBarsResto]()
    var type = 1
    var disableDatesArr : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        clubVw.isHidden = Store.screenType == 1 ? true : false
        barVw.isHidden = Store.screenType == 1 ? true : false
        txtFldSearch.delegate = self
        self.type = Store.screenType ?? 1
        lblTwo.text = lblName
        lblOne.text = "\(setValue)> "
        lblHeader.text = setValue
        imgViewHead.image = UIImage(named: setimage)
        if setValue == "Location" {
            CollectionView.showAnimatedGradientSkeleton()
            location_By_RestoAPI(type: (Store.screenType ?? 1))
        } else if setValue == "Cuisines" {
            CollectionView.showAnimatedGradientSkeleton()
            get_resto_list(type: (Store.screenType ?? 1))
        } else if setValue == "Category" {
            CollectionView.showAnimatedGradientSkeleton()
            fetch_Category_REsto(type: (Store.screenType ?? 1))
        } else if setValue == "Theme" {
            CollectionView.showAnimatedGradientSkeleton()
            theme_Resto_API(type: (Store.screenType ?? 1))
        } else if setValue == "Popular" || setValue == "Popular Bar" || setValue == "Popular Club"{
            if Store.screenType != 1 {
                tempHighilyRatedBarsRestos = highilyRatedBarsRestos
                let clubData = highilyRatedBarsRestos?.filter({$0.type == 2})
                highilyRatedBarsRestos = clubData
                filterHighilyRatedBarsRestos = clubData
                self.CollectionView.reloadData()
            }
            
        } else if setValue == "A-Z" || setValue == "A-Z Bar" || setValue == "A-Z Club"{
            if Store.screenType != 1 {
                tempAllBarsRestos = allBarsRestos
                let clubData = allBarsRestos?.filter({$0.type == 2})
                allBarsRestos = clubData
                filterAllBarsRestos = clubData
                self.CollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden  = true
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClubSelect(_ sender: Any) {
        CollectionView.backgroundView = nil
        clubLbl.textColor = .black
        barlbl.textColor = .darkGray
        clubBgImgVw.image = UIImage(named: "newSelectedClub")
        barBgImgVw.image = UIImage(named: "newUnSelectedBar")
        if setValue == "Location" {
            CollectionView.showAnimatedGradientSkeleton()
            location_By_RestoAPI(type: 2)
        } else if setValue == "Cuisines" {
            CollectionView.showAnimatedGradientSkeleton()
            get_resto_list(type: 2)
        } else if setValue == "Category" {
            CollectionView.showAnimatedGradientSkeleton()
            fetch_Category_REsto(type: 2)
        } else if setValue == "Theme" {
            CollectionView.showAnimatedGradientSkeleton()
            theme_Resto_API(type: 2)
        } else if setValue == "Popular" || setValue == "Popular Bar" || setValue == "Popular Club"{
            highilyRatedBarsRestos = tempHighilyRatedBarsRestos
            let clubData = highilyRatedBarsRestos?.filter({$0.type == 2})
            highilyRatedBarsRestos = clubData
            filterHighilyRatedBarsRestos = clubData
            self.CollectionView.reloadData()
        } else if setValue == "A-Z" || setValue == "A-Z Bar" || setValue == "A-Z Club"{
            allBarsRestos = tempAllBarsRestos
            let clubData = allBarsRestos?.filter({$0.type == 2})
            allBarsRestos = clubData
            filterAllBarsRestos = clubData
            self.CollectionView.reloadData()
        }
    }
    
    @IBAction func btnBarSelect(_ sender: Any) {
        CollectionView.backgroundView = nil
        barlbl.textColor = .black
        clubLbl.textColor = .darkGray
        clubBgImgVw.image = UIImage(named: "newUnSelectedClub")
        barBgImgVw.image = UIImage(named: "newSelectedBar")
        if setValue == "Location" {
            CollectionView.showAnimatedGradientSkeleton()
            location_By_RestoAPI(type: 3)
        } else if setValue == "Cuisines" {
            CollectionView.showAnimatedGradientSkeleton()
            get_resto_list(type: 3)
        } else if setValue == "Category" {
            CollectionView.showAnimatedGradientSkeleton()
            fetch_Category_REsto(type: 3)
        } else if setValue == "Theme" {
            CollectionView.showAnimatedGradientSkeleton()
            theme_Resto_API(type: 3)
        } else if setValue == "Popular" || setValue == "Popular Bar" || setValue == "Popular Club"{
            highilyRatedBarsRestos = tempHighilyRatedBarsRestos
            let clubData = highilyRatedBarsRestos?.filter({$0.type == 3})
            highilyRatedBarsRestos = clubData
            filterHighilyRatedBarsRestos = clubData
            self.CollectionView.reloadData()
        } else if setValue == "A-Z" || setValue == "A-Z Bar" || setValue == "A-Z Club"{
            allBarsRestos = tempAllBarsRestos
            let clubData = allBarsRestos?.filter({$0.type == 3})
            allBarsRestos = clubData
            filterAllBarsRestos = clubData
            self.CollectionView.reloadData()
        }
    }
    
    //MARK: - CUSINS BY RESTO
    func get_resto_list(type:Int){
        viewmodal.cusinsRestoAPI(cuisineid: cusinessID,country: country, city: city,type: type) { [weak self] fetchdata in
            var objModel = fetchdata ?? []
            for i in 0 ..< (objModel.count ) {
                var obj = objModel[i]
                obj.timeSlots?.reverse()
                objModel[i] = obj
            }
            self?.modal = objModel.filter({$0.offerAvailable == 1})
            self?.filtercusin = objModel.filter({$0.offerAvailable == 1})
                self?.CollectionView.hideSkeleton()
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - THEME BY RESTO
    func theme_Resto_API(type:Int) {
        viewmodal.restoThemelistAPI(restoid: themeID, type: type,country: country,city: city) { [weak self] dataa in
            self?.thememodla = dataa?.filter({$0.offerAvailable == 1})
            self?.filtertheme = dataa?.filter({$0.offerAvailable == 1})
                self?.CollectionView.hideSkeleton()
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - CATEGORY BY GET RESTO LIST API
    func fetch_Category_REsto(type:Int){
        viewmodal.categoryBYResto(categoryID: cusinessID,country: country,city: city,type: type) { [weak self] dataaa in
            self?.categoryModal = dataaa?.filter({$0.offerAvailable == 1})
            self?.filterCategory = dataaa?.filter({$0.offerAvailable == 1})
                self?.CollectionView.hideSkeleton()
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - Blur ImageView
    
    //MARK: - LOCATION BY RESTO
    func location_By_RestoAPI(type:Int) {
        viewmodal.locationByRestoAPI(country: country, city: city,type: type) { [weak self] dataa in
            
            var objModel = dataa ?? []
            for i in 0 ..< (objModel.count ) {
                var obj = objModel[i]
                obj.timeSlots?.reverse()
                objModel[i] = obj
            }
            
            
            self?.location = objModel.filter({$0.offerAvailable == 1})
            self?.filterlocations = objModel.filter({$0.offerAvailable == 1})
                self?.CollectionView.hideSkeleton()
                self?.CollectionView.reloadData()
            
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "DetailItemCVC"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}
//MARK: - EXTENTION
extension DetailItemViewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setValue == "Location" {
            if filterlocations?.count == 0 {
                collectionView.setNoDataMessage("No data found")
            } else {
                collectionView.backgroundView = nil
                return filterlocations?.count ?? 0
            }
        } else if setValue == "Category" {
            if filterCategory?.count == 0 {
                collectionView.setNoDataMessage("No data found")
            } else {
                collectionView.backgroundView = nil
                return filterCategory?.count ?? 0
            }
        }
        else if setValue == "Cuisines" {
            if filtercusin?.count == 0 {
                collectionView.setNoDataMessage("No data found")
            } else {
                collectionView.backgroundView = nil
                return filtercusin?.count ?? 0
            }
            
        } else if setValue == "Popular" || setValue == "Popular Bar" || setValue == "Popular Club"{
            if filterHighilyRatedBarsRestos?.count == 0 {
                collectionView.setNoDataMessage("No data found")
            } else {
                collectionView.backgroundView = nil
                return filterHighilyRatedBarsRestos?.count ?? 0
            }
        }else if setValue == "A-Z" || setValue == "A-Z Bar" || setValue == "A-Z Club" {
            if filterAllBarsRestos?.count == 0 {
                collectionView.setNoDataMessage("No data found")
            } else {
                collectionView.backgroundView = nil
                return filterAllBarsRestos?.count ?? 0
            }
        } else {
            if filtertheme?.count == 0 {
                collectionView.setNoDataMessage("No data found")
            } else {
                collectionView.backgroundView = nil
                return filtertheme?.count ?? 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailItemCVC", for: indexPath) as! DetailItemCVC
        if setValue == "Location" {
            let imageIndex = (imageURL) + (filterlocations?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            
            cell.callBack = { [weak self] ID in
                
                print(ID)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = self?.filterlocations?[indexPath.row].id ?? 0
                vc.selectedOfferId = ID
                vc.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            if let disable_dates = filterlocations?[indexPath.row].disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString){
                    blurEffect(image: cell.imgView)
                    cell.whiteBlurVw.isHidden = false
                    cell.closeDateVw.isHidden = false
                    if checkDatesAreInSequence(array: disableDatesArr){
                        cell.lblcloseDate.text = "Closed until \(formatDate(inputDate: disableDatesArr.last ?? "") ?? "")"
                    }else {
                        cell.lblcloseDate.text = "Closed today"
                    }
                } else {
                    cell.whiteBlurVw.isHidden = true
                    cell.closeDateVw.isHidden = true
                }
                
            } else {
                //if isRestaurantClosed(now: Date(), openingTime: filterlocations?[indexPath.row].openTime ?? "", closingTime: filterlocations?[indexPath.row].closeTime ?? "") {}else{}
                cell.whiteBlurVw.isHidden = true
                cell.closeDateVw.isHidden = true
            }
            cell.lblRaitingCount.text = "(\(filterlocations?[indexPath.row].ratingCount?.description ?? "0"))"
            cell.lblName.text = filterlocations?[indexPath.row].name?.capitalized ?? ""
            cell.lblLocation.text = filterlocations?[indexPath.row].location ?? ""
            cell.lblfirstLocaton.text = filterlocations?[indexPath.row].city ?? ""
            cell.lblDiscription.text = "\(filterlocations?[indexPath.row].openTime ?? "") - \(filterlocations?[indexPath.row].closeTime ?? "")"
            //filterlocations?[indexPath.row].shortDescription ?? ""
            let fetchresto = filterlocations?[indexPath.row].timeSlots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""}) ?? []
            cell.lblRaiting.text = "\(filterlocations?[indexPath.row].avgRating ?? 0)"
            cell.cosmosView.rating = Double(filterlocations?[indexPath.row].avgRating ?? 0)
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerTimings = filterlocations?[indexPath.row].type == 1 ? fetchresto : fetchresto.unique(map: {$0.offerID})
            cell.offerCollection.reloadData()
        } else if setValue == "Category" {
            let imageIndex = (imageURL) + (filterCategory?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            cell.lblfirstLocaton.text = filterCategory?[indexPath.row].city ?? ""
            cell.lblLocation.text = filterCategory?[indexPath.row].location ?? ""
            cell.lblName.text = filterCategory?[indexPath.row].name?.capitalized ?? ""
            cell.lblDiscription.text = "\(filterCategory?[indexPath.row].openTime ?? "") - " + "\(filterCategory?[indexPath.row].closeTime ?? "")"
            cell.lblRaitingCount.text = "(\(filterCategory?[indexPath.row].ratingCount?.description ?? "0"))"
           // let fetchresto = Store.screenType == 1 ? filterCategory?[indexPath.row].offers ?? [] : filterCategory?[indexPath.row].offers?.unique(map: {$0.offer?.id ?? 0}) ?? []
            let fetchresto = filterCategory?[indexPath.row].offers?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""}) ?? []
            cell.offerTimings = filterCategory?[indexPath.row].type == 1 ? fetchresto : fetchresto.unique(map: {$0.offerID})
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerCollection.reloadData()
            cell.lblRaiting.text = "\(filterCategory?[indexPath.row].avgrating ?? 0)"
            cell.cosmosView.rating = Double(filterCategory?[indexPath.row].avgrating ?? 0)
            
            cell.callBack = { [weak self] ID in
                
                print(ID)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = self?.filterCategory?[indexPath.row].id ?? 0
                vc.selectedOfferId = ID
                vc.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            
            if let disable_dates = filterCategory?[indexPath.row].disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString){
                   blurEffect(image: cell.imgView)
                    cell.whiteBlurVw.isHidden = false
                    cell.closeDateVw.isHidden = false
                    if checkDatesAreInSequence(array: disableDatesArr){
                        cell.lblcloseDate.text = "Closed until \(formatDate(inputDate: disableDatesArr.last ?? "") ?? "")"
                    }else {
                        cell.lblcloseDate.text = "Closed today"
                    }
                } else {
                    cell.whiteBlurVw.isHidden = true
                    cell.closeDateVw.isHidden = true
                }
                
            }else {
                cell.whiteBlurVw.isHidden = true
                cell.closeDateVw.isHidden = true
            }
            
            
        } else if setValue == "Cuisines" {
            let imageIndex = (imageURL) + (filtercusin?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            cell.lblfirstLocaton.text = filtercusin?[indexPath.row].city ?? ""
            cell.lblLocation.text = filtercusin?[indexPath.row].location ?? ""
            cell.lblName.text = filtercusin?[indexPath.row].name?.capitalized ?? ""
            cell.lblDiscription.text = "\(filtercusin?[indexPath.row].openTime ?? "") - " + "\(filtercusin?[indexPath.row].closeTime ?? "")"
            cell.lblRaiting.text = "\(filtercusin?[indexPath.row].avgRating ?? 0)"
            cell.lblRaitingCount.text = "(\(filtercusin?[indexPath.row].ratingCount?.description ?? "0"))"
            cell.cosmosView.rating = Double(filtercusin?[indexPath.row].avgRating ?? 0)
            let fetchresto = filtercusin?[indexPath.row].timeSlots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""}) ?? []
            cell.offerTimings = filtercusin?[indexPath.row].type == 1 ? fetchresto : fetchresto.unique(map: {$0.offerID})
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerCollection.reloadData()
            //MARK: For showing pre-selected offer.
            cell.callBack = { [weak self] ID in
                
                print(ID)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = self?.filtercusin?[indexPath.row].id ?? 0
                vc.selectedOfferId = ID
                vc.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            if let disable_dates = filtercusin?[indexPath.row].disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString) {
                   blurEffect(image: cell.imgView)
                    cell.whiteBlurVw.isHidden = false
                    cell.closeDateVw.isHidden = false
                    if checkDatesAreInSequence(array: disableDatesArr){
                        cell.lblcloseDate.text = "Closed until \(formatDate(inputDate: disableDatesArr.last ?? "") ?? "")"
                    }else {
                        cell.lblcloseDate.text = "Closed today"
                    }
                } else {
                    cell.whiteBlurVw.isHidden = true
                    cell.closeDateVw.isHidden = true
                }
                
            }else {
                cell.whiteBlurVw.isHidden = true
                cell.closeDateVw.isHidden = true
            }

            
            
        }
        else if setValue == "Popular" || setValue == "Popular Bar" || setValue == "Popular Club"{
            let data = filterHighilyRatedBarsRestos?[indexPath.row]
            let imageIndex = (imageURL) + (data?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            cell.lblfirstLocaton.text = data?.city ?? ""
            cell.lblLocation.text = data?.location ?? ""
            cell.lblName.text = data?.name?.capitalized ?? ""
            cell.lblDiscription.text = "\(data?.openTime ?? "") - " + "\(data?.closeTime ?? "")"
            cell.lblRaiting.text = "\(data?.avgRating ?? 0)"
            cell.cosmosView.rating = Double(data?.avgRating ?? 0)
            let fetchresto = data?.time_slots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""}) ?? []
          //  cell.lblRaitingCount.text = "(\(data?.ratingCount?.description ?? "0"))"
            
            cell.offerTimings = data?.type == 1 ? fetchresto : fetchresto.unique(map: {$0.offerID})
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerCollection.reloadData()
            cell.callBack = { [weak self] ID in

                print(ID)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = data?.id ?? 0
                vc.selectedOfferId = ID
                vc.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(vc, animated: true)
            }

            if let disable_dates = data?.disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString){
                    blurEffect(image: cell.imgView)
                    cell.whiteBlurVw.isHidden = false
                    cell.closeDateVw.isHidden = false
                    if checkDatesAreInSequence(array: disableDatesArr){
                        cell.lblcloseDate.text = "Closed until \(formatDate(inputDate: disableDatesArr.last ?? "") ?? "")"
                    }else {
                        cell.lblcloseDate.text = "Closed today"
                    }
                } else {
                    cell.whiteBlurVw.isHidden = true
                    cell.closeDateVw.isHidden = true
                }

            }else {
                cell.whiteBlurVw.isHidden = true
                cell.closeDateVw.isHidden = true
            }

        }
        else if setValue == "A-Z" || setValue == "A-Z Bar" || setValue == "A-Z Club" {
            let data = filterAllBarsRestos?[indexPath.row]
            let imageIndex = (imageURL) + (data?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            cell.lblfirstLocaton.text = data?.city ?? ""
            cell.lblLocation.text = data?.location ?? ""
            cell.lblName.text = data?.name?.capitalized ?? ""
            cell.lblDiscription.text = "\(data?.openTime ?? "") - " + "\(data?.closeTime ?? "")"
            cell.lblRaiting.text = "\(data?.avgRating ?? 0)"
            cell.cosmosView.rating = Double(data?.avgRating ?? 0)
            let fetchresto = data?.time_slots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""}) ?? []
          //  cell.lblRaitingCount.text = "(\(data?.ratingCount?.description ?? "0"))"
            cell.offerTimings = data?.type == 1 ?  fetchresto : fetchresto.unique(map: {$0.offerID})
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerCollection.reloadData()
            cell.callBack = { [weak self] ID in

                print(ID)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = data?.id ?? 0
                vc.selectedOfferId = ID
                vc.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(vc, animated: true)
            }

            if let disable_dates = data?.disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString){
                    blurEffect(image: cell.imgView)
                    cell.whiteBlurVw.isHidden = false
                    cell.closeDateVw.isHidden = false
                    if checkDatesAreInSequence(array: disableDatesArr){
                        cell.lblcloseDate.text = "Closed until \(formatDate(inputDate: disableDatesArr.last ?? "") ?? "")"
                    }else {
                        cell.lblcloseDate.text = "Closed today"
                    }
                } else {
                    cell.whiteBlurVw.isHidden = true
                    cell.closeDateVw.isHidden = true
                }

            }else {
                cell.whiteBlurVw.isHidden = true
                cell.closeDateVw.isHidden = true
            }

        }
        else {
            let imageIndex = (imageURL) + (filtertheme?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            cell.lblfirstLocaton.text = filtertheme?[indexPath.row].city ?? ""
            cell.lblLocation.text = filtertheme?[indexPath.row].location ?? ""
            cell.lblName.text = filtertheme?[indexPath.row].name?.capitalized ?? ""
            cell.lblDiscription.text = "\(filtertheme?[indexPath.row].openTime ?? "") - " + "\(filtertheme?[indexPath.row].closeTime ?? "")"
            cell.lblRaiting.text = "\(filtertheme?[indexPath.row].avgRating ?? 0)"
            cell.cosmosView.rating = Double(filtertheme?[indexPath.row].avgRating ?? 0)
            let fetchresto = filtertheme?[indexPath.row].timeSlots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""}) ?? []
            cell.lblRaitingCount.text = "(\(filtertheme?[indexPath.row].ratingCount?.description ?? "0"))"
            cell.offerTimings = filtertheme?[indexPath.row].type == 1 ? fetchresto : fetchresto.unique(map: {$0.offerID})
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerCollection.reloadData()
            cell.callBack = { [weak self] ID in
                
                print(ID)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = self?.filtertheme?[indexPath.row].id ?? 0
                vc.selectedOfferId = ID
                vc.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            if let disable_dates = filtertheme?[indexPath.row].disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString){
                    blurEffect(image: cell.imgView)
                    cell.whiteBlurVw.isHidden = false
                    cell.closeDateVw.isHidden = false
                    if checkDatesAreInSequence(array: disableDatesArr){
                        cell.lblcloseDate.text = "Closed until \(formatDate(inputDate: disableDatesArr.last ?? "") ?? "")"
                    }else {
                        cell.lblcloseDate.text = "Closed today"
                    }
                } else {
                    cell.whiteBlurVw.isHidden = true
                    cell.closeDateVw.isHidden = true
                }
                
            }else {
                cell.whiteBlurVw.isHidden = true
                cell.closeDateVw.isHidden = true
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: collectionView.frame.width, height: 260)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as? ItemDetailsVC else { return }
        if setValue == "Location" {
            vc.ProductID = filterlocations?[indexPath.row].id ?? 0
        } else if setValue == "Category" {
            vc.ProductID = filterCategory?[indexPath.row].id ?? 0
        } else if setValue == "Cuisines" {
            vc.ProductID = filtercusin?[indexPath.row].id ?? 0
        } else if setValue == "Popular" || setValue == "Popular Bar" || setValue == "Popular Club"{
            vc.ProductID = filterHighilyRatedBarsRestos?[indexPath.row].id ?? 0
        } else if setValue == "A-Z" || setValue == "A-Z Bar" || setValue == "A-Z Club"{
            vc.ProductID = filterAllBarsRestos?[indexPath.row].id ?? 0
        } else {
            vc.ProductID = filtertheme?[indexPath.row].id ?? 0
        }
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DetailItemViewVC : UITextFieldDelegate {
    //MARK: - Search
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultString = txtFldSearch.text ?? ""
        if (resultString.count) > 1{
            if let searchText = txtFldSearch.text {
                filterAllBarsRestos = allBarsRestos?.filter({$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()})
                filterHighilyRatedBarsRestos = highilyRatedBarsRestos?.filter({$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()})
                filtercusin = modal?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                filterCategory = categoryModal?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                filterlocations = location?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                filtertheme = thememodla?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
            }
        } else {
            filterAllBarsRestos = allBarsRestos
            filterHighilyRatedBarsRestos = highilyRatedBarsRestos
            filtercusin = modal
            filterCategory = categoryModal
            filterlocations = location
            filtertheme = thememodla
        }
        CollectionView.reloadData()
        return true
    }
}

func blurEffect(image: UIImageView) {
    let context = CIContext(options: nil)
    let currentFilter = CIFilter(name: "CIGaussianBlur")
    let beginImage = CIImage(image: image.image!)
    currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
    currentFilter!.setValue(10, forKey: kCIInputRadiusKey)

    let cropFilter = CIFilter(name: "CICrop")
    cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
    cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

    let output = cropFilter!.outputImage
    let cgimg = context.createCGImage(output!, from: output!.extent)
    let processedImage = UIImage(cgImage: cgimg!)
    image.image = processedImage
}



import Foundation

func isRestaurantClosed(now: Date, openingTime: String, closingTime: String) -> Bool {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    
    guard let openTime = formatter.date(from: openingTime),
          let closeTime = formatter.date(from: closingTime) else {
        return true // Return true if there's an issue with parsing times
    }
    
    // Convert now to hours and minutes only for comparison
    let calendar = Calendar.current
    let nowComponents = calendar.dateComponents([.hour, .minute], from: now)
    let nowHour = nowComponents.hour ?? 0
    let nowMinute = nowComponents.minute ?? 0
    
    // Construct Date objects for comparison
    let nowDate = calendar.date(bySettingHour: nowHour, minute: nowMinute, second: 0, of: now) ?? Date()
    
    // Check if the current time is within opening and closing times
    if nowDate >= openTime && nowDate <= closeTime {
        return false // Restaurant is open
    } else {
        return true // Restaurant is closed
    }
}



