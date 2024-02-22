//
//  mapViewCVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 19/02/24.
//

import UIKit
import SDWebImage

class mapViewCVC: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblReservations: UILabel!
    @IBOutlet weak var lbldesc: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    
    
    var listing : NearbyRestaurant?{
        didSet {
           // lblRating.text = listing?.distance?.description ?? ""
            lblName.text = listing?.name ?? ""
            lbldesc.text = listing?.offerDescription ?? ""
            lblReservations.text  = "\(listing?.openTime ?? "") - \(listing?.closeTime ?? "")"
            let imageIndex = (imageURL) + (listing?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            imgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgVw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
        }
    }
    
}
