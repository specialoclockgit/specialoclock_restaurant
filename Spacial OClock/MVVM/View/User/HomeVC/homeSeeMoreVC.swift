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
    var setvalue = ""
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        if setvalue == "Location"{
            lblHeader.text = "Location"
            imgViewHeader.image = UIImage(named: "pinPerson")
        }else if setvalue == "Cuisine"{
            lblHeader.text = "Cuisine"
            imgViewHeader.image = UIImage(named: "soup")
        }else if setvalue == "Category"{
            lblHeader.text = "Category"
            imgViewHeader.image = UIImage(named: "menu 1")
        }else{
            lblHeader.text = "Theme"
            imgViewHeader.image = UIImage(named: "mask")
        }
    }
    //MARK: - ACTIONS

}
//MARK: - EXTENSIONS
extension homeSeeMoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setvalue == "Location"{
            return location.count
        }else if setvalue == "Cuisine"{
            return cuisine.count
        }else if setvalue == "Category"{
            return category.count
        }else{
            return themeArr.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeSeeMoreCVC", for: indexPath) as! homeSeeMoreCVC
        if setvalue == "Location"{
            let imageIndex = (imageBaseURL) + (self.location[indexPath.row].image ?? "")
            cell.imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = self.location[indexPath.row].city ?? ""
            cell.lblDis.text = "Restaurant \(self.location[indexPath.row].restroCount ?? 0)"
        }else if setvalue == "Cuisine"{
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
        }else{
            let imageIndex = (imageBaseURL) + (self.themeArr[indexPath.row].image ?? "")
            cell.imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblDis.text = "Restaurant \(self.themeArr[indexPath.row].restroCount ?? 0)"
            cell.lblName.text = self.themeArr[indexPath.row].productName ?? ""
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width / 2.1, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
        if setvalue == "Location"{
            
        }else if setvalue == "Cuisine"{
            vc.cusinessID = self.cuisine[indexPath.row].id ?? 0
            vc.lblName = self.cuisine[indexPath.row].name ?? ""
            vc.setValue = "Cuisines"
        }else if setvalue == "Category"{
            //vc.cuisine = category[indexPath.row]
        }else{
            vc.themeID = themeArr[indexPath.row].id ?? 0
            vc.lblName = self.themeArr[indexPath.row].productName ?? ""
            vc.setValue = "Theme"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
