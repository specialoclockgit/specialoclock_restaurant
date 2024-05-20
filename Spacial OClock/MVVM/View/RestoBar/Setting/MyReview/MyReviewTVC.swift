//
//  MyReviewTVC.swift
//  Spacial OClock
//
//  Created by cqlios on 03/07/23.
//

import UIKit
import Cosmos
import SDWebImage
class MyReviewTVC: UITableViewCell {
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var lblDis: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var listing : ReviewListingModelBody? {
        didSet {
            lblName.text = listing?.user?.name?.capitalized ?? ""
            lblDis.text = listing?.review ?? ""
            imgView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            imgView.sd_setImage(with: URL(string: imageURL + (listing?.user?.image?.replacingOccurrences(of: " ", with: "%20") ?? "")),placeholderImage: UIImage(named: "pl"))
            cosmosView.rating  = Double(listing?.rating ?? "0") ?? 0
        }
    }
    
}
