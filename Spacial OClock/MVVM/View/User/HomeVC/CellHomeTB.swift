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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let nib = UINib(nibName: Cell.CellHomeCV, bundle: nil)
        self.collView.register(nib, forCellWithReuseIdentifier: Cell.CellHomeCV)
        collView.delegate = self
        collView.dataSource = self
//        isCellSelected = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
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
        if objArray[collView.tag].name == "Cuisines" {
            let image = "\(self.cuisine[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.stackHeight.constant = 0
            cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblLocationName.text = self.cuisine[indexPath.row].name ?? ""
            cell.lblTotalRestaurant.text = "\(self.cuisine[indexPath.row].restroCount ?? 0) Restaurants"
//            cell.lblRating.text = self.cuisine[indexPath.row].
            cell.viewReview.isHidden = true
        } else  if objArray[collView.tag].name == "Category" {
            let image = "\(self.category[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.stackHeight.constant = 0
            cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblLocationName.text = self.category[indexPath.row].title ?? ""
            cell.lblTotalRestaurant.text = "\(self.category[indexPath.row].clubCount ?? 0) Restaurants"
            cell.viewReview.isHidden = true
        }
        else if objArray[collView.tag].name == "Location" {
            cell.stackHeight.constant = 0
            cell.imgLocaiton.showIndicator(baseUrl: "", imageUrl: self.location[indexPath.row].image ?? "")
            cell.lblLocationName.text = self.location[indexPath.row].city
            cell.lblTotalRestaurant.text = "\(self.location[indexPath.row].restroCount ?? 0) Restaurants"
            cell.viewReview.isHidden = true
            //cell.lblRating.text = self.location[indexPath.row].
        }else if objArray[collView.tag].name == "Popular"{
            if let val = objArray[collView.tag].objArray as? [AllBarsResto] {
                print(val[0].offerTimings?.count ?? 0)
            }
            cell.stackHeight.constant = 46
            let celldata = heishtresto[indexPath.row].offerTimings
            cell.imgLocaiton.showIndicator(baseUrl: imageURL, imageUrl: self.heishtresto[indexPath.row].profileImage ?? "")
            cell.lblRating.text = "\(heishtresto[indexPath.row].avgRating ?? 0)"
            if heishtresto[indexPath.row].offerTimings?.count == 1 {
                cell.viewOffer1.isHidden = false
                
                cell.offerImg1.isHidden = false
                cell.offerImg2.isHidden = true
                cell.offerImg3.isHidden = true
                
                cell.lblOffer1.isHidden = false
                cell.lblOffer2.isHidden = true
                cell.lblOffer3.isHidden = true
                cell.lblTime1.isHidden = false
                cell.lblTime2.isHidden = true
                cell.lblTime3.isHidden = true
                cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
                cell.lblTime1.text = celldata?[0].offer ?? ""
            } else if heishtresto[indexPath.row].offerTimings?.count == 2 {
                cell.viewOffer1.isHidden = false
                cell.viewOffer2.isHidden = false
                
                cell.offerImg1.isHidden = false
                cell.offerImg2.isHidden = false
                cell.offerImg3.isHidden = true
                
                cell.lblOffer1.isHidden = false
                cell.lblOffer2.isHidden = false
                cell.lblOffer3.isHidden = true
                cell.lblTime1.isHidden = false
                cell.lblTime2.isHidden = false
                cell.lblTime3.isHidden = true
                
                cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
                cell.lblOffer2.text = "-\(celldata?[1].percentage ?? 0)%"
                cell.lblTime1.text = celldata?[0].offer ?? ""
                cell.lblTime2.text = celldata?[1].offer ?? ""
            } else if heishtresto[indexPath.row].offerTimings?.count ?? 0 >= 3{
                cell.viewOffer1.isHidden = false
                cell.viewOffer2.isHidden = false
                cell.viewOffer3.isHidden = false
                cell.offerImg1.isHidden = false
                cell.offerImg2.isHidden = false
                cell.offerImg3.isHidden = false
                cell.lblOffer1.isHidden = false
                cell.lblOffer2.isHidden = false
                cell.lblOffer3.isHidden = false
                cell.lblTime1.isHidden = false
                cell.lblTime2.isHidden = false
                cell.lblTime3.isHidden = false
                
                cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
                cell.lblOffer2.text = "-\(celldata?[1].percentage ?? 0)%"
                cell.lblOffer3.text = "-\(celldata?[2].percentage ?? 0)%"
                cell.lblTime1.text = celldata?[0].offer ?? ""
                cell.lblTime2.text = celldata?[1].offer ?? ""
                cell.lblTime3.text = celldata?[2].offer ?? ""
                cell.stackHeight.constant = 46
            } else {
                cell.stackHeight.constant = 0
            }
            cell.lblLocationName.text = self.heishtresto[indexPath.row].name
            cell.viewReview.isHidden = false
            cell.lblTotalRestaurant.text = self.heishtresto[indexPath.row].shortDescription ?? ""
        }else if objArray[collView.tag].name == "Theme"{
            cell.stackHeight.constant = 0
            cell.viewReview.isHidden = true
            let image = "\(self.themeArr[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblLocationName.text = self.themeArr[indexPath.row].productName ?? ""
            cell.lblTotalRestaurant.text = "\(self.themeArr[indexPath.row].restroCount ?? 0) Restaurants"
        }else if objArray[collView.tag].name == "A-Z"{
            cell.stackHeight.constant = 46
            let celldata = allresto[indexPath.row].offerTimings
            cell.lblRating.text = "\(allresto[indexPath.row].avgRating ?? 0)"
            if allresto[indexPath.row].offerTimings?.count == 1 {
                cell.viewOffer1.isHidden = false
                cell.offerImg1.isHidden = false
                cell.offerImg2.isHidden = true
                cell.offerImg3.isHidden = true
                cell.lblOffer1.isHidden = false
                cell.lblOffer2.isHidden = true
                cell.lblOffer3.isHidden = true
                cell.lblTime1.isHidden = false
                cell.lblTime2.isHidden = true
                cell.lblTime3.isHidden = true
                cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
                cell.lblTime1.text = celldata?[0].offer ?? ""
            } else if allresto[indexPath.row].offerTimings?.count == 2 {
                cell.viewOffer1.isHidden = false
                cell.viewOffer2.isHidden = false
                cell.offerImg1.isHidden = false
                cell.offerImg2.isHidden = false
                cell.offerImg3.isHidden = true
                cell.lblOffer1.isHidden = false
                cell.lblOffer2.isHidden = false
                cell.lblOffer3.isHidden = true
                cell.lblTime1.isHidden = false
                cell.lblTime2.isHidden = false
                cell.lblTime3.isHidden = true
                
                cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
                cell.lblOffer2.text = "-\(celldata?[1].percentage ?? 0)%"
                cell.lblTime1.text = celldata?[0].offer ?? ""
                cell.lblTime2.text = celldata?[1].offer ?? ""
            } else if allresto[indexPath.row].offerTimings?.count ?? 0 >= 3{
                
                cell.viewOffer1.isHidden = false
                cell.viewOffer2.isHidden = false
                cell.viewOffer3.isHidden = false
                cell.offerImg1.isHidden = false
                cell.offerImg2.isHidden = false
                cell.offerImg3.isHidden = false
                cell.lblOffer1.isHidden = false
                cell.lblOffer2.isHidden = false
                cell.lblOffer3.isHidden = false
                cell.lblTime1.isHidden = false
                cell.lblTime2.isHidden = false
                cell.lblTime3.isHidden = false
                cell.viewOffer1.isHidden = false
                cell.viewOffer2.isHidden = false
                cell.viewOffer3.isHidden = false
                cell.lblOffer1.text = "-\(celldata?[0].percentage ?? 0)%"
                cell.lblOffer2.text = "-\(celldata?[1].percentage ?? 0)%"
                cell.lblOffer3.text = "-\(celldata?[2].percentage ?? 0)%"
                cell.lblTime1.text = celldata?[0].offer ?? ""
                cell.lblTime2.text = celldata?[1].offer ?? ""
                cell.lblTime3.text = celldata?[2].offer ?? ""
            } else {
                cell.stackHeight.constant = 46
            }
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
        if objArray[collView.tag].name == "A-Z"{
            return CGSize(width: 195.0, height: 270)
        }else if objArray[collView.tag].name == "Popular"{
            return CGSize(width: 195.0, height: 270)
        }else{
            return CGSize(width: 195.0, height: 208.0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if objArray[collView.tag].name == "Location"{
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.country = location[indexPath.row].country ?? ""
            vc.city = location[indexPath.row].city ?? ""
            vc.lblName = location[indexPath.row].city ?? ""
            vc.setValue = "Location"
            vc.setimage = "pinPerson"
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }else if objArray[collView.tag].name == "Category"{
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.cusinessID = category[indexPath.row].id ?? 0
            vc.lblName = category[indexPath.row].title ?? ""
            vc.setValue = "Category"
            vc.setimage = "category_icon"
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }
        else if objArray[collView.tag].name == "Cuisines"{
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.cusinessID = cuisine[indexPath.row].id ?? 0
            vc.lblName = cuisine[indexPath.row].name ?? ""
            vc.setValue = "Cuisines"
            vc.setimage = "soup"
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }
        else if objArray[collView.tag].name == "Popular"{
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.ItemDetailsVC) as! ItemDetailsVC
            
            vc.ProductID = heishtresto[indexPath.row].id ?? 0
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }else if objArray[collView.tag].name == "Theme"{
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.themeID = themeArr[indexPath.row].id ?? 0
            vc.lblName = themeArr[indexPath.row].productName ?? ""
            vc.setValue = "Theme"
            vc.setimage = "mask"
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.ItemDetailsVC) as! ItemDetailsVC
            vc.ProductID = allresto[indexPath.row].id ?? 0
            super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
