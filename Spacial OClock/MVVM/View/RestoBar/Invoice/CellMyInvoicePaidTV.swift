//
//  CellMyInvoicePaidTV.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit

class CellMyInvoicePaidTV: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var viewPaid : UIView!
    @IBOutlet weak var lblTransactionId : UILabel!
    @IBOutlet weak var lblInvoiceNumber : UILabel!
    @IBOutlet weak var lblInvoiceTime : UILabel!
    @IBOutlet weak var lblInvoiceDate : UILabel!
    @IBOutlet weak var lblTotalAmmount : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewPaid.ViewShadow(cornerRadius: 20.0, shadowColor: .gray, x: 1, y: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
