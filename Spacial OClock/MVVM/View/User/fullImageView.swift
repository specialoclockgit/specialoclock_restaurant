//
//  fullImageView.swift
//  Spacial OClock
//
//  Created by cqlios on 27/10/23.
//

import UIKit
import SDWebImage

class fullImageView: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK: - VARIABLES
    var setImage = String()
    var url = String()
    var settype = Int()
    
    //MARK: - VIEW LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
        if settype == 0{
            let imageIndex = (imageURL) + (self.setImage )
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Userssss"))
        }else{
            let imageIndex1 = (url) + (self.setImage)
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: imageIndex1), placeholderImage: UIImage(named: "Userssss"))
        }
        
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
