//
//  CellMyOfferTB.swift
//  Spacial OClock
//
//  Created by cql211 on 04/07/23.
//

import UIKit

class CellMyOfferTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var lblItemTitle : UILabel!
 

    override func awakeFromNib() {
        super.awakeFromNib()
        initialLoad()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CellMyOfferTB {
    func initialLoad(){
//        btnDelete.btnShadow(cornerRadius: btnDelete.frame.height / 2, shadowColor: UIColor.lightGray, opacity: 1, x: 1, y: 1)
//        btnEdit.btnShadow(cornerRadius: btnEdit.frame.height / 2, shadowColor: UIColor.lightGray, opacity: 1, x: 1, y: 1)
    }
}
