//
//  RestoSettingTVC.swift
//  Spacial OClock
//
//  Created by cql99 on 27/06/23.
//

import UIKit

class RestoSettingTVC: UITableViewCell {
    @IBOutlet weak var imgViewArrow: UIImageView!
    @IBOutlet weak var notificationBtn: UISwitch!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // notificationBtn.transform = CGAffineTransform(scaleX: 0.9 , y: 0.8)
        notificationBtn.transform = CGAffineTransform(scaleX: 1.0 , y: 0.9)

    }
}
