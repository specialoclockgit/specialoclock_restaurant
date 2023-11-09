//
//  homeSeeMoreVC.swift
//  Spacial OClock
//
//  Created by cqlios on 25/09/23.
//

import UIKit
import SDWebImage
import SkeletonView
import SwiftGifOrigin

class homeSeeMoreVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var lblHeaderTExt: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imgViewHeader: UIImageView!
    @IBOutlet weak var txtFldSearch: CustomTextField!
    
    //MARK: - VARIABLES
    var location = [HomeListLocation]()
    var cuisine = [Cuisine]()
    var themeArr = [ThemeData]()
    var category = [Category]()
    var all_bars_restos = [AllBarsResto]()
    var highily_rated_bars_restos = [AllBarsResto]()
    var setvalue = ""
    var objArray: [SectionModel] = []
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.showSkeleton()
        if setvalue == "Location"{
            lblHeader.text = "Location"
            lblHeaderTExt.text = "Location"
            imgViewHeader.image = UIImage(named: "pinPerson")
        }else if setvalue == "Cuisines"{
            lblHeader.text = "Cuisine"
            lblHeaderTExt.text = "Cuisine"
            imgViewHeader.image = UIImage(named: "soup")
        }else if setvalue == "Category"{
            lblHeader.text = "Category"
            lblHeaderTExt.text = "Category"
            imgViewHeader.image = UIImage(named: "menu 1")
        }else if setvalue == "Popular"{
            lblHeader.text = "Popular"
            lblHeaderTExt.text = "Popular"
            imgViewHeader.image = UIImage(named: "mask")
        }else if setvalue == "Theme"{
            lblHeader.text = "Theme"
            lblHeaderTExt.text = "Theme"
            imgViewHeader.image = UIImage(named: "mask")
        }else{
            lblHeader.text = "A-Z"
            lblHeaderTExt.text = "A-Z"
            imgViewHeader.image = UIImage(named: "mask")
        }
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - EXTENSIONS
extension homeSeeMoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setvalue == "Cuisines"{
            self.collection.hideSkeleton()
            if cuisine.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return cuisine.count
            }
        }else if setvalue == "Category"{
            self.collection.hideSkeleton()
            if category.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return category.count
            }
        }else if setvalue == "Popular"{
            self.collection.hideSkeleton()
            if all_bars_restos.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return all_bars_restos.count
            }
        }else if setvalue == "Theme"{
            self.collection.hideSkeleton()
            if themeArr.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return themeArr.count
            }
        }else if setvalue == "Location"{
            self.collection.hideSkeleton()
            if location.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return location.count
            }
        }else{
            self.collection.hideSkeleton()
            if highily_rated_bars_restos.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return highily_rated_bars_restos.count
            }
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeSeeMoreCVC", for: indexPath) as! homeSeeMoreCVC
        if setvalue == "Location"{
            cell.seeMoreColleHeight.constant = 0
            cell.imgVirw.showIndicator(baseUrl: "", imageUrl: self.location[indexPath.row].image ?? "")
            cell.lblName.text = self.location[indexPath.row].city ?? ""
            cell.lblDis.text = "Restaurant \(self.location[indexPath.row].restroCount ?? 0)"
        }else if setvalue == "Cuisines"{
            cell.seeMoreColleHeight.constant = 0
            let image = "\(self.cuisine[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgVirw.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblDis.text = "Restaurant \(self.cuisine[indexPath.row].restroCount ?? 0)"
            cell.lblName.text = self.cuisine[indexPath.row].name ?? ""
        }else if setvalue == "Category"{
            cell.seeMoreColleHeight.constant = 0
            let image = "\(self.category[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgVirw.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblDis.text = "Restaurant \(self.category[indexPath.row].clubCount ?? 0)"
            cell.lblName.text = self.category[indexPath.row].title ?? ""
        }else if setvalue == "Theme"{
            cell.seeMoreColleHeight.constant = 0
            let image = "\(self.themeArr[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgVirw.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblDis.text = "Restaurant \(self.themeArr[indexPath.row].restroCount ?? 0)"
            cell.lblName.text = self.themeArr[indexPath.row].productName ?? ""
        }else if setvalue == "Popular"{
            let imageIndex = (imageURL) + (all_bars_restos[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblDis.text = self.all_bars_restos[indexPath.row].shortDescription ?? ""
            cell.lblName.text = self.all_bars_restos[indexPath.row].name ?? ""
            cell.offerTimings = self.all_bars_restos[indexPath.row].offerTimings ?? []
            cell.lblDis.text = (self.all_bars_restos[indexPath.row].openTime ?? "") +  "-" + (self.highily_rated_bars_restos[indexPath.row].closeTime ?? "")
            if cell.offerTimings?.count == 0{
                cell.seeMoreColleHeight.constant = 0
            }else{
                cell.seeMoreColleHeight.constant = 46
            }
        }else{
            let imageIndex = (imageURL) + (highily_rated_bars_restos[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = self.highily_rated_bars_restos[indexPath.row].name ?? ""
            cell.lblDis.text = (self.highily_rated_bars_restos[indexPath.row].openTime ?? "") +  "-" + (self.highily_rated_bars_restos[indexPath.row].closeTime ?? "")
            cell.offerTimings = self.highily_rated_bars_restos[indexPath.row].offerTimings ?? []
            if cell.offerTimings?.count == 0{
                cell.seeMoreColleHeight.constant = 0
            }else{
                cell.seeMoreColleHeight.constant = 46
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if setvalue == "Location"{
            return CGSize(width: collection.frame.width, height: 216)
        }else if setvalue == "Cuisines"{
            return CGSize(width: collection.frame.width, height: 216)
        }else if setvalue == "Category"{
            return CGSize(width: collection.frame.width, height: 216)
        }else if setvalue == "Theme"{
            return CGSize(width: collection.frame.width, height: 216)
        }else if setvalue == "Popular"{
            if self.all_bars_restos[indexPath.row].offerTimings?.count == 0{
                return CGSize(width: collection.frame.width, height: 216)
            }else{
                return CGSize(width: collection.frame.width, height: 266)
            }
        }else{
            if self.highily_rated_bars_restos[indexPath.row].offerTimings?.count == 0{
                return CGSize(width: collection.frame.width, height: 216)
            }else{
                return CGSize(width: collection.frame.width, height: 266)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if setvalue == "Location"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.country = self.location[indexPath.row].country ?? ""
            vc.city = self.location[indexPath.row].city ?? ""
            vc.setValue = "Location"
            vc.setimage = "PIN"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setvalue == "Cuisines"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.cusinessID = self.cuisine[indexPath.row].id ?? 0
            vc.lblName = self.cuisine[indexPath.row].name ?? ""
            vc.setimage = "soup"
            vc.setValue = "Cuisines"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setvalue == "Category"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.cusinessID = self.category[indexPath.row].id ?? 0
            vc.lblName = self.category[indexPath.row].title ?? ""
            vc.setimage = "category_icon"
            vc.setValue = "Category"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setvalue == "Theme"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.themeID = themeArr[indexPath.row].id ?? 0
            vc.lblName = self.themeArr[indexPath.row].productName ?? ""
            vc.setValue = "Theme"
            vc.setimage = "mask"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setvalue == "Popular"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = all_bars_restos[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = highily_rated_bars_restos[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
}
