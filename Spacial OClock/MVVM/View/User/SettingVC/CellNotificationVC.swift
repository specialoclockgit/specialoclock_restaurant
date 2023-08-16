//
//  CellNotificationVC.swift
//  Spacial OClock
//
//  Created by cql211 on 29/06/23.
//

import UIKit

class CellNotificationVC: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var viewCell : UIView!
    @IBOutlet weak var imgUser : UIImageView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblMessage : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCell.ViewShadow(cornerRadius: 20.0, shadowColor: .systemGray, x: 1, y: 1)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
