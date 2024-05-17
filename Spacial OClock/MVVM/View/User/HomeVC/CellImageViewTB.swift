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
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collView.isPagingEnabled = true
        let nib = UINib(nibName: Cell.CellImageViewCB, bundle: nil)
        self.collView.register(nib, forCellWithReuseIdentifier: Cell.CellImageViewCB)
        collView.delegate = self
        collView.dataSource = self
    }
    
    func initializeBannerData(resp:[Banner]?){
        self.banners = resp
        pgController.numberOfPages = resp?.count ?? 0
        collView.reloadData()
        self.startTimer()
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollCollectionView), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func scrollCollectionView() {
        guard let collView = collView else {
            return
        }
        
        let contentOffset = collView.contentOffset
        let boundsWidth = collView.bounds.size.width
        
        var nextPage = Int(contentOffset.x / boundsWidth) + 1
        if nextPage >= collView.numberOfItems(inSection: 0) {
            nextPage = 0
        }
        let newOffset = CGPoint(x: CGFloat(nextPage) * boundsWidth, y: contentOffset.y)
        collView.setContentOffset(newOffset, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = (scrollView.frame.width) - (scrollView.contentInset.left * 2)
        let index = (scrollView.contentOffset.x) / width
        pgController.currentPage = Int(index)
    }
    
}
extension CellImageViewTB : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collView.dequeueReusableCell(withReuseIdentifier: Cell.CellImageViewCB, for: indexPath) as? CellImageViewCB else { return UICollectionViewCell() }
        let imageIndex = (imageBaseURL) + (banners?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collView.frame.width/1 , height: 240)
    }
    
}
