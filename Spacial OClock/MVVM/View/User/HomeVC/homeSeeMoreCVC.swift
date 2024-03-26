//
//  homeSeeMoreCVC.swift
//  Spacial OClock
//
//  Created by cqlios on 25/09/23.
//

import UIKit
import Cosmos
import SDWebImage
class homeSeeMoreCVC: UICollectionViewCell {
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var LocationHeading: UILabel!
    @IBOutlet weak var imgViewHome: UIImageView!
    @IBOutlet weak var lblOpenHour: UILabel!
    @IBOutlet weak var imgViewClock: UIImageView!
    @IBOutlet weak var imgViewCity: UIImageView!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var seeMoreColleHeight: NSLayoutConstraint!
    @IBOutlet weak var SeeMoreCollection: UICollectionView!
    @IBOutlet weak var lblDis: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgVirw: CustomImageView!
    let screen = Store.screenType
    var offerTimings: [OfferTiminghome]?
    
    var allRestroListing : AllBarsResto? {
        didSet {
            let imageIndex = (imageURL) + (allRestroListing?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
lblDis.text = "\((allRestroListing?.openTime)?.components(separatedBy: " ").first ?? "") - \((allRestroListing?.closeTime)?.components(separatedBy: " ").first ?? "")"
            lblName.text = allRestroListing?.name?.capitalized ?? ""
            offerTimings = allRestroListing?.offerTimings ?? []
            lblCity.text = allRestroListing?.city ?? ""
            lblLocation.text = allRestroListing?.location ?? ""
            lblRating.text = "\(allRestroListing?.avgRating ?? 0)"
            cosmosView.rating = Double(allRestroListing?.avgRating ?? 0)
            if allRestroListing?.offerTimings?.count == 0{
                seeMoreColleHeight.constant = 0
             }else{
                seeMoreColleHeight.constant = 46
            }
            self.layoutIfNeeded()
        }
    }
    
    var highilyRatedListing : AllBarsResto? {
        didSet {
            let imageIndex = (imageURL) + (highilyRatedListing?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            imgVirw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgVirw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            lblName.text = highilyRatedListing?.name?.capitalized ?? ""
            lblDis.text = "\(highilyRatedListing?.openTime ?? "") - \(highilyRatedListing?.closeTime ?? "")"
            lblCity.text = highilyRatedListing?.city ?? ""
            lblLocation.text = highilyRatedListing?.location ?? ""
            offerTimings = highilyRatedListing?.offerTimings ?? []
            if highilyRatedListing?.offerTimings?.count == 0{
                seeMoreColleHeight.constant = 0
            } else {
                seeMoreColleHeight.constant = 46
            }
            self.layoutIfNeeded()
        }
    }
    
}
extension homeSeeMoreCVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerTimings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerSeeMoreCVC", for: indexPath) as! offerSeeMoreCVC
        if screen == 1 {
            cell.lblName.text = "\(offerTimings?[indexPath.row].offer ?? "") \n -\((offerTimings?[indexPath.row].percentage ?? "0"))%"
            //cell.lblDescription.text = "-\(offerTimings?[indexPath.row].percentage ?? 0)%"
        }else {
            cell.lblName.text = (offerTimings?[indexPath.row].offer ?? "")
        }
        cell.lblDescription.text = ""
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
