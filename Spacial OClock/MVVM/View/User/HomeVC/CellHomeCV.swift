//
//  CellHomeCV.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit
protocol  CellHomeCVDelegate {
    func btnNextTag(sender : UIButton)
}

class CellHomeCV: UICollectionViewCell {

    //MARK: Outlets
    @IBOutlet weak var imgLocaiton : UIImageView!
    @IBOutlet weak var lblLocationName : UILabel!
    @IBOutlet weak var lblTotalRestaurant : UILabel!
    @IBOutlet weak var btnNext : UIButton!
    
    //MARK: Variables
     var cellDelegate  : CellHomeCVDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // initialLoad()
        // Initialization code
    }
    @IBAction func btnNectAct(sender : UIButton){
        cellDelegate?.btnNextTag(sender: sender)
        switch sender.tag{
        case 0 :
            debugPrint("Case 0 Run")
        
        default :
            debugPrint("Default Run")
        }
    }
}

