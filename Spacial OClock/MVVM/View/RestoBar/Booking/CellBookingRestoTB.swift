//
//  CellBookingRestoTB.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit
import SDWebImage
class CellBookingRestoTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var viewDetail : UIView!
    @IBOutlet weak var imgUser : UIImageView!
    @IBOutlet weak var lblUserIndex : UILabel!
    @IBOutlet weak var lblStatus : UILabel!
    @IBOutlet weak var lblBookingID : UILabel!
    @IBOutlet weak var lblBookingTime : UILabel!
    @IBOutlet weak var lblBookingDate : UILabel!
    @IBOutlet weak var lblBookingIDHeading : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewDetail.ViewShadow(cornerRadius: 20.0, shadowColor: .systemGray5, x: 1, y: 1)
        
    }

    var bookingListing : rstoCurrentModalBody? {
        didSet {
            if bookingListing?.status == 0 {
                lblStatus.text = "Ongoing"
                lblStatus.textColor = UIColor(named: "themeAlert")
                lblBookingIDHeading.text = "Booking Number:"
            } else if bookingListing?.status == 1 {
                lblStatus.text = "Completed"
                lblStatus.textColor = UIColor(named: "themeGreen")
                lblBookingIDHeading.text = "Booking Id:"
            } else {
                lblStatus.text = "Cancelled"
                lblStatus.textColor = UIColor(named: "themeAlert")
            }
            let imageIndex = (imageURL) + (bookingListing?.userImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
            imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgUser.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Default_Image"))
            lblUserIndex.text = bookingListing?.userName ?? ""
            lblBookingID.text = bookingListing?.bookingID
            lblBookingDate.text = bookingListing?.bookingDate
            
            if bookingListing?.restroType == 1 {
                lblBookingTime.text = bookingListing?.bookingSlot ?? ""
            } else {
                lblBookingTime.text = "\(bookingListing?.offer?.openTime ?? "")-\(bookingListing?.offer?.closeTime ?? "")"
            }
        
        }
    }
    
}
