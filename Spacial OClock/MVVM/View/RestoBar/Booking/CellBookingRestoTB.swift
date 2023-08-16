//
//  CellBookingRestoTB.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit

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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
