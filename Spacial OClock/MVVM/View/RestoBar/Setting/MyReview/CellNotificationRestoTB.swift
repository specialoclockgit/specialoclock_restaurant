//
//  CellNotificationRestoTB.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit

class CellNotificationRestoTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var imgUser : UIImageView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblNotificationMessage : UILabel!
    @IBOutlet weak var lblDay : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.layer.cornerRadius = imgUser.frame.height / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
