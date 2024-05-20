//
//  receverTVC.swift
//  Spacial OClock
//
//  Created by cqlios on 27/09/23.
//

import UIKit

class receverTVC: UITableViewCell {

    @IBOutlet weak var receverView: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRecever: UILabel!
    @IBOutlet weak var receverImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        receverView.layer.cornerRadius = 6
        receverView.clipsToBounds = true
        receverView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner]
    }
    
    var receiverData : MessageListModel? {
        didSet {
            lblRecever.text = receiverData?.message ?? ""
            let isoDate =  receiverData?.createdAt ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormatter.date(from: isoDate)
            lblTime.text = date?.toLocalTime().timeAgoSinceDate()
        }
    }
    
}
