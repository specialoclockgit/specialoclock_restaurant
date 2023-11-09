//
//  homeSeeMoreCVC.swift
//  Spacial OClock
//
//  Created by cqlios on 25/09/23.
//

import UIKit

class homeSeeMoreCVC: UICollectionViewCell {
    
    @IBOutlet weak var seeMoreColleHeight: NSLayoutConstraint!
    @IBOutlet weak var SeeMoreCollection: UICollectionView!
    @IBOutlet weak var lblDis: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVirw: CustomImageView!
    
    var offerTimings: [OfferTiminghome]?
    
    
    
}
extension homeSeeMoreCVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerTimings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerSeeMoreCVC", for: indexPath) as! offerSeeMoreCVC
        cell.lblName.text = offerTimings?[indexPath.row].offer ?? ""
        cell.lblDescription.text = "-\(offerTimings?[indexPath.row].percentage ?? 0)%"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/6.1, height: 64)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}
