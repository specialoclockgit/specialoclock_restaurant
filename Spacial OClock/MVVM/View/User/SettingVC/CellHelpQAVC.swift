//
//  CellHelpQAVC.swift
//  Spacial OClock
//
//  Created by cql211 on 29/06/23.
//

import UIKit

class CellHelpQAVC: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var viewCell : UIView!
    @IBOutlet weak var lblHeading : UILabel!
   // @IBOutlet weak var viewAnswer : UIView!
    @IBOutlet weak var lblAnswer : UILabel!
    @IBOutlet weak var btnShow : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCell.ViewShadow(cornerRadius: 10.0, shadowColor: UIColor.gray, x: 1, y: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
