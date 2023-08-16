//
//  CellMyInvoicePendingTV.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit

class CellMyInvoicePendingTV: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var viewPending : UIView!
    @IBOutlet weak var lblInvoiceNumber : UILabel!
    @IBOutlet weak var lblInvoiceTime : UILabel!
    @IBOutlet weak var lblInvoiceDate : UILabel!
    @IBOutlet weak var lblTotalAmmount : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewPending.ViewShadow(cornerRadius: 20.0, shadowColor: .gray, x: 1, y: 1)
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
