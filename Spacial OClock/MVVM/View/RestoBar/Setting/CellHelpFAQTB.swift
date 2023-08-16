//
//  CellHelpFAQTB.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit

class CellHelpFAQTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var Vw: UIView!
    @IBOutlet weak var btnHideShow : UIButton!
    @IBOutlet weak var lblContent : UILabel!
    @IBOutlet weak var lblQuestionHeading : UILabel!
    @IBOutlet weak var stackView : UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
