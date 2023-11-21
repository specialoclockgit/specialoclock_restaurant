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
        if settype == 0{
            let imageIndex = (imageURL) + (self.setImage.replacingOccurrences(of: " ", with: "%20") )
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
        }else if settype == 1{
            let imageIndex1 = (url) + (self.setImage)
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: imageIndex1), placeholderImage: UIImage(named: "placeholder (1)"))
        }else{
            let imageIndex1 = (imageBaseURL) + (self.setImage)
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: imageIndex1), placeholderImage: UIImage(named: "placeholder (1)"))
        }
        
    }
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imgView
        }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
