//
//  CellImageViewTB.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit

class CellImageViewTB: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var collView : UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let nib = UINib(nibName: Cell.CellImageViewCB, bundle: nil)
        self.collView.register(nib, forCellWithReuseIdentifier: Cell.CellImageViewCB)
        collView.delegate = self
        collView.dataSource = self
        // Configure the view for the selected state
    }
    
}
extension CellImageViewTB : UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: Cell.CellImageViewCB, for: indexPath) as! CellImageViewCB
        cell.img.image = UIImage(named:  "banner")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collView.frame.width , height: 80.0)
    }
    
    
}
