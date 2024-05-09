//
//  DetailItemCVC.swift
//  Spacial OClock
//
//  Created by cqlios on 20/09/23.
//

import UIKit
import SkeletonView
import Cosmos

class DetailItemCVC: UICollectionViewCell {
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var lblRaiting: UILabel!
    @IBOutlet weak var lblfirstLocaton: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var offerCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var offerCollection: UICollectionView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: CustomImageView!
    @IBOutlet weak var whiteBlurVw: UIView!
    @IBOutlet weak var closeDateVw: UIView!
    @IBOutlet weak var lblcloseDate: UILabel!
    @IBOutlet weak var lblRaitingCount: UILabel!
    @IBOutlet weak var lblLocDistance: UILabel!
    var callBack: ((Int)->())?
    var screen = Store.screenType
    var offerTimings: [TimeSlotoffer]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "HomeOfferCVC", bundle: nil)
        offerCollection.register(nib, forCellWithReuseIdentifier: "HomeOfferCVC")
    }
}
extension DetailItemCVC : SkeletonCollectionViewDataSource,SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout { 
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "HomeOfferCVC"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
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
        
//        cell.lblOfferPrecntage.text = ""
        
        
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
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        1
//    }
}
