//
//  FavouritesVC.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit
import SDWebImage
import SwiftGifOrigin
import SkeletonView

class FavouritesVC: UIViewController,SkeletonCollectionViewDataSource,SkeletonCollectionViewDelegate, UIGestureRecognizerDelegate {

    //MARK: - Outlets
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var favouriteCV: UICollectionView!
    @IBOutlet weak var btnBack : UIButton!
    
    //MARK: - Variables
    var arrimg = ["image1","image2","image3","image1"]
    var favViewModal = HomeViewModel()
    var modal : [favListModalBody]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.isHidden = true
        favouriteCV.showAnimatedGradientSkeleton()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        get_list()
    }
    
    // MARK: - Actions
    
    //MARK: - FUNCTIONS
    func get_list(){
        favViewModal.favListAPI { [weak self] dataa in
            self?.modal = dataa?.reversed()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.favouriteCV.hideSkeleton()
            }
            self?.favouriteCV.reloadData()
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FavouritesCell"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
}
 
//MARK: - UICollectionViewDelegateUICollectionViewDataSource
extension FavouritesVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if modal?.count == 0{
            collectionView.setNoDataMessage("No favorites found")
           // imgViewGif.image = UIImage.gif(name: "nodataFound")
           // imgViewGif.isHidden = false
        }else{
            collectionView.backgroundView = nil
          //  imgViewGif.isHidden = true
            return modal?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCell", for: indexPath)as! FavouritesCell
        let imageIndex = (imageURL) + (self.modal?[indexPath.row].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.itemImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.itemImg.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Userssss"))
        cell.lblOpenTime.text = "\(modal?[indexPath.row].openTime ?? "") - " + "\(modal?[indexPath.row].closeTime ?? "")"
        cell.lblNAme.text = modal?[indexPath.row].name ?? ""
//        cell.lblOffer.text = modal?[indexPath.row].
        
        cell.btnImg.addTarget(self, action: #selector(btnfavourite(_:)), for: .touchUpInside)
        cell.btnImg.tag = indexPath.row
//        cell.itemImg.image = UIImage(named: arrimg[indexPath.row])
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
        favViewModal.resto_likeAPI(Restoid: modal?[sender.tag].id ?? 0, status: 0) { data in
            self.get_list()
        }
    }
}


class FavouritesCell:UICollectionViewCell{
    //MARK: - Outlets
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblOpenTime: UILabel!
    @IBOutlet weak var lblNAme: UILabel!
    @IBOutlet weak var itemImg: CustomImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnImg: UIButton!
}
