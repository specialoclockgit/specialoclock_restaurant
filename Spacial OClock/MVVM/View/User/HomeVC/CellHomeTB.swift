//
//  CellHomeTB.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit
struct CellModel {
    var image : UIImage
    var locationNmae  : String
    var totalRestaurant : String
}
class CellHomeTB: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnSeeMore : UIButton!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var collView : UICollectionView!
    
    //MARK: Variables
    var isCellSelected = Bool()
    var iconString = String()
    var heading = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let nib = UINib(nibName: Cell.CellHomeCV, bundle: nil)
        self.collView.register(nib, forCellWithReuseIdentifier: Cell.CellHomeCV)
        collView.delegate = self
        collView.dataSource = self
//        isCellSelected = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
extension CellHomeTB : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHomeTBModel[collView.tag].img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: Cell.CellHomeCV, for: indexPath) as! CellHomeCV
        cell.imgLocaiton.image = UIImage(named: arrHomeTBModel[collView.tag].img[indexPath.row]) //arrLocation[indexPath.row].image
        cell.lblLocationName.text = arrHomeTBModel[collView.tag].name[indexPath.row]
        cell.lblTotalRestaurant.text = arrHomeTBModel[collView.tag].restoClub[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195.0, height: 208.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let tag = collView.tag
        //debugPrint(tag)
        openDetailVC()
    }
    
    
}
extension CellHomeTB {
    func openDetailVC(){
        let tag = collView.tag
        let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
       
        switch tag{
        case 0 :
            arrModel = [ItemsModel(img: UIImage(named: "location1") ?? UIImage(), name: "Central Cape Town", totalRestaurant: "32 Restaurants"),
                        ItemsModel(img: UIImage(named: "location2") ?? UIImage(), name: "Rondebosch", totalRestaurant: "32 Restaurants") ,
                        ItemsModel(img: UIImage(named: "location1") ?? UIImage(), name: "Central Cape Town", totalRestaurant: "7 Restaurants")
                       ]
        case 1:
            debugPrint("Case 1")
            if isCellSelected == true {
                debugPrint("Not Selected")
                arrModel = [ItemsModel(img: UIImage(named: "image3") ?? UIImage(), name: "Pies N’ Thighs", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "image4") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "image1") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "yummy") ?? UIImage(), name: "Yummy In The Tummy", totalRestaurant: "10:00- 22:00 30%"),
                            ItemsModel(img: UIImage(named: "tanic") ?? UIImage(), name: "Thai Tanic", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "mozarella") ?? UIImage(), name: "Bella Bella Mozzarella", totalRestaurant: "10:00- 22:00 30%")]
                vc.locationName = "India"
            }else{
                debugPrint("Selected")
                arrModel = [ItemsModel(img: UIImage(named: "drinkImg1") ?? UIImage(), name: "Wise Crax’ Brews", totalRestaurant: "") ,
                            ItemsModel(img: UIImage(named: "drinkImg2") ?? UIImage(), name: "Bangin’ Brews", totalRestaurant: ""),
                            ItemsModel(img: UIImage(named: "drink1") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "") ,
                            ]
                vc.locationName = "Cocktail bar"
            }
        case 3:
            arrModel = []
            debugPrint("Case 3")
        default :
            debugPrint("CellHomeTB Default run")
        }
        vc.iconImage = iconString
        vc.heading = heading
       
    super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
