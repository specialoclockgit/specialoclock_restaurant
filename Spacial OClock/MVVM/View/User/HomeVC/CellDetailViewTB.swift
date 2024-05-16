////
////  CellDetailViewTB.swift
////  Spacial OClock
////
////  Created by cql211 on 27/06/23.
////
//
//import UIKit
//import CoreMedia
//struct ItemsModel{
//    var img : UIImage
//    var name : String
//    var totalRestaurant : String
//}
//
//class CellDetailViewTB: UITableViewCell {
//
//    //MARK: Outlet
//    @IBOutlet weak var btnCountry : UIButton!
//    @IBOutlet weak var collView : UICollectionView!
//    @IBOutlet weak var lblHeading : UILabel!
//    @IBOutlet weak var imgItemICon : UIImageView!
//    
//    //MARK: Variable image3
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        let nib = UINib(nibName: Cell.CellHomeCV, bundle: nil)
//        self.collView.register(nib, forCellWithReuseIdentifier: Cell.CellHomeCV)
//        collView.delegate = self
//        collView.dataSource = self
//        
//    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//    
//}
//extension CellDetailViewTB : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return arrModel.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collView.dequeueReusableCell(withReuseIdentifier: Cell.CellHomeCV, for: indexPath) as! CellHomeCV
//        cell.imgLocaiton.image = arrModel[indexPath.row].img
//        cell.lblLocationName.text = arrModel[indexPath.row].name.capitalized
//        cell.lblTotalRestaurant.text = arrModel[indexPath.row].totalRestaurant
//        cell.btnNext.tag = indexPath.row
//        cell.btnNext.addTarget(self, action: #selector(btnnextClick), for: .touchUpInside)
//        return cell
//    }
//    @objc func btnnextClick (_ sender:UIButton){
//        
//        let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.ItemDetailsVC) as! ItemDetailsVC
//        vc.imgName = arrModel[sender.tag].img
//        super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collView.frame.width / 2, height: 200)
//    }
//}
//
