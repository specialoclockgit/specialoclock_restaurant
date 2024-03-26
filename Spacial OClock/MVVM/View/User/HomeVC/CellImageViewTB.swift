//
//  CellImageViewTB.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit
import SDWebImage

class CellImageViewTB: UITableViewCell,UIScrollViewDelegate {
    
    //MARK: Outlet
    @IBOutlet weak var collView : UICollectionView!
    @IBOutlet weak var pgController : UIPageControl!
    var banners : [Banner]?

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
        pgController.numberOfPages = banners?.count ?? 0
        // Configure the view for the selected state
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        pgController.currentPage = Int(index)
    }
    
}
extension CellImageViewTB : UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: Cell.CellImageViewCB, for: indexPath) as! CellImageViewCB
        let imageIndex = (imageBaseURL) + (banners?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collView.frame.width/1 , height: 160)
    }
    
    
}
