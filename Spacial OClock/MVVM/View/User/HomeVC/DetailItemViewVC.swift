//
//  DetailItemViewVC.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit
import SDWebImage

//MARK: Variable image3
var arrModel : [ItemsModel] = []

class DetailItemViewVC: UIViewController  {
    
    //MARK: Outlets
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var imgViewHead: UIImageView!
    
    //MARK: Variables
    var iconImage = String()
    var heading = String()
    var locationName = "India"
    var cusinessID = Int()
    var themeID = Int()
    var viewmodal = HomeViewModel()
    var modal: [CussinesRestoModalBody]?
    var thememodla : [themeListModalBody]?
    var lblName = ""
    var setimage = ""
    var setValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cusinessID)
        lblTwo.text = lblName
        lblOne.text = "\(setValue)> "
        imgViewHead.image = UIImage(named: setimage)
        
         
        if setValue == "Locations"{
            
        }else if setValue == "Cuisines"{
            get_resto_list()
        }else if setValue == "Categorys"{
            
        }else{
            theme_Resto_API()
        }
    }
    //MARK: - CUSINS
    func get_resto_list(){
        viewmodal.cusinsRestoAPI(cuisineid: cusinessID) { [weak self] fetchdata in
            self?.modal = fetchdata
            self?.CollectionView.reloadData()
        }
    }
    
    //MARK: - THEME RESTO
    func theme_Resto_API(){
        viewmodal.themeGetList(themeID: themeID) { [weak self] dataa in
            self?.thememodla = dataa
            self?.CollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}
//MARK: - EXTENTION
extension DetailItemViewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setValue == "Cuisines"{
            return modal?.count ?? 0
        }else {
            return thememodla?.count ?? 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailItemCVC", for: indexPath) as! DetailItemCVC
        if setValue == "Cuisines"{
            let imageIndex = (imageBaseURL) + (modal?[indexPath.row].image ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = modal?[indexPath.row].productName ?? ""
            cell.lblDiscription.text = "Price: \(modal?[indexPath.row].price ?? 0)"
        }else{
            let imageIndex = (imageURL) + (thememodla?[indexPath.row].profileImage ?? "")
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
            cell.lblName.text = thememodla?[indexPath.row].name ?? ""
            cell.lblDiscription.text = "Price: \(modal?[indexPath.row].price ?? 0)"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if setValue == "Cuisines"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = modal?[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

