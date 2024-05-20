//
//  senderTVC.swift
//  Spacial OClock
//
//  Created by cqlios on 27/09/23.
//

import UIKit

class senderTVC: UITableViewCell {

    @IBOutlet weak var senderView: UIView!
    @IBOutlet weak var lblSenderTime: UILabel!
    @IBOutlet weak var lblSenderMsg: UILabel!
    @IBOutlet weak var senderImgView: UIImageView!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        senderView.layer.cornerRadius = 6
        senderView.clipsToBounds = true
        senderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner]
    }
    
    var senderData :  MessageListModel? {
        didSet {
            lblSenderMsg.text = senderData?.message ?? ""
            let isoDate =  senderData?.createdAt ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormatter.date(from: isoDate)
            lblSenderTime.text = date?.toLocalTime().timeAgoSinceDate()
        }
    }
     
}
