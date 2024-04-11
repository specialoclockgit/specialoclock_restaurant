//
//  MultiImageVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 29/03/24.
//

import UIKit
import SDWebImage

class MultiImageVC: UIViewController, UIScrollViewDelegate  {
    @IBOutlet weak var collVw: UICollectionView!
    var imgArr = [String]()
    var index = 0
    @IBOutlet weak var pgController : UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        pgController.numberOfPages = imgArr.count
        collVw.delegate = self
        collVw.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let index = IndexPath(row: self.index, section: 0)
            self.collVw.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        }
    }
    
    @IBAction func btnBack (_ sender :  UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        pgController.currentPage = Int(index)
    }
    

    
    
    
}
extension MultiImageVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiImageCVC", for: indexPath) as? MultiImageCVC else {
            return UICollectionViewCell()
        }
        let imageIndex = (imgArr[indexPath.row].replacingOccurrences(of: " ", with: "%20") )
        cell.imgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgVw.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 1, height: collectionView.frame.size.height)
    }
    
}
class MultiImageCVC : UICollectionViewCell {
    @IBOutlet weak var imgVw : UIImageView!
    private var scale: CGFloat = 1.0
    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 3.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        imgVw.addGestureRecognizer(pinchGesture)
        imgVw.isUserInteractionEnabled = true
    }
    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        if gestureRecognizer.state == .changed {
            let newScale = scale * gestureRecognizer.scale
            if newScale >= minScale && newScale <= maxScale {
                scale = newScale
                UIView.animate(withDuration: 0.2) {
                    self.imgVw.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                }
            }
            gestureRecognizer.scale = 1.0
        }
    }
    
}
