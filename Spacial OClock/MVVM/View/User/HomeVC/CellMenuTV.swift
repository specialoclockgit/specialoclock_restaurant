//
//  CellMenuTV.swift
//  Spacial OClock
//
//  Created by cql211 on 29/06/23.
//

import UIKit

class CellMenuTV: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var lblDiscount: UILabel!
    //    @IBOutlet weak var lblHeading : UILabel!
//    @IBOutlet weak var btn : UIButton!
    @IBOutlet weak var viewCell : UIView!
    @IBOutlet weak var itemNameTop : NSLayoutConstraint!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lblItemName : UILabel!
    @IBOutlet weak var lblPrePrice : UILabel!
    @IBOutlet weak var lblNewPrice : UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var dataStackVW: UIStackView!
    @IBOutlet weak var offVw: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
