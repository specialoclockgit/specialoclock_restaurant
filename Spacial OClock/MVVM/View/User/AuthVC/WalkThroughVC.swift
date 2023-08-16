//
//  WalkThroughVC.swift
//  Special O'Clock
//
//  Created by cql197 on 16/06/23.
//

import UIKit

class WalkThroughVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnNexT: UIButton!
    @IBOutlet weak var pgContl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    var imgAray = ["img2","img1","img3"]
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 14.0, *) {
            pgContl.backgroundStyle = .minimal
            pgContl.preferredIndicatorImage = UIImage(named: "pgCntrlIndicator")
        } else {
            // Fallback on earlier versions
        }

    }

    
    //MARK: - ACTIONS
    @IBAction func btnNext(_ sender: UIButton) {
        if sender.titleLabel?.text == "Next"{
            let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            collectionView.isPagingEnabled = false
            
            let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
            let currentIem: IndexPath = visibleItems.object(at: 0) as! IndexPath
            
            if currentIem.item == 1{
            }
            
            self.collectionView.scrollToItem(at: IndexPath(item: currentIem.item + 1, section: 0), at: .right, animated: true)
            
            collectionView.isPagingEnabled = true
        }
    }
}

//MARK: - EXTENSIONS
extension WalkThroughVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgAray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkThroughCell", for: indexPath) as! WalkThroughCell
        cell.imgStart.image = UIImage(named: imgAray[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pgContl.currentPage = indexPath.item
        self.btnNexT.setTitle(indexPath.item == 2 ? "Next" : "", for: .normal)
        self.btnNexT.setImage(indexPath.item == 2 ? UIImage() : UIImage(named: "nextArrow") , for: .normal)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let collectionViewWidth = collectionView.bounds.size.width
        let contentSizeWidth = collectionView.contentSize.width
        let contentOffsetX = scrollView.contentOffset.x
        let targetOffsetX = targetContentOffset.pointee.x
        if contentOffsetX >= (contentSizeWidth - collectionViewWidth) {
            navigateToNewScreen()
        }
    }
    func navigateToNewScreen() {
        let screen =  storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
}

//MARK: - UICollectionViewCell
class WalkThroughCell:UICollectionViewCell{
    @IBOutlet weak var imgStart:UIImageView!
    
}
