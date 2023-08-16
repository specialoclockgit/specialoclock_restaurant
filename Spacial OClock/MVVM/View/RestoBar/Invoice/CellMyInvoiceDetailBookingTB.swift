//
//  CellMyInvoiceDetailBookingTB.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit

class CellMyInvoiceDetailBookingTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblBookingNumber : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
