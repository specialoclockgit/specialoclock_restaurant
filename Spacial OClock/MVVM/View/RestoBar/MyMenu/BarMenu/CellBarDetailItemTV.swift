//
//  CellBarDetailItemTV.swift
//  Spacial OClock
//
//  Created by cql211 on 13/07/23.
//

import UIKit

class CellBarDetailItemTV: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblPrevPrice : UILabel!
    @IBOutlet weak var lblNewPrice : UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    @IBOutlet weak var btnEdit : UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialLoad()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
extension CellBarDetailItemTV{
    func initialLoad(){
        btnDelete.btnShadow(cornerRadius: btnDelete.frame.height / 2, shadowColor: UIColor.lightGray, opacity: 1, x: 1, y: 1)
        btnEdit.btnShadow(cornerRadius: btnEdit.frame.height / 2, shadowColor: UIColor.lightGray, opacity: 1, x: 1, y: 1)
    }
}
