//
//  RestoProfileVC.swift
//  Spacial OClock
//
//  Created by cqlios on 01/12/23.
//

import UIKit
import SDWebImage
import Cosmos

class RestoProfileVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var imgThird: UIImageView!
    @IBOutlet weak var imgSecond: UIImageView!
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var profileimgVW: UIImageView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var btnPreview : UIButton!
    @IBOutlet weak var lblname : UILabel!
    @IBOutlet weak var viewPreview : UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var openLocationss: UILabel!
    @IBOutlet weak var lblREview: UILabel!
    
    //MARK: - VARIABLES
    var btnCheckStatus = Int()
    var heading = String()
    var viewmodel  = restoViewModal()
    var datagetApi : RestaurentDetailsModelBody?
    var arrayimage : [RestaurantImage]?
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupAPI()
    }
    
//MARK: - FUNCTION API RESTSURENT DETAILS
    func setupAPI() {
        viewmodel.restaurentDetails { data in
            self.datagetApi = data
            self.lblname.text = data?.name ?? ""
            self.lblDiscription.text = data?.shortDescription ?? ""
            self.openLocationss.text = data?.location ?? ""
            self.lblLocation.text = data?.city ?? ""
            self.lblTime.text =  "\((data?.openTime ?? "").components(separatedBy: " ").first ?? "") - \((String(describing: data?.closeTime ?? "")).components(separatedBy: " ").first ?? "")"
            self.profileimgVW.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.profileimgVW.sd_setImage(with: URL(string: imageURL + (data?.profileImage ?? "")),placeholderImage: UIImage(named: "rectAlbum"))
            self.cosmosView.rating = Double(data?.avgRating ?? 0)
            self.lblREview.text = "\(data?.avgRating ?? 0)"
            self.arrayimage = self.datagetApi?.restaurantImages ?? []
            for i in 0..<(self.arrayimage?.count ?? 0){
                if i == 0{
                    let imgUrl = (imageURL) + (self.arrayimage?[i].image ?? "" )
                    self.imgFirst.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                    self.imgFirst.sd_setImage(with: URL.init(string: imgUrl),placeholderImage:UIImage.init(named: "rectAlbum"), completed: nil)
                }else if i == 1{
                    let imgUrl = (imageURL) + (self.arrayimage?[i].image ?? "" )
                    self.imgSecond.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                    self.imgSecond.sd_setImage(with: URL.init(string: imgUrl),placeholderImage:UIImage.init(named: "rectAlbum"), completed: nil)
                }else if i == 2{
                    let imgUrl = (imageURL) + (self.arrayimage?[i].image ?? "" )
                    self.imgThird.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                    self.imgThird.sd_setImage(with: URL.init(string: imgUrl),placeholderImage:UIImage.init(named: "rectAlbum"), completed: nil)
                }
            }
        }
    }
    //MARK: - EXTENSIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEdit(_ sender: UIButton) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.EditRestoProfileVC) as! EditRestoProfileVC
        if Store.userDetails?.bussinesstype == 1 {
            screen.heading = "Edit Restaurant Profile"
        }else{
            screen.heading = "Edit Bar Profile"
        }
        self.navigationController?.pushViewController(screen, animated: true)
    }
    @IBAction func btnPreviewAct(sender : UIButton){
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let screen = main.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
        screen.ProductID = datagetApi?.id ?? 0
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension RestoProfileVC{
    func initialLoad(){
        if Store.userDetails?.bussinesstype == 1{
            self.lblHeading.text = "Restaurant Profile"
        }else{
            self.lblHeading.text = "Bar Profile"
        }
        debugPrint(heading)
        lblname.text = UserDefaults.standard.name
        btnCheckStatus = UserDefaults.standard.status
        if btnCheckStatus == 0 {
            viewPreview.isHidden = false
        }else if btnCheckStatus == 1{
            viewPreview.isHidden = true
        }
    }
}
