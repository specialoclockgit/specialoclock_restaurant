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
    var getcity = String()
    var getcountry = String()
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        
    }
    
}
//MARK: - EXTENSIONS
extension homeSeeMoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setvalue == "Popular"{
            if all_bars_restos.count == 0 {
                collectionView.setNoDataMessage("No result found")
            } else {
                collectionView.backgroundView = nil
                return all_bars_restos.count
            }
        } else {
            if highily_rated_bars_restos.count == 0{
                collectionView.setNoDataMessage("No result found")
            }else{
                collectionView.backgroundView = nil
                return highily_rated_bars_restos.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeSeeMoreCVC", for: indexPath) as! homeSeeMoreCVC
        if setvalue == "Popular"{
            cell.allRestroListing = all_bars_restos[indexPath.row]
        }else{
            cell.highilyRatedListing = highily_rated_bars_restos[indexPath.row]
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
             vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = highily_rated_bars_restos[indexPath.row].id ?? 0
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
