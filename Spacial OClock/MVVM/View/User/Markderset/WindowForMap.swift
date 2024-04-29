//
//  WindowForMap.swift
//  Spacial OClock
//
//  Created by cqlm2 on 23/04/24.
//

import UIKit

class WindowForMap: UIView {
   
    @IBOutlet weak var collVw: UICollectionView!
    @IBOutlet weak var restroName: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var timingLbl: UILabel!
    
    var dataBody: NearbyRestaurant?
    override func awakeFromNib() {
        let nib = UINib(nibName: "HomeOfferCVC", bundle: nil)
        collVw.register(nib, forCellWithReuseIdentifier: "HomeOfferCVC")
    }
     
    
    func setupData(body:NearbyRestaurant?){
        self.collVw.delegate = self
        self.collVw.dataSource = self
        restroName.text = body?.name ?? ""
        locationLbl.text = body?.location ?? ""
        timingLbl.text = "\(body?.openTime ?? "")-\(body?.closeTime ?? "")"
        self.dataBody = body
        self.collVw.reloadData()
    }

}
extension WindowForMap: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(3, self.dataBody?.offer_timings?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collVw.dequeueReusableCell(withReuseIdentifier: "HomeOfferCVC", for: indexPath) as? HomeOfferCVC else { return UICollectionViewCell() }
        cell.titleLbl.font = UIFont(name: "Poppins-Medium", size: 8)
        let celldata = self.dataBody?.offer_timings?[indexPath.row]
        
        if Store.screenType == 1 {
            if celldata?.is_fifty == 1 {
                cell.titleLbl.text = "\(celldata?.offer ?? "") \n\("-\(50)%")"
            } else {
                cell.titleLbl.text = "\(celldata?.offer ?? "") \n\("-\(celldata?.percentage ?? "0")%")"
            }
        }else {
            cell.titleLbl.text =  (celldata?.offer ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (26), height: 40)
    }
    
}
