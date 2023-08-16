//
//  CellItemDetailReviewTB.swift
//  Spacial OClock
//
//  Created by cql211 on 28/06/23.
//

import UIKit

class CellItemDetailReviewTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lblReview : UILabel!
    @IBOutlet weak var lblName : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
