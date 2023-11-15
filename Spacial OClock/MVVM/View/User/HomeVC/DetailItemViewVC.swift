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

class DetailItemViewVC: UIViewController, SkeletonCollectionViewDataSource,SkeletonCollectionViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var imgViewHead: UIImageView!
    
    //MARK: Variables
    var country = String()
    var city = String()
    var iconImage = String()
    var heading = String()
    var cusinessID = Int()
    var themeID = Int()
    var location : [locationByRestoModalBody]?
    var cuisine = [Cuisine]()
    var viewmodal = HomeViewModel()
    var modal: [CussinesRestoModalBody]?
    var thememodla : [themeRestolistModalBody]?
    var categoryModal : [CategoryByRModalBody]?
    var lblName = ""
    var setimage = ""
    var setValue = ""
    var all_bars_restos = [AllBarsResto]()
    var type = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.type = UserDefaults.standard.integer(forKey: "dineDrinkStatus")
        CollectionView.showAnimatedGradientSkeleton()
        print(cusinessID)
        lblTwo.text = lblName
        lblOne.text = "\(setValue)> "
        lblHeader.text = setValue 
        imgViewHead.image = UIImage(named: setimage)
         
        if setValue == "Location"{
            location_By_RestoAPI()
        }else if setValue == "Cuisines"{
            get_resto_list()
        }else if setValue == "Category"{
            fetch_Category_REsto()
        }else if setValue == "Theme"{
            theme_Resto_API()
        }else if setValue == "Popular"{
            
        }
    }
    @IBAction func btnSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - CUSINS BY RESTO
    func get_resto_list(){
        viewmodal.cusinsRestoAPI(cuisineid: cusinessID) { [weak self] fetchdata in
            self?.modal = fetchdata
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
            }
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - THEME BY RESTO
    func theme_Resto_API(){
        viewmodal.restoThemelistAPI(restoid: themeID, type: type) { [weak self] dataa in
            self?.thememodla = dataa
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
            }
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - CATEGORY BY GET RESTO LIST API
    func fetch_Category_REsto(){
        viewmodal.categoryBYResto(categoryID: cusinessID) { [weak self] dataaa in
            self?.categoryModal = dataaa
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
            }
            self?.CollectionView.reloadData()
        }
    }
    
    
    //MARK: - LOCATION BY RESTO
    func location_By_RestoAPI(){
        viewmodal.locationByRestoAPI(country: country, city: city,type: "1") { [weak self] dataa in
            self?.location = dataa
           // self?.restrorants = dataa?.location?.first?.restrorants ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
            }
            self?.CollectionView.reloadData()
        }
    }
    
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "DetailItemCVC"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}
//MARK: - EXTENTION
extension DetailItemViewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setValue == "Location"{
            if location?.count == 0 {
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return location?.count ?? 0
            }
        }else if setValue == "Category"{
            if categoryModal?.count == 0 {
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return categoryModal?.count ?? 0
            }
        }
        else if setValue == "Cuisines"{
            if modal?.count == 0 {
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return modal?.count ?? 0
            }
            
        }else {
            if thememodla?.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return thememodla?.count ?? 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailItemCVC", for: indexPath) as! DetailItemCVC
//        cell.stackHeight.constant = 46
//        cell.viewOffer1.isHidden = true
//        cell.viewOffer2.isHidden = true
//        cell.viewOffer3.isHidden = true
        
        if setValue == "Location"{
            let imageIndex = (imageURL) + (location?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = location?[indexPath.row].name ?? ""
            cell.lblDiscription.text = location?[indexPath.row].shortDescription ?? ""
            let fetchresto = location?[indexPath.row].offers?.first?.offerTimings ?? []
            cell.offerTimings = fetchresto
            cell.offerCollection.reloadData()
            
            
//            if fetchresto.count == 1 {
//                cell.viewOffer1.isHidden = false
//                cell.lblOffer1.text = "\(fetchresto[0].percentage ?? 0)"
//                cell.lbltime1.text = fetchresto[0].offer ?? ""
//            } else if fetchresto.count == 2 {
//                cell.viewOffer1.isHidden = false
//                cell.viewOffer2.isHidden = false
//                cell.lblOffer1.text = "\(fetchresto[0].percentage ?? 0)"
//                cell.lblOffer2.text = "\(fetchresto[1].percentage ?? 0)"
//                cell.lbltime1.text = fetchresto[0].offer ?? ""
//                cell.lbltime2.text = fetchresto[1].offer ?? ""
//            } else if fetchresto.count >= 3{
//                cell.viewOffer1.isHidden = false
//                cell.viewOffer2.isHidden = false
//                cell.viewOffer3.isHidden = false
//                cell.lblOffer1.text = "\(fetchresto[0].percentage ?? 0)"
//                cell.lblOffer2.text = "\(fetchresto[1].percentage ?? 0)"
//                cell.lblOffer3.text = "\(fetchresto[2].percentage ?? 0)"
//                cell.lbltime1.text = fetchresto[0].offer ?? ""
//                cell.lbltime2.text = fetchresto[1].offer ?? ""
//                cell.lblTime3.text = fetchresto[2].offer ?? ""
//            } else {
//                cell.stackHeight.constant = 46
//            }
        } else if setValue == "Category"{
            let imageIndex = (imageURL) + (categoryModal?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = categoryModal?[indexPath.row].name ?? ""
            cell.lblDiscription.text = "\(categoryModal?[indexPath.row].openTime ?? "") - " + "\(categoryModal?[indexPath.row].closeTime ?? "")"
            let fetchresto = categoryModal?[indexPath.row].offers?.first?.offerTimings ?? []
            cell.offerTimings = fetchresto
            cell.offerCollection.reloadData()
//            let arrayOffer: [[OfferTiming]] = ((categoryModal?[indexPath.row].offers ?? []).map({$0.offerTimings ?? []}) )
//            sortArray(arrayOffer: arrayOffer,cell: cell)
//            cell.stackHeight.constant = 46
        }
        else if setValue == "Cuisines"{
            let imageIndex = (imageURL) + (modal?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = modal?[indexPath.row].name ?? ""
            cell.lblDiscription.text = "\(modal?[indexPath.row].openTime ?? "") - " + "\(modal?[indexPath.row].closeTime ?? "")"
            let fetchresto = modal?[indexPath.row].offers?.first?.offerTimings ?? []
            cell.offerTimings = fetchresto
            cell.offerCollection.reloadData()
//            let arrayOffer: [[OfferTiming]] = ((modal?[indexPath.row].offers ?? []).map({$0.offerTimings ?? []}) )
//            sortArray(arrayOffer: arrayOffer,cell: cell)
//            cell.stackHeight.constant = 46
        }else{
//            let arrayTheme : [[OfferTiming]] = ((thememodla?[indexPath.row].offers ?? []).map({$0.offerTimings ?? []}))
//            sortArray(arrayOffer: arrayTheme,cell: cell)
            let imageIndex = (imageURL) + (thememodla?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = thememodla?[indexPath.row].name ?? ""
            cell.lblDiscription.text = "\(thememodla?[indexPath.row].bodyOpenTime ?? "") - " + "\(thememodla?[indexPath.row].bodyCloseTime ?? "")"
            let fetchresto = thememodla?[indexPath.row].offers?.first?.offerTimings
            cell.offerTimings = fetchresto
            cell.offerCollection.reloadData()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 306)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if setValue == "Location"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = location?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setValue == "Category"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = categoryModal?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if setValue == "Cuisines"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = modal?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = thememodla?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    func sortArray(arrayOffer: [[OfferTiming]], cell: DetailItemCVC) {
//        var arrayOfferTime: [OfferTiming] = []
//        for i in arrayOffer {
//            arrayOfferTime.append(contentsOf: i)
//        }
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = "HH:mm"
//
//        let dateString = formatter.string(from: Date())
//        let output = arrayOfferTime.sorted { string1, string2 in
//            guard let date1 = formatter.date(from: string1.offer ?? "") else { return true }
//            guard let date2 = formatter.date(from: string2.offer ?? "") else { return false }
//            return date1 < date2
//        }
//
//
//        var finalArray: [OfferTiming] = []
//        for i in output {
//             let date1 = formatter.date(from: i.offer ?? "") ?? Date()
//            let date = formatter.date(from: dateString) ?? Date()
//            if date < date1 {
//                finalArray.append(i)
//            }
//        }
//
//        if finalArray.count == 1 {
//            cell.viewOffer1.isHidden = false
//            cell.lblOffer1.text = "\(finalArray[0].percentage ?? 0)"
//            cell.lbltime1.text = finalArray[0].offer ?? ""
//        } else if finalArray.count == 2 {
//            cell.viewOffer1.isHidden = false
//            cell.viewOffer2.isHidden = false
//            cell.lblOffer1.text = "\(finalArray[0].percentage ?? 0)"
//            cell.lblOffer2.text = "\(finalArray[1].percentage ?? 0)"
//            cell.lbltime1.text = finalArray[0].offer ?? ""
//            cell.lbltime2.text = finalArray[1].offer ?? ""
//        } else if finalArray.count >= 3{
//            cell.viewOffer1.isHidden = false
//            cell.viewOffer2.isHidden = false
//            cell.viewOffer3.isHidden = false
//            cell.lblOffer1.text = "\(finalArray[0].percentage ?? 0)"
//            cell.lblOffer2.text = "\(finalArray[1].percentage ?? 0)"
//            cell.lblOffer3.text = "\(finalArray[2].percentage ?? 0)"
//            cell.lbltime1.text = finalArray[0].offer ?? ""
//            cell.lbltime2.text = finalArray[1].offer ?? ""
//            cell.lblTime3.text = finalArray[2].offer ?? ""
//        } else {
//            cell.stackHeight.constant = 46
//        }
//    }
}

