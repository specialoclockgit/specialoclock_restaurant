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
    var location : locationByRestoModalBody?
    var restrorants: [Restrorantee]?
    var cuisine = [Cuisine]()
    var viewmodal = HomeViewModel()
    var modal: [CussinesRestoModalBody]?
    var thememodla : [themeRestolistModalBody]?
    var lblName = ""
    var setimage = ""
    var setValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.showAnimatedGradientSkeleton()
        print(cusinessID)
        lblTwo.text = lblName
        lblOne.text = "\(setValue)> "
        imgViewHead.image = UIImage(named: setimage)
        
         
        if setValue == "Location"{
            location_By_RestoAPI()
        }else if setValue == "Cuisines"{
            get_resto_list()
        }else if setValue == "Categorys"{
            
        }else{
            theme_Resto_API()
        }
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
        viewmodal.restoThemelistAPI(restoid: themeID) { [weak self] dataa in
            self?.thememodla = dataa
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.CollectionView.hideSkeleton()
            }
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - LOCATION BY RESTO
    func location_By_RestoAPI(){
        viewmodal.locationByRestoAPI(country: country, city: city,type: "1") { dataa in
            self.location = dataa
            self.restrorants = dataa?.location?.first?.restrorants ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.CollectionView.hideSkeleton()
            }
            self.CollectionView.reloadData()
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
            if restrorants?.count == 0 {
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return restrorants?.count ?? 0
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
        if setValue == "Location"{
            let imageIndex = (imageURL) + (restrorants?[indexPath.row].profileImage ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = restrorants?[indexPath.row].name ?? ""
            cell.lblDiscription.text = "\(restrorants?[indexPath.row].offerOpenTime ?? "") - " + "\(restrorants?[indexPath.row].offerCloseTime ?? "") " + "\(restrorants?[indexPath.row].offerPercentage ?? "")%"
        }
        else if setValue == "Cuisines"{
            let imageIndex = (imageURL) + (modal?[indexPath.row].profileImage ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = modal?[indexPath.row].name ?? ""
            cell.lblDiscription.text = "\(modal?[indexPath.row].offerOpenTime ?? "") - " + "\(modal?[indexPath.row].offerCloseTime ?? "") " + "\(modal?[indexPath.row].offerPercentage ?? "")%"
            
        }else{
            let imageIndex = (imageURL) + (thememodla?[indexPath.row].profileImage ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = thememodla?[indexPath.row].name ?? ""
            cell.lblDiscription.text = "\(thememodla?[indexPath.row].openTime ?? "") - " + "\(thememodla?[indexPath.row].closeTime ?? "") " + "\(thememodla?[indexPath.row].offerPercentage ?? "")%"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if setValue == "Location"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = restrorants?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setValue == "Cuisines"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = modal?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = thememodla?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

