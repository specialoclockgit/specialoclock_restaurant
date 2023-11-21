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
         if setvalue == "Popular"{
            lblHeader.text = "Popular"
            lblHeaderTExt.text = "Popular"
            imgViewHeader.image = UIImage(named: "mask")
        }else{
            lblHeader.text = "A-Z"
            lblHeaderTExt.text = "A-Z"
            imgViewHeader.image = UIImage(named: "mask")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - EXTENSIONS
extension homeSeeMoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setvalue == "Popular"{
            self.collection.hideSkeleton()
            if all_bars_restos.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return all_bars_restos.count
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
        if setvalue == "Popular"{
            let imageIndex = (imageURL) + (all_bars_restos[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            cell.imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblDis.text = ((self.all_bars_restos[indexPath.row].openTime)?.components(separatedBy: " ").first ?? "") + " - " +  ((self.all_bars_restos[indexPath.row].closeTime)?.components(separatedBy: " ").first ?? "")
            cell.lblName.text = self.all_bars_restos[indexPath.row].name ?? ""
            cell.offerTimings = self.all_bars_restos[indexPath.row].offerTimings ?? []
            cell.lblCity.text = self.all_bars_restos[indexPath.row].city ?? ""
            cell.lblLocation.text = self.all_bars_restos[indexPath.row].location ?? ""
            cell.lblRating.text = "\(self.all_bars_restos[indexPath.row].avgRating ?? 0)"
            cell.cosmosView.rating = Double(self.all_bars_restos[indexPath.row].avgRating ?? 0)
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
            cell.lblCity.text = self.highily_rated_bars_restos[indexPath.row].city ?? ""
            cell.lblLocation.text = self.highily_rated_bars_restos[indexPath.row].location ?? ""
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
         if setvalue == "Popular"{
            if self.all_bars_restos[indexPath.row].offerTimings?.count == 0{
                return CGSize(width: collection.frame.width, height: 216)
            }else{
                return CGSize(width: collection.frame.width, height: 286)
            }
        }else{
            if self.highily_rated_bars_restos[indexPath.row].offerTimings?.count == 0{
                return CGSize(width: collection.frame.width, height: 216)
            }else{
                return CGSize(width: collection.frame.width, height: 286)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if setvalue == "Popular"{
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
