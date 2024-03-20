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

//MARK: Variable image3
var arrModel : [ItemsModel] = []

class DetailItemViewVC: UIViewController , SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {

    
    //MARK: Outlets
    @IBOutlet weak var txtFldSearch: CustomTextField!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var imgViewHead: UIImageView!
    
    //MARK: Variables
    var context = CIContext(options: nil)
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
    var lblName = ""
    var setimage = ""
    var setValue = ""
    var all_bars_restos = [AllBarsResto]()
    var type = 1
    var disableDatesArr : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       
        txtFldSearch.delegate = self
        self.type = Store.screenType ?? 1
        //UserDefaults.standard.integer(forKey: "dineDrinkStatus")
        CollectionView.showAnimatedGradientSkeleton()
        print(cusinessID)
        lblTwo.text = lblName
        lblOne.text = "\(setValue)> "
        lblHeader.text = setValue 
        imgViewHead.image = UIImage(named: setimage)
         
        if setValue == "Location" {
            location_By_RestoAPI()
        } else if setValue == "Cuisines" {
            get_resto_list()
        } else if setValue == "Category" {
            fetch_Category_REsto()
        } else if setValue == "Theme" {
            theme_Resto_API()
        } else if setValue == "Popular"{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden  = true
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - CUSINS BY RESTO
    func get_resto_list(){
        viewmodal.cusinsRestoAPI(cuisineid: cusinessID) { [weak self] fetchdata in
            var objModel = fetchdata ?? []
            for i in 0 ..< (objModel.count ) {
                var obj = objModel[i]
                obj.timeSlots?.reverse()
                objModel[i] = obj
            }

            self?.modal = objModel
            self?.filtercusin = objModel
           // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
          //  }
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - THEME BY RESTO
    func theme_Resto_API() {
        viewmodal.restoThemelistAPI(restoid: themeID, type: type) { [weak self] dataa in
//            var objModel = dataa ?? []
//            for i in 0 ..< (objModel.count ) {
//                var obj = objModel[i]
//                obj.timeSlots?.reverse()
//                objModel[i] = obj
//            }
            
            
            self?.thememodla = dataa
            self?.filtertheme = dataa
           // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
            //}
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - CATEGORY BY GET RESTO LIST API
    func fetch_Category_REsto(){
        viewmodal.categoryBYResto(categoryID: cusinessID) { [weak self] dataaa in
            
//            var objModel = dataaa ?? []
//            for i in 0 ..< (objModel.count ) {
//                var obj = objModel[i]
//                obj.timeSlots?.reverse()
//                objModel[i] = obj
//            }
            
            
            self?.categoryModal = dataaa
            self?.filterCategory = dataaa
           // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
            //}
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - Blur ImageView
    

    func blurEffect(image: UIImageView) {

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
    
    //MARK: - LOCATION BY RESTO
    func location_By_RestoAPI() {
        viewmodal.locationByRestoAPI(country: country, city: city,type: String(Store.screenType ?? 1)) { [weak self] dataa in
            
            var objModel = dataa ?? []
            for i in 0 ..< (objModel.count ) {
                var obj = objModel[i]
                obj.timeSlots?.reverse()
                objModel[i] = obj
            }
            
            
            self?.location = objModel
            self?.filterlocations = objModel
           // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
                self?.CollectionView.reloadData()
            //}
            
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
extension DetailItemViewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setValue == "Location" {
            if filterlocations?.count == 0 {
                collectionView.setNoDataMessage("No data found")
               // imgViewGif.image = UIImage.gif(name: "nodataFound")
                //imgViewGif.isHidden = false
            } else {
                collectionView.backgroundView = nil
               // imgViewGif.isHidden = true
                return filterlocations?.count ?? 0
            }
        } else if setValue == "Category" {
            if filterCategory?.count == 0 {
                collectionView.setNoDataMessage("No data found")
//                imgViewGif.image = UIImage.gif(name: "nodataFound")
//                imgViewGif.isHidden = false
            } else {
                collectionView.backgroundView = nil
               // imgViewGif.isHidden = true
                return filterCategory?.count ?? 0
            }
        }
        else if setValue == "Cuisines" {
            if filtercusin?.count == 0 {
                collectionView.setNoDataMessage("No data found")
               // imgViewGif.image = UIImage.gif(name: "nodataFound")
                //imgViewGif.isHidden = false
            } else {
                collectionView.backgroundView = nil
               // imgViewGif.isHidden = true
                return filtercusin?.count ?? 0
            }
            
        } else {
            if filtertheme?.count == 0 {
                collectionView.setNoDataMessage("No data found")
               // imgViewGif.image = UIImage.gif(name: "nodataFound")
               // imgViewGif.isHidden = false
            } else {
                collectionView.backgroundView = nil
              //  imgViewGif.isHidden = true
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
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            if let disable_dates = filterlocations?[indexPath.row].disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString){
                    self.blurEffect(image: cell.imgView)
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
            
            cell.lblName.text = filterlocations?[indexPath.row].name?.capitalized ?? ""
            cell.lblLocation.text = filterlocations?[indexPath.row].location ?? ""
            cell.lblfirstLocaton.text = filterlocations?[indexPath.row].city ?? ""
            cell.lblDiscription.text = "\(filterlocations?[indexPath.row].openTime ?? "") - \(filterlocations?[indexPath.row].closeTime ?? "")"
            //filterlocations?[indexPath.row].shortDescription ?? ""
            let fetchresto = filterlocations?[indexPath.row].timeSlots ?? []
            cell.lblRaiting.text = "\(filterlocations?[indexPath.row].avgRating ?? 0)"
            cell.cosmosView.rating = Double(filterlocations?[indexPath.row].avgRating ?? 0)
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerTimings = fetchresto
            cell.offerCollection.reloadData()
        } else if setValue == "Category" {
            let imageIndex = (imageURL) + (filterCategory?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            cell.lblfirstLocaton.text = filterCategory?[indexPath.row].city ?? ""
            cell.lblLocation.text = filterCategory?[indexPath.row].location ?? ""
            cell.lblName.text = filterCategory?[indexPath.row].name?.capitalized ?? ""
            cell.lblDiscription.text = "\(filterCategory?[indexPath.row].openTime ?? "") - " + "\(filterCategory?[indexPath.row].closeTime ?? "")"
           // let fetchresto = Store.screenType == 1 ? filterCategory?[indexPath.row].offers ?? [] : filterCategory?[indexPath.row].offers?.unique(map: {$0.offer?.id ?? 0}) ?? []
            let fetchresto = filterCategory?[indexPath.row].offers ?? []
            cell.offerTimings = fetchresto
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
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            
            if let disable_dates = filterCategory?[indexPath.row].disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString){
                    self.blurEffect(image: cell.imgView)
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
            cell.cosmosView.rating = Double(filtercusin?[indexPath.row].avgRating ?? 0)
            let fetchresto = filtercusin?[indexPath.row].timeSlots ?? []
            cell.offerTimings = fetchresto
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerCollection.reloadData()
            //MARK: For showing pre-selected offer.
            cell.callBack = { [weak self] ID in
                
                print(ID)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = self?.filtercusin?[indexPath.row].id ?? 0
                vc.selectedOfferId = ID
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            if let disable_dates = filtercusin?[indexPath.row].disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString) {
                    self.blurEffect(image: cell.imgView)
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

            
            
        } else {
            let imageIndex = (imageURL) + (filtertheme?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            cell.lblfirstLocaton.text = filtertheme?[indexPath.row].city ?? ""
            cell.lblLocation.text = filtertheme?[indexPath.row].location ?? ""
            cell.lblName.text = filtertheme?[indexPath.row].name?.capitalized ?? ""
            cell.lblDiscription.text = "\(filtertheme?[indexPath.row].openTime ?? "") - " + "\(filtertheme?[indexPath.row].closeTime ?? "")"
            cell.lblRaiting.text = "\(filtertheme?[indexPath.row].avgRating ?? 0)"
            cell.cosmosView.rating = Double(filtertheme?[indexPath.row].avgRating ?? 0)
            let fetchresto = filtertheme?[indexPath.row].timeSlots ?? []
            cell.offerTimings = fetchresto
            cell.offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            cell.layoutIfNeeded()
            cell.offerCollection.reloadData()
            cell.callBack = { [weak self] ID in
                
                print(ID)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = self?.filtertheme?[indexPath.row].id ?? 0
                vc.selectedOfferId = ID
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            if let disable_dates = filtertheme?[indexPath.row].disable_dates,disable_dates != "" {
                let disableDatesArr = disable_dates.components(separatedBy: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let todayDateString = dateFormatter.string(from: Date())
                if disableDatesArr.contains(todayDateString){
                    self.blurEffect(image: cell.imgView)
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
    
        if setValue == "Location" {
            return filterlocations?[indexPath.row].timeSlots?.count == 0 ? CGSize(width: collectionView.frame.width, height: 270) : CGSize(width: collectionView.frame.width, height: 320)
        } else if setValue == "Category" {
            return filterCategory?[indexPath.row].offers?.count == 0 ? CGSize(width: collectionView.frame.width, height: 270) : CGSize(width: collectionView.frame.width, height: 320)
        } else if setValue == "Cuisines" {
            return filtercusin?[indexPath.row].timeSlots?.count == 0 ? CGSize(width: collectionView.frame.width, height: 270) :CGSize(width: collectionView.frame.width, height: 320)
        } else {
            return filtertheme?[indexPath.row].timeSlots?.count == 0 ? CGSize(width: collectionView.frame.width, height: 270) : CGSize(width: collectionView.frame.width, height: 320)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if setValue == "Location" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = filterlocations?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        } else if setValue == "Category" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = filterCategory?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        } else if setValue == "Cuisines" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = filtercusin?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = filtertheme?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DetailItemViewVC : UITextFieldDelegate {
    //MARK: - Search
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultString = txtFldSearch.text ?? ""
        if (resultString.count) > 1{
            if let searchText = txtFldSearch.text {
                filtercusin = modal?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                filterCategory = categoryModal?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                filterlocations = location?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                filtertheme = thememodla?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
            }
        } else {
            filtercusin = modal
            filterCategory = categoryModal
            filterlocations = location
            filtertheme = thememodla
        }
        CollectionView.reloadData()
        return true
    }
}

