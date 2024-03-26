//
//  Created by apple on 19/05/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {

    func setUserImage(_ url: URL!) {
        if url != nil {
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_imageIndicator?.startAnimatingIndicator()
            self.sd_setImage(with: url,placeholderImage: UIImage(named: "user")) { (img, err, type, urll) in
                self.sd_imageIndicator?.stopAnimatingIndicator()
            }
           // sd_setImage(with: url!, placeholderImage: UIImage(named: "user"))
           // self.sd_imageIndicator?.stopAnimatingIndicator()
        } else {
            image = #imageLiteral(resourceName: "image1")
        }
    }
    
    
    func showIndicator(baseUrl:String,imageUrl:String){
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_imageIndicator?.startAnimatingIndicator()
        print("image \(baseUrl + imageUrl)")
        self.sd_setImage(with: URL(string:baseUrl + imageUrl.replacingOccurrences(of: " ", with: "%20")),placeholderImage: UIImage(named: "placeholder (1)")) { (img, err, type, urll) in
                if img == nil{
                    print("Error is",err)
                    self.backgroundColor = .gray
                }
                self.sd_imageIndicator?.stopAnimatingIndicator()
            }
        }
    
    //,options: .forceTransition
//    func Setvideo(_ url: videourl!) {
//        if url != nil {
//            self.sd_imageIndicator?.startAnimatingIndicator()
//            sd_setImage(with: url!, placeholderImage: UIImage(named: "user"))
//            self.sd_imageIndicator?.stopAnimatingIndicator()
//        } else {
//            image = #imageLiteral(resourceName: "Group 2271")
//        }
//    }
    
    

    func setURL(_ url: URL!) {
        if url != nil {
            sd_setImage(with: url!, placeholderImage: UIImage(named: "user"))
        } else {
            image = #imageLiteral(resourceName: "Unknown")
        }
    }

    func setURLString(_ urlString: String) {
        let url = URL(string: urlString)
        if url != nil {
           sd_setImage(with: url!, placeholderImage: UIImage(named: "user"))
        } else {
            image = #imageLiteral(resourceName: "Group 2267")
        }
    }

}


