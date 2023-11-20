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
    
    var offerTimings: [OfferTimingd]?
    
    
}
extension DetailItemCVC : SkeletonCollectionViewDataSource,SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "OfferCVC"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerTimings?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCVC", for: indexPath) as! OfferCVC
        cell.lblTime.text = offerTimings?[indexPath.row].offer ?? ""
        cell.lblOfferPrecntage.text = "-\(offerTimings?[indexPath.row].percentage ?? 0)%"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/6.1, height: 64)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
