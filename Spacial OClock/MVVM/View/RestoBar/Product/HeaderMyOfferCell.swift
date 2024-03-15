//
//  HeaderMyOfferCell.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit

class HeaderMyOfferCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var viewHeader : UIView!
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var lblSubHeading : UILabel!
    @IBOutlet weak var lblTimming : UILabel!
    @IBOutlet weak var btnHeader : UIButton!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var flagImgVw: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
