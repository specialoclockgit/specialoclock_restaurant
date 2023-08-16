//
//  CellBreakfastTB.swift
//  Spacial OClock
//
//  Created by cql211 on 03/07/23.
//

import UIKit

class CellBreakfastTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblPrevPrice : UILabel!
    @IBOutlet weak var lblNewPrice : UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    @IBOutlet weak var btnEdit : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        initialLoad()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension CellBreakfastTB{
    func initialLoad(){
        btnDelete.btnShadow(cornerRadius: btnDelete.frame.height / 2, shadowColor: UIColor.lightGray, opacity: 1, x: 1, y: 1)
        btnEdit.btnShadow(cornerRadius: btnEdit.frame.height / 2, shadowColor: UIColor.lightGray, opacity: 1, x: 1, y: 1)
    }
}
