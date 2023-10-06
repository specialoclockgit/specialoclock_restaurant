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
    var location = [HomeListLocation]()
    var cuisine = [Cuisine]()
    var themeArr = [ThemeData]()
    var category = [Category]()
    
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
extension CellHomeTB : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collView.tag == 0 {
            return location.count
        }else if collView.tag == 1 {
            if self.isCellSelected == true {
                return cuisine.count
            }else {
                return category.count
            }
            
        }else if collView.tag == 3{
            return themeArr.count
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: Cell.CellHomeCV, for: indexPath) as! CellHomeCV
        if collView.tag == 0 {
            cell.imgLocaiton.showIndicator(baseUrl: "", imageUrl: self.location[indexPath.row].image ?? "")
            cell.lblLocationName.text = self.location[indexPath.row].city
            cell.lblTotalRestaurant.text = "\(self.location[indexPath.row].restroCount ?? 0) Restaurants"
        }else if collView.tag == 1 {
            if self.isCellSelected == true {
                let image = "\(self.cuisine[indexPath.row].image ?? "")"
                let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
                cell.lblLocationName.text = self.cuisine[indexPath.row].name ?? ""
                cell.lblTotalRestaurant.text = "\(self.cuisine[indexPath.row].restroCount ?? 0) Restaurants"
            }else {
                let image = "\(self.category[indexPath.row].image ?? "")"
                let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
                cell.lblLocationName.text = self.category[indexPath.row].title ?? ""
                cell.lblTotalRestaurant.text = "\(self.category[indexPath.row].clubCount ?? 0) Restaurants"
            }
        }else if collView.tag == 3{
            let image = "\(self.themeArr[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgLocaiton.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblLocationName.text = self.themeArr[indexPath.row].productName ?? ""
            if self.isCellSelected == true {
                cell.lblTotalRestaurant.text = "\(self.themeArr[indexPath.row].barCount ?? 0) Restaurants"
            }else {
                cell.lblTotalRestaurant.text = "\(self.themeArr[indexPath.row].restroCount ?? 0) Restaurants"
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195.0, height: 208.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = super.viewContainingController()?.storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
        if collView.tag == 0 {
            vc.country = location[indexPath.row].country ?? ""
            vc.city = location[indexPath.row].city ?? ""
            vc.lblName = location[indexPath.row].city ?? ""
            vc.setValue = "Location"
            vc.setimage = "pinPerson"
        }else if collView.tag == 1{
            if self.isCellSelected == true{
                vc.cusinessID = cuisine[indexPath.row].id ?? 0
                vc.lblName = cuisine[indexPath.row].name ?? ""
                vc.setValue = "Cuisines"
                vc.setimage = "soup"
            }else{
                vc.cusinessID = category[indexPath.row].id ?? 0
                vc.lblName = category[indexPath.row].title ?? ""
                vc.setValue = "Categorys"
                vc.setimage = "menu 1"
            }
        }else{
            vc.themeID = themeArr[indexPath.row].id ?? 0
            vc.lblName = themeArr[indexPath.row].productName ?? ""
            vc.setValue = "Theme"
            vc.setimage = "mask"
        }
        super.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
