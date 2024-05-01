//
//  mapViewCVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 19/02/24.
//

import UIKit
import SDWebImage

class mapViewTVC: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTiming: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var collVw: UICollectionView!
    
    var offerTimings: [OfferTiminghome]?
    var callBack: ((Int)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        collVw.delegate = self
        collVw.dataSource = self
        let nib = UINib(nibName: "HomeOfferCVC", bundle: nil)
        collVw.register(nib, forCellWithReuseIdentifier: "HomeOfferCVC")
    }
    
    var listing : NearbyRestaurant?{
        didSet {
            lblName.text = (listing?.name?.capitalized ?? "")
            lblLocation.text = listing?.location ?? ""
            lblTiming.text = "\(listing?.openTime ?? "") - \(listing?.closeTime ?? "")"
            offerTimings = listing?.offer_timings ?? []
            collVw.reloadData()
            //let imageIndex = (imageURL) + (listing?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
           // imgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            //imgVw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
        }
    }
    
}
extension mapViewTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(3, self.offerTimings?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collVw.dequeueReusableCell(withReuseIdentifier: "HomeOfferCVC", for: indexPath) as? HomeOfferCVC else {
            return UICollectionViewCell()
            
        }
        let celldata = self.offerTimings?[indexPath.row]
        cell.titleLbl.text = Store.screenType == 1 ? "\(celldata?.offer ?? "") \n\("-\(celldata?.percentage ?? "0")%")" : (celldata?.offer ?? "")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBack?(self.offerTimings?[indexPath.row].id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 3) - 6, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    

}
