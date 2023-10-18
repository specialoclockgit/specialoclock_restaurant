//
//  homeSeeMoreVC.swift
//  Spacial OClock
//
//  Created by cqlios on 25/09/23.
//

import UIKit
import SDWebImage

class homeSeeMoreVC: UIViewController {

    //MARK: - OUTLETS
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
        if setvalue == "Location"{
            lblHeader.text = "Location"
            imgViewHeader.image = UIImage(named: "pinPerson")
        }else if setvalue == "Cusinis"{
            lblHeader.text = "Cuisine"
            imgViewHeader.image = UIImage(named: "soup")
        }else if setvalue == "Category"{
            lblHeader.text = "Category"
            imgViewHeader.image = UIImage(named: "menu 1")
        }else if setvalue == "Popular"{
            lblHeader.text = "Popular"
            imgViewHeader.image = UIImage(named: "mask")
        }else if setvalue == "Theme"{
            lblHeader.text = "Theme"
            imgViewHeader.image = UIImage(named: "mask")
        }else{
            lblHeader.text = "A-Z"
            imgViewHeader.image = UIImage(named: "mask")
        }
    }
    //MARK: - ACTIONS

}
//MARK: - EXTENSIONS
extension homeSeeMoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setvalue == "Cusinis"{
            return cuisine.count
        }else if setvalue == "Cusinis"{
            return cuisine.count
        }else if setvalue == "Category"{
            return category.count
        }else if setvalue == "Popular"{
            return all_bars_restos.count
        }else if setvalue == "Theme"{
            return themeArr.count
        }else{
            return highily_rated_bars_restos.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeSeeMoreCVC", for: indexPath) as! homeSeeMoreCVC
        cell.stackHeight.constant = 0
        if setvalue == "Location"{
            cell.imgVirw.showIndicator(baseUrl: "", imageUrl: self.location[indexPath.row].image ?? "")
            cell.lblName.text = self.location[indexPath.row].city ?? ""
            cell.lblDis.text = "Restaurant \(self.location[indexPath.row].restroCount ?? 0)"
        }else if setvalue == "Cusinis"{
            let imageIndex = (imageBaseURL) + (self.cuisine[indexPath.row].image ?? "")
            cell.imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblDis.text = "Restaurant \(self.cuisine[indexPath.row].restroCount ?? 0)"
            cell.lblName.text = self.cuisine[indexPath.row].name ?? ""
        }else if setvalue == "Category"{
            let imageIndex = (imageBaseURL) + (self.category[indexPath.row].image ?? "")
            cell.imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblDis.text = "Restaurant \(self.category[indexPath.row].clubCount ?? 0)"
            cell.lblName.text = self.category[indexPath.row].title ?? ""
        }else if setvalue == "Theme"{
            let image = "\(self.themeArr[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgVirw.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblDis.text = "Restaurant \(self.themeArr[indexPath.row].restroCount ?? 0)"
            cell.lblName.text = self.themeArr[indexPath.row].productName ?? ""
        }else if setvalue == "Popular"{
            cell.stackHeight.constant = 46
            cell.imgVirw.showIndicator(baseUrl: imageURL, imageUrl: self.all_bars_restos[indexPath.row].profileImage ?? "")
          cell.lblDis.text = self.all_bars_restos[indexPath.row].shortDescription ?? ""
            cell.lblName.text = self.all_bars_restos[indexPath.row].name ?? ""
        }else{
            cell.stackHeight.constant = 46
            let image = "\(self.highily_rated_bars_restos[indexPath.row].profileImage ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgVirw.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblName.text = self.highily_rated_bars_restos[indexPath.row].name ?? ""
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if setvalue == "Popular"{
            return CGSize(width: collection.frame.width / 2.1, height: 246)
        }else if setvalue == "A-Z"{
            return CGSize(width: collection.frame.width / 2.1, height: 246)
        }else{
            return CGSize(width: collection.frame.width / 2.1, height: 200)
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
        }else if setvalue == "Cusinis"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.cusinessID = self.cuisine[indexPath.row].id ?? 0
            vc.lblName = self.cuisine[indexPath.row].name ?? ""
            vc.setimage = "soup"
            vc.setValue = "Cusinis"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setvalue == "Category"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            self.navigationController?.pushViewController(vc, animated: true)
            //vc.cuisine = category[indexPath.row]
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
