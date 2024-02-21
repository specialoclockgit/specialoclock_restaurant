//
//  MyReviewVC.swift
//  Spacial OClock
//
//  Created by cqlios on 02/07/23.
//

import UIKit
import SDWebImage
import Cosmos
import SwiftGifOrigin

class MyReviewVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var tableVW: UITableView!
    @IBOutlet weak var cosmosVW: CosmosView!
    
    //MARK: - VARIABLES
    var viewmodel = restoViewModal()
    var dataget : [ReviewListingModelBody]?
    var imageView: UIImageView?
    //MARK: - VEIW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupapi()
        
    }
    //MARK: - FUNCTION API REVIEW
    func setupapi(){
        viewmodel.reviewListing(restoid: Store.userDetails?.bussiness_id ?? 91) { data in
            self.dataget = data
            self.tableVW.reloadData()
//            if self.dataget?.count == 0 {
//                self.showBackgroundGIF()
//                
//            } else {
//                self.removeBackgroundGIF()
//                
//            }
        }
    }
    //MARK: - ACTIONS
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - FUNCTION NO DATA FOUND
    func showBackgroundGIF() {
        let gifURL = Bundle.main.url(forResource: "NodataFound", withExtension: "gif") // Replace "noDataGif" with the name of your GIF file
        
        if let gifURL = gifURL, let gifData = try? Data(contentsOf: gifURL), let source = CGImageSourceCreateWithData(gifData as CFData, nil) {
            let frameCount = CGImageSourceGetCount(source)
            var images: [UIImage] = []
            
            for i in 0..<frameCount {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    let uiImage = UIImage(cgImage: cgImage)
                    images.append(uiImage)
                }
            }
            
            imageView = UIImageView(frame: tableVW.bounds)
            imageView?.animationImages = images
            imageView?.animationDuration = TimeInterval(frameCount) * 0.1 // Adjust the animation speed if needed
            imageView?.animationRepeatCount = 0 // Repeat indefinitely
            imageView?.contentMode = .scaleAspectFit
            imageView?.startAnimating()
            
            tableVW.backgroundView = imageView
            tableVW.separatorStyle = .none
        }
    }
    
    func removeBackgroundGIF() {
        imageView?.stopAnimating()
        tableVW.backgroundView = nil
        tableVW.separatorStyle = .singleLine
    }
}
//MARK: - EXTENSIONS
extension MyReviewVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataget?.count == 0{
            tableView.setNoDataMessage("No review found", txtColor: .black)
           // imgViewGif.image = UIImage.gif(name: "nodataFound")
            //imgViewGif.isHidden = false
        }else{
            tableView.backgroundView = nil
            //imgViewGif.isHidden = true
            return dataget?.count ?? 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyReviewTVC", for: indexPath) as! MyReviewTVC
        cell.lblName.text = dataget?[indexPath.row].user?.name ?? ""
        cell.lblDis.text = dataget?[indexPath.row].review ?? ""
        cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.imgView.sd_setImage(with: URL(string: imageURL + (dataget?[indexPath.row].user?.image?.replacingOccurrences(of: " ", with: "%20") ?? "")),placeholderImage: UIImage(named: "pl"))
        cell.cosmosView.rating  = Double(dataget?[indexPath.row].rating ?? "") ?? 0
        return cell
    }
}
