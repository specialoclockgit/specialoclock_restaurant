//
//  FavouritesVC.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit

class FavouritesVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var favouriteCV: UICollectionView!
    @IBOutlet weak var btnBack : UIButton!
    
    //MARK: - Variables
    var arrimg = ["image1","image2","image3","image1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.isHidden = true
    }
    
    // MARK: - Actions
    
}
 
//MARK: - UICollectionViewDelegateUICollectionViewDataSource
extension FavouritesVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrimg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCell", for: indexPath)as! FavouritesCell
        cell.btnImg.addTarget(self, action: #selector(btnfavourite(_:)), for: .touchUpInside)
        cell.btnImg.tag = indexPath.row
        cell.itemImg.image = UIImage(named: arrimg[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.frame.size.width)/2, height:250)
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.zero
        }
    @objc func btnfavourite(_ sender: UIButton){
        let cell = favouriteCV.cellForItem(at: IndexPath(row: sender.tag, section: 0))as! FavouritesCell
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            cell.img.image = UIImage(named: "red h")
        }else{
            cell.img.image = UIImage(named: "white h")
        }
    }
}


class FavouritesCell:UICollectionViewCell{
    
    //MARK: - Outlets
    @IBOutlet weak var itemImg: CustomImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnImg: UIButton!
    
    
}
