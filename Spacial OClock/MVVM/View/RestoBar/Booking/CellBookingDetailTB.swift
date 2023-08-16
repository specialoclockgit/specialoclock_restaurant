//
//  CellBookingDetailTB.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit

class CellBookingDetailTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lblItemName : UILabel!
    @IBOutlet weak var lblPrevPrice : UILabel!
    @IBOutlet weak var lblNewPrice : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
