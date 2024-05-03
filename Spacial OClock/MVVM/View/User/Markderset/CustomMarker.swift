//
//  CustomMarker.swift
//  Capturise
//
//  Created by apple on 23/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CustomMarker: UIView {

    @IBOutlet weak var lblPersot: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collVw: UICollectionView!
    @IBOutlet weak var restroName: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var timingLbl: UILabel!
    @IBOutlet weak var detailVw: UIView!
    @IBOutlet weak var providerImageView: UIImageView!
    @IBOutlet weak var restroImgVw: UIImageView!
    @IBOutlet weak var offerLbl: UILabel!
    var dataBody: NearbyRestaurant?
    var callBack: (()->())?
    override func awakeFromNib() {
        let nib = UINib(nibName: "HomeOfferCVC", bundle: nil)
        collVw.register(nib, forCellWithReuseIdentifier: "HomeOfferCVC")
    }
     
    
    func setupData(body:NearbyRestaurant?){
        restroImgVw.showIndicator(baseUrl: imageURL, imageUrl: body?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
        restroName.text = body?.name ?? ""
        locationLbl.text = body?.location ?? ""
        timingLbl.text = "\(body?.openTime ?? "")-\(body?.closeTime ?? "")"
        if let offerData = body?.time_slots?.sorted(by: {$0.startTime ?? "" < $1.startTime ?? ""}), offerData.count > 0 {
            if offerData.last?.isFifty == 1 {
                offerLbl.text = "50%"
            } else if offerData.last?.custom_discount != 0 {
                offerLbl.text = "\(offerData.last?.custom_discount ?? 0)%"
            }else {
                offerLbl.text = "\(offerData.last?.offer?.offerPrice ?? "0")%"
            }
            
        }
       // self.dataBody = body
       // self.collVw.reloadData()
    }
    
    
    
}
//extension CustomMarker: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return min(3, self.dataBody?.offer_timings?.count ?? 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collVw.dequeueReusableCell(withReuseIdentifier: "HomeOfferCVC", for: indexPath) as? HomeOfferCVC else { return UICollectionViewCell() }
//        cell.titleLbl.font = UIFont(name: "Poppins-Medium", size: 9)
//        let celldata = self.dataBody?.offer_timings?[indexPath.row]
//        
//        if Store.screenType == 1 {
//            if celldata?.is_fifty == 1 {
//                cell.titleLbl.text = "\(celldata?.offer ?? "") \n\("-\(50)%")"
//            } else {
//                cell.titleLbl.text = "\(celldata?.offer ?? "") \n\("-\(celldata?.percentage ?? "0")%")"
//            }
//        }else {
//            cell.titleLbl.text =  (celldata?.offer ?? "")
//        }
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (26), height: 40)
//    }
//    
//}

