//
//  FavouritesVC.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit
import SDWebImage
import SwiftGifOrigin
import SkeletonView
import Cosmos
class FavouritesVC: UIViewController,SkeletonCollectionViewDataSource,SkeletonCollectionViewDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var favouriteCV: UICollectionView!
    @IBOutlet weak var btnBack : UIButton!
    
    //MARK: - Variables
    var favViewModal = HomeViewModel()
    var modal : [locationByRestoModalBody]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        get_list()
    }
    
    
    //MARK: - FUNCTIONS
    func get_list(){
        favouriteCV.backgroundView = nil
        favouriteCV.showAnimatedGradientSkeleton()
        favViewModal.favListAPI { [weak self] dataa in
            self?.modal = dataa?.reversed()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.favouriteCV.hideSkeleton()
                self?.favouriteCV.reloadData()
            }
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FavouritesCell"
    }
    
   
    
}

//MARK: - UICollectionViewDelegateUICollectionViewDataSource
extension FavouritesVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if modal?.count == 0 {
            collectionView.setNoDataMessage("No favorites found")
        } else {
            collectionView.backgroundView = nil
            return modal?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCell", for: indexPath)as! FavouritesCell
        cell.listing = modal?[indexPath.row]
        cell.callBack = { [weak self] ID in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = self?.modal?[indexPath.row].id ?? 0
            vc.selectedOfferId = ID
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        cell.likeBtn.addTarget(self, action: #selector(btnfavourite(_:)), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stry = UIStoryboard(name: "Main", bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier: ViewController.ItemDetailsVC) as! ItemDetailsVC
        vc.ProductID = modal?[indexPath.row].id ?? 0
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 260)
    }
    
 
    @objc func btnfavourite(_ sender: UIButton){
        favViewModal.resto_likeAPI(Restoid: modal?[sender.tag].id ?? 0, status: 0) { data in
            self.modal?.remove(at: sender.tag)
            self.favouriteCV.reloadData()
        }
    }
}


class FavouritesCell:UICollectionViewCell{
    //MARK: - Outlets
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var lblRaiting: UILabel!
    @IBOutlet weak var lblfirstLocaton: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var offerCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var offerCollection: UICollectionView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: CustomImageView!
    @IBOutlet weak var lblRaitingCount: UILabel!
    @IBOutlet weak var lblLocDistance: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    var callBack: ((Int)->())?
    var screen = Store.screenType
    var offerTimings: [TimeSlotoffer]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "HomeOfferCVC", bundle: nil)
        offerCollection.register(nib, forCellWithReuseIdentifier: "HomeOfferCVC")
    }
    
    var listing : locationByRestoModalBody? {
        didSet {
            let imageIndex = (imageURL) + (listing?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
            lblRaitingCount.text = "(\(listing?.ratingCount?.description ?? "0"))"
            lblName.text = listing?.name?.capitalized ?? ""
            lblLocation.text = listing?.location ?? ""
            lblfirstLocaton.text = listing?.city ?? ""
            lblDiscription.text = "\(listing?.openTime ?? "") - \(listing?.closeTime ?? "")"
            let fetchresto = listing?.timeSlots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""}) ?? []
            lblRaiting.text = "\(listing?.avgRating ?? 0)"
            cosmosView.rating = Double(listing?.avgRating ?? 0)
            offerCollectionHeight.constant = fetchresto.count == 0 ? 0 : 56
            layoutIfNeeded()
            offerTimings = fetchresto
            offerCollection.reloadData()
        }
    }
    
}
extension FavouritesCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerTimings?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeOfferCVC", for: indexPath) as! HomeOfferCVC
        
        if screen == 1 {
            var percentage = String()
            if offerTimings?[indexPath.row].isFifty == 1 {
                percentage = "-\(50)%"
            } else if offerTimings?[indexPath.row].custom_discount != 0 {
                percentage = "-\(offerTimings?[indexPath.row].custom_discount ?? 0)%"
            } else{
                percentage = "-\(offerTimings?[indexPath.row].offer?.offerPrice ?? "0")%"
            }
            cell.titleLbl.text = "\((offerTimings?[indexPath.row].startTime?.components(separatedBy: " ").first ?? ""))\n\(percentage)"
        } else {
            cell.titleLbl.text = "\(offerTimings?[indexPath.row].startTime?.components(separatedBy: " ").first ?? "")"
            
        }

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBack?(self.offerTimings?[indexPath.row].slot_id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 6) - 6, height: 64)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        6
    }

}
