//
//  CellMenuCV.swift
//  Spacial OClock
//
//  Created by cql211 on 29/06/23.
//

import UIKit

class CellMenuCV: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var viewMenu : UIView!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lblMenuSchedule : UILabel!
    @IBOutlet weak var lblSpecial : UILabel!
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var lblOffer : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialLoad()
    }

}
extension CellMenuCV {
    func initialLoad(){
        lblTime.lblCornerRadius(cornerRadius: 10.0)
        lblOffer.lblCornerRadius(cornerRadius: lblOffer.frame.height / 2)
    }
}

