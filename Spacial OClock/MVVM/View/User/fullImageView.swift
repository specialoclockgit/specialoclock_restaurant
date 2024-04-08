//
//  fullImageView.swift
//  Spacial OClock
//
//  Created by cqlios on 27/10/23.
//

import UIKit
import SDWebImage

class fullImageView: UIViewController, UIScrollViewDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK: - VARIABLES
    var setImage = String()
    var url = String()
    var settype = Int()
    
    
    //MARK: - VIEW LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        imgView.isUserInteractionEnabled = false
        if settype == 0 {
            let imageIndex = (imageURL) + (self.setImage.replacingOccurrences(of: " ", with: "%20") )
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
        } else if settype == 1 {
            let imageIndex1 = (url) + (self.setImage.replacingOccurrences(of: " ", with: "%20"))
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: imageIndex1), placeholderImage: UIImage(named: "placeholder (1)"))
        } else {
            let imageIndex1 = (productImgURL) + (self.setImage.replacingOccurrences(of: " ", with: "%20"))
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: imageIndex1), placeholderImage: UIImage(named: "placeholder (1)"))
        }
        
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeGesture.direction = [.right, .left, .up, .down]
        self.scrollView.addGestureRecognizer(swipeGesture)
        self.scrollView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDoubleTapped(_:)))
        tapGesture.numberOfTapsRequired = 2
        self.scrollView.addGestureRecognizer(tapGesture)
        
        
    }
    @objc func imageDoubleTapped(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            self.scrollView.zoomScale = 1.0
        }
        
    }
    
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
