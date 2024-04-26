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
    var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: Cell.CellImageViewCB, bundle: nil)
        self.collView.register(nib, forCellWithReuseIdentifier: Cell.CellImageViewCB)
        collView.delegate = self
        collView.dataSource = self
        
    }

    func initializeBannerData(resp:[Banner]?){
        self.banners = resp
        pgController.numberOfPages = resp?.count ?? 0
        collView.reloadData()
        if let bannersCount = resp?.count, bannersCount > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.startTimer()
            }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        }
        
        @objc func autoScroll() {
            guard let bannersCount = banners?.count, bannersCount > 0 else {
                return
            }
            
            let desiredOffset = CGPoint(x: collView.contentOffset.x + collView.frame.width, y: collView.contentOffset.y)
            collView.setContentOffset(desiredOffset, animated: true)
        }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        pgController.currentPage = Int(index)
        currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            if currentIndex == (banners?.count ?? 0) - 1 && scrollView.contentOffset.x > CGFloat(currentIndex) * scrollView.frame.size.width {
                collView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
            }
    }
    
}
extension CellImageViewTB : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
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
        return CGSize(width:collView.frame.width/1 , height: 240)
    }
    
}
