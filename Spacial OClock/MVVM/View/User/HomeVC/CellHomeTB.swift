//
//  CellHomeTB.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit
import SDWebImage

struct CellModel {
    var image : UIImage
    var locationNmae  : String
    var totalRestaurant : String
}

class CellHomeTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnSeeMore : UIButton!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var collView : UICollectionView!
    
    //MARK: Variables

    var isCellSelected = Bool()
    var iconString = String()
    var heading = String()
    var location = [HomeListLocation]()
    var cuisine = [Cuisine]()
    var heishtresto = [AllBarsResto]()
    var allresto = [AllBarsResto]()
    var themeArr = [ThemeData]()
    var category = [Category]()
    var objArray: [SectionModel] = []
    //var filterary = [SectionModel]()
    var status = 1
    var country = String()
    var city = String()
        //value(forKey: "dineDrinkStatus") as? Int
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: Cell.CellHomeCV, bundle: nil)
        self.collView.register(nib, forCellWithReuseIdentifier: Cell.CellHomeCV)
        collView.delegate = self
        collView.dataSource = self
        
        if let layout = collView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        
    }

}
extension CellHomeTB : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if objArray[collView.tag].name == "Cuisines" {
            return objArray[collView.tag].objArray?.count ?? 0
        }else if objArray[collView.tag].name == "Category"{
            return objArray[collView.tag].objArray?.count ?? 0
        }else if objArray[collView.tag].name == "Location" {
            return objArray[collView.tag].objArray?.count ?? 0
        }else if objArray[collView.tag].name == "Popular" {
            return objArray[collView.tag].objArray?.count ?? 0
        }else if objArray[collView.tag].name == "Theme" {
            return objArray[collView.tag].objArray?.count ?? 0
        }else if objArray[collView.tag].name == "A-Z" {
            return objArray[collView.tag].objArray?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: Cell.CellHomeCV, for: indexPath) as! CellHomeCV
        cell.btnNext.isUserInteractionEnabled = false
        if objArray[collView.tag].name == "Cuisines" {
            cell.view1.isHidden = false
            cell.view2.isHidden = true
            let image = "\(self.cuisine[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.collHeight.constant = 0
            cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblLocationName.text = self.cuisine[indexPath.row].name ?? ""
            
            let count = (self.cuisine[indexPath.row].restrorants?.filter({$0.offer_available == 1}).count ?? 0)
            let newBarsCount = count == 0 ? "\(count) Bars/Clubs" : count == 1 ? "0\(count) Bar/Club" : count < 9 ? "0\(count) Bars/Clubs" : "\(count) Bars/Clubs"
            let newRestoCount = count == 0 ? "\(count) Restaurants" : count == 1 ? "0\(count) Restaurant" : count < 9 ? "0\(count) Restaurants" : "\(count) Restaurants"
            cell.lblTotalRestaurant.text = Store.screenType == 2 ? (newBarsCount) : (newRestoCount)
            
//            cell.lblRating.text = self.cuisine[indexPath.row].
            cell.viewReview.isHidden = true
        } else  if objArray[collView.tag].name == "Category" {
            cell.view1.isHidden = false
            cell.view2.isHidden = true
            let image = "\(self.category[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.collHeight.constant = 0
            cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblLocationName.text = self.category[indexPath.row].title ?? ""
            let count = (self.category[indexPath.row].clubCount ?? 0)
            let newBarsCount = count == 0 ? "\(count) Bars/Clubs" : count == 1 ? "0\(count) Bar/Club" : count < 9 ? "0\(count) Bars/Clubs" : "\(count) Bars/Clubs"
            let newRestoCount = count == 0 ? "\(count) Restaurants" : count == 1 ? "0\(count) Restaurant" : count < 9 ? "0\(count) Restaurants" : "\(count) Restaurants"
            cell.lblTotalRestaurant.text = Store.screenType == 2 ? (newBarsCount) : (newRestoCount)
            cell.viewReview.isHidden = true
        } else if objArray[collView.tag].name == "Location" {
            cell.view1.isHidden = false
            cell.view2.isHidden = true
            cell.collHeight.constant = 0
            cell.imgLocaiton.showIndicator(baseUrl: "", imageUrl: self.location[indexPath.row].image ?? "")
            cell.lblLocationName.text = self.location[indexPath.row].locality_area
            
            let count = (self.location[indexPath.row].restrorants?.filter({$0.offer_available == 1}).count ?? 0)
            let newBarsCount = count == 0 ? "\(count) Bars/Clubs" : count == 1 ? "0\(count) Bar/Club" : count < 9 ? "0\(count) Bars/Clubs" : "\(count) Bars/Clubs"
            let newRestoCount = count == 0 ? "\(count) Restaurants" : count == 1 ? "0\(count) Restaurant" : count < 9 ? "0\(count) Restaurants" : "\(count) Restaurants"
            cell.lblTotalRestaurant.text = Store.screenType == 2 ? (newBarsCount) : (newRestoCount)
            cell.viewReview.isHidden = true
            //cell.lblRating.text = self.location[indexPath.row].
        } else if objArray[collView.tag].name == "Popular" {
            cell.view1.isHidden = true
            cell.view2.isHidden = false
            cell.lblRestName.text = heishtresto[indexPath.row].name ?? ""
            cell.lblRestLoc.text = heishtresto[indexPath.row].city ?? ""
            cell.lblRestTiming.text = "\(heishtresto[indexPath.row].openTime ?? "") - \(heishtresto[indexPath.row].closeTime ?? "")"
            let celldata = heishtresto[indexPath.row].time_slots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""})
            cell.collHeight.constant = celldata?.count == 0 ? 0 : 60
            cell.layoutIfNeeded()
            cell.offerTimings = celldata
            cell.collVw.reloadData()
            cell.imgLocaiton.showIndicator(baseUrl: imageURL, imageUrl: self.heishtresto[indexPath.row].profileImage ?? "")
            cell.lblRating.text = "\(heishtresto[indexPath.row].avgRating ?? 0)"
            
            cell.callBack = { restId in
                let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = self.heishtresto[indexPath.row].id ?? 0
                vc.selectedOfferId = restId
                super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
            }

            cell.lblLocationName.text = self.heishtresto[indexPath.row].name
            cell.viewReview.isHidden = false
            cell.lblTotalRestaurant.text = self.heishtresto[indexPath.row].shortDescription ?? ""
        } else if objArray[collView.tag].name == "Theme" {
            cell.collHeight.constant = 0
            cell.viewReview.isHidden = true
            cell.view1.isHidden = false
            cell.view2.isHidden = true
            let image = "\(self.themeArr[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblLocationName.text = self.themeArr[indexPath.row].productName ?? ""
            
            let count = self.themeArr[indexPath.row].restrorant?.count ?? 0
            //(self.themeArr[indexPath.row].restrorants?.filter({$0.offer_available == 1}).count ?? 0)
            let newBarsCount = count == 0 ? "\(count) Bars/Clubs" : count == 1 ? "0\(count) Bar/Club" : count < 9 ? "0\(count) Bars/Clubs" : "\(count) Bars/Clubs"
            let newRestoCount = count == 0 ? "\(count) Restaurants" : count == 1 ? "0\(count) Restaurant" : count < 9 ? "0\(count) Restaurants" : "\(count) Restaurants"
            cell.lblTotalRestaurant.text = Store.screenType == 2 ? (newBarsCount) : (newRestoCount)
            
        } else if objArray[collView.tag].name == "A-Z" {
            cell.view1.isHidden = true
            cell.view2.isHidden = false
            cell.lblRestName.text = allresto[indexPath.row].name ?? ""
            cell.lblRestLoc.text = allresto[indexPath.row].city ?? ""
            cell.lblRestTiming.text = "\(allresto[indexPath.row].openTime ?? "") - \(allresto[indexPath.row].closeTime ?? "")"
            let celldata = allresto[indexPath.row].time_slots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""})
            cell.lblRating.text = "\(allresto[indexPath.row].avgRating ?? 0)"
            cell.offerTimings = celldata
            cell.collHeight.constant = celldata?.count == 0 ? 0 : 60
            cell.collVw.reloadData()
            cell.layoutIfNeeded()
            cell.callBack = { restId in
                let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                vc.ProductID = self.allresto[indexPath.row].id ?? 0
                vc.selectedOfferId = restId
                super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
            }
//            if allresto[indexPath.row].offerTimings?.count == 1 {
//                cell.stackHeight.constant = 46
//                cell.viewOffer1.isHidden = false
//                cell.offerImg1.isHidden = false
//                cell.offerImg2.isHidden = true
//                cell.offerImg3.isHidden = true
//                cell.lblOffer1.isHidden = false
//                cell.lblOffer2.isHidden = true
//                cell.lblOffer3.isHidden = true
//                cell.lblTime1.isHidden = false
//                cell.lblTime2.isHidden = true
//                cell.lblTime3.isHidden = true
//               // cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
//                cell.lblTime1.text = Store.screenType == 1 ? "\(celldata?[0].offer ?? "") \n\("-\(celldata?[0].percentage ?? "0")%")" : (celldata?[0].offer ?? "")
//            } else if allresto[indexPath.row].offerTimings?.count == 2 {
//                cell.stackHeight.constant = 46
//                cell.viewOffer1.isHidden  = false
//                cell.viewOffer2.isHidden  = false
//                cell.offerImg1.isHidden   = false
//                cell.offerImg2.isHidden   = false
//                cell.offerImg3.isHidden   = true
//                cell.lblOffer1.isHidden   = false
//                cell.lblOffer2.isHidden   = false
//                cell.lblOffer3.isHidden   = true
//                cell.lblTime1.isHidden    = false
//                cell.lblTime2.isHidden    = false
//                cell.lblTime3.isHidden    = true
//
//               // cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
//               // cell.lblOffer2.text = "-\(celldata?[1].percentage ?? 0)%"
//                cell.lblTime1.text = Store.screenType == 1 ? "\(celldata?[0].offer ?? "") \n\("-\(celldata?[0].percentage ?? "0")%")" : (celldata?[0].offer ?? "")
//                cell.lblTime2.text = Store.screenType == 1 ? "\(celldata?[1].offer ?? "") \n\("-\(celldata?[0].percentage ?? "0")%")" : (celldata?[1].offer ?? "")
//            } else if allresto[indexPath.row].offerTimings?.count ?? 0 >= 3 {
//                cell.stackHeight.constant = 46
//                cell.viewOffer1.isHidden = false
//                cell.viewOffer2.isHidden = false
//                cell.viewOffer3.isHidden = false
//                cell.offerImg1.isHidden = false
//                cell.offerImg2.isHidden = false
//                cell.offerImg3.isHidden = false
//                cell.lblOffer1.isHidden = false
//                cell.lblOffer2.isHidden = false
//                cell.lblOffer3.isHidden = false
//                cell.lblTime1.isHidden = false
//                cell.lblTime2.isHidden = false
//                cell.lblTime3.isHidden = false
//                cell.viewOffer1.isHidden = false
//                cell.viewOffer2.isHidden = false
//                cell.viewOffer3.isHidden = false
//               // cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
//                //cell.lblOffer2.text = "-\(celldata?[1].percentage ?? 0)%"
//               // cell.lblOffer3.text = "-\(celldata?[2].percentage ?? 0)%"
//                cell.lblTime1.text = Store.screenType == 1 ? "\(celldata?[0].offer ?? "") \n\("-\(celldata?[0].percentage ?? "0")%")" : (celldata?[0].offer ?? "")
//                cell.lblTime2.text = Store.screenType == 1 ? "\(celldata?[1].offer ?? "") \n\("-\(celldata?[0].percentage ?? "0")%")" : (celldata?[1].offer ?? "")
//                cell.lblTime3.text = Store.screenType == 1 ? "\(celldata?[2].offer ?? "") \n\("-\(celldata?[0].percentage ?? "0")%")" : (celldata?[2].offer ?? "")
//
//            } else {
//                cell.stackHeight.constant = 0
//            }
           // print(cell.lblTime1.text,cell.lblTime2.text,cell.lblTime3.text)
            cell.viewReview.isHidden = true
            let imageIndex = (imageURL) + (allresto[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgLocaiton.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgLocaiton.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblLocationName.text = allresto[indexPath.row].name ?? ""
            cell.lblTotalRestaurant.text = allresto[indexPath.row].shortDescription ?? ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if objArray[collView.tag].name == "A-Z" {
            return CGSize(width: (collectionView.frame.size.width / 1.2) , height: 260)
        } else if objArray[collView.tag].name == "Popular" {
            return CGSize(width: (collectionView.frame.size.width / 1.2) , height: 260)
        } else {
            return CGSize(width: (collectionView.frame.size.width / 1.2) , height: 228)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if objArray[collView.tag].name == "Location" {
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.country = location[indexPath.row].country ?? ""
            vc.city = location[indexPath.row].city ?? ""
            vc.lblName = location[indexPath.row].locality_area ?? ""
            vc.setValue = "Location"
            vc.setimage = "pinPerson"
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }else if objArray[collView.tag].name == "Category" {
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.cusinessID = category[indexPath.row].id ?? 0
            vc.lblName = category[indexPath.row].title ?? ""
            vc.setValue = "Category"
            vc.setimage = "category_icon"
            vc.country = self.country
            vc.city = self.city
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }
        else if objArray[collView.tag].name == "Cuisines" {
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.cusinessID = cuisine[indexPath.row].id ?? 0
            vc.lblName = cuisine[indexPath.row].name ?? ""
            vc.setValue = "Cuisines"
            vc.setimage = "soup"
            vc.country = self.country
            vc.city = self.city
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }
        else if objArray[collView.tag].name == "Popular" {
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.ItemDetailsVC) as! ItemDetailsVC
            
            vc.ProductID = heishtresto[indexPath.row].id ?? 0
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }else if objArray[collView.tag].name == "Theme" {
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.themeID = themeArr[indexPath.row].id ?? 0
            vc.lblName = themeArr[indexPath.row].productName ?? ""
            vc.setValue = "Theme"
            vc.setimage = "mask"
            vc.country = self.country
            vc.city = self.city
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        } else{
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.ItemDetailsVC) as! ItemDetailsVC
            vc.ProductID = allresto[indexPath.row].id ?? 0
            
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
