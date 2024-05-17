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
    @IBOutlet weak var blurImgVW: UIImageView!
    @IBOutlet weak var collVw: UICollectionView!
    @IBOutlet weak var collHeight: NSLayoutConstraint!
    @IBOutlet weak var offerImg3: UIImageView!
    @IBOutlet weak var offerImg2: UIImageView!
    @IBOutlet weak var offerImg1: UIImageView!
    @IBOutlet weak var viewOffer3: UIView!
    @IBOutlet weak var viewOffer2: UIView!
    @IBOutlet weak var viewOffer1: UIView!
    @IBOutlet weak var lblOffer3: UILabel!
    @IBOutlet weak var lblOffer2: UILabel!
    @IBOutlet weak var lblOffer1: UILabel!
    @IBOutlet weak var lblTime3: UILabel!
    @IBOutlet weak var lblTime2: UILabel!
    @IBOutlet weak var lblTime1: UILabel!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var viewReview: UIView!
    @IBOutlet weak var imgLocaiton : UIImageView!
    @IBOutlet weak var lblLocationName : UILabel!
    @IBOutlet weak var lblTotalRestaurant : UILabel!
    @IBOutlet weak var btnNext : UIButton!
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var lblRestName : UILabel!
    @IBOutlet weak var lblRestLoc :  UILabel!
    @IBOutlet weak var lblRestTiming: UILabel!
    //MARK: Variables
     var cellDelegate  : CellHomeCVDelegate?
    var offerTimings: [TimeSlotoffer]?
    
    var callBack: ((Int)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
      
       // bgView.applyBlurEffect(.dark)
        stackHeight.constant = 0
        viewReview.layer.cornerRadius = 10
       // viewReview.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMaxXMaxYCorner]
        let nib = UINib(nibName: "HomeOfferCVC", bundle: nil)
        collVw.register(nib, forCellWithReuseIdentifier: "HomeOfferCVC")
       // initialLoad()
        // Initialization code
    }
    @IBAction func btnNectAct(sender : UIButton){
        cellDelegate?.btnNextTag(sender: sender)
        switch sender.tag {
        case 0 :
            debugPrint("Case 0 Run")
        
        default :
            debugPrint("Default Run")
        }
    }
}

extension CellHomeCV : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.offerTimings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collVw.dequeueReusableCell(withReuseIdentifier: "HomeOfferCVC", for: indexPath) as? HomeOfferCVC else {
            return UICollectionViewCell()
            
        }
        if Store.screenType == 1 {
         //   cell.titleLbl.font = UIFont(name: "Poppins-Medium", size: 12.0)
            var percentage = String()
            if offerTimings?[indexPath.row].isFifty == 1 {
                percentage = "-\(50)%"
            } else if offerTimings?[indexPath.row].custom_discount != 0 {
                percentage = "-\(offerTimings?[indexPath.row].custom_discount ?? 0)%"
            } else {
                percentage = "-\(offerTimings?[indexPath.row].offer?.offerPrice ?? "0")%"
            }
            cell.titleLbl.text = "\((offerTimings?[indexPath.row].startTime?.components(separatedBy: " ").first ?? ""))\n\(percentage)"
        } else {
          //  cell.titleLbl.font = UIFont(name: "Poppins-Medium", size: 9.0)
            cell.titleLbl.text = "\(offerTimings?[indexPath.row].offer?.openTime ?? "")-\(offerTimings?[indexPath.row].offer?.closeTime ?? "")"
        }
        
      
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBack?(self.offerTimings?[indexPath.row].slot_id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if Store.screenType == 1 {
            return CGSize(width: (collectionView.frame.size.width / 4) - 6, height: 60)
        }else {
            return CGSize(width: (collectionView.frame.size.width / 3) - 6, height: 60)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 6
//    }
    
}
