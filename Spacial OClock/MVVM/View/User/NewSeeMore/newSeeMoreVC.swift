//
//  newSeeMoreVC.swift
//  Spacial OClock
//
//  Created by cqlios on 16/11/23.
//

import UIKit
import SkeletonView

class newSeeMoreVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var colleVeiw: UICollectionView!
    @IBOutlet weak var lblHead2: UILabel!
    @IBOutlet weak var lblHead1: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    
    //MARK: - VARIABELS
    var location = [HomeListLocation]()
    var cuisine = [Cuisine]()
    var themeArr = [ThemeData]()
    var category = [Category]()
    var all_bars_restos = [AllBarsResto]()
    var highily_rated_bars_restos = [AllBarsResto]()
    var setvalue = ""
    var objArray: [SectionModel] = []
    
    //MARK: - VIEW LIEFCYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        if setvalue == "Location"{
//            lblHeader.text = "Location"
//            lblHead1.text = "Location"
//            imgView.image = UIImage(named: "pinPerson")
        }else if setvalue == "Cuisines"{
//            lblHeader.text = "Cuisine"
         //   lblHead1.text = "Cuisine"
//            imgView.image = UIImage(named: "soup")
        }else if setvalue == "Category"{
//            lblHeader.text = "Category"
//            lblHead1.text = "Category"
//            imgView.image = UIImage(named: "menu 1")
        }else if setvalue == "Theme"{
//            lblHeader.text = "Theme"
//            lblHead1.text = "Theme"
//            imgView.image = UIImage(named: "mask")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - ACTIONS
    @IBAction func btnSeacrch(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: - EXTENSION
extension newSeeMoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setvalue == "Cuisines"{
            self.colleVeiw.hideSkeleton()
            if cuisine.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return cuisine.count
            }
        }else if setvalue == "Category"{
            self.colleVeiw.hideSkeleton()
            if category.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return category.count
            }
        }else if setvalue == "Theme"{
            self.colleVeiw.hideSkeleton()
            if themeArr.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return themeArr.count
            }
        }else if setvalue == "Location"{
            self.colleVeiw.hideSkeleton()
            if location.count == 0{
                imgViewGif.image = UIImage.gif(name: "nodataFound")
                imgViewGif.isHidden = false
            }else{
                imgViewGif.isHidden = true
                return location.count
            }
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newSeeMoreCVC", for: indexPath) as! newSeeMoreCVC
        cell.view.layer.cornerRadius = 10
        cell.view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        if setvalue == "Location"{
            cell.imgView.showIndicator(baseUrl: "", imageUrl: self.location[indexPath.row].image ?? "")
            cell.lblName.text = self.location[indexPath.row].city ?? ""
            cell.lblTotalREs.text = "Restaurant \(self.location[indexPath.row].restroCount ?? 0)"
        }else if setvalue == "Cuisines"{
            let image = "\(self.cuisine[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgView.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblTotalREs.text = "Restaurant \(self.cuisine[indexPath.row].restroCount ?? 0)"
            cell.lblName.text = self.cuisine[indexPath.row].name ?? ""
        }else if setvalue == "Category"{
            let image = "\(self.category[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgView.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblTotalREs.text = "Restaurant \(self.category[indexPath.row].clubCount ?? 0)"
            cell.lblName.text = self.category[indexPath.row].title ?? ""
        }else if setvalue == "Theme"{
            let image = "\(self.themeArr[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgView.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            cell.lblTotalREs.text = "Restaurant \(self.themeArr[indexPath.row].restroCount ?? 0)"
            cell.lblName.text = self.themeArr[indexPath.row].productName ?? ""
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if setvalue == "Location"{
            return CGSize(width: colleVeiw.frame.width, height: 180)
        }else if setvalue == "Cuisines"{
            return CGSize(width: colleVeiw.frame.width, height: 180)
        }else if setvalue == "Category"{
            return CGSize(width: colleVeiw.frame.width, height: 180)
        }else{
            return CGSize(width: colleVeiw.frame.width, height: 180)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if setvalue == "Location"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.country = self.location[indexPath.row].country ?? ""
            vc.city = self.location[indexPath.row].city ?? ""
            vc.setValue = "Location"
            vc.setimage = "PIN"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setvalue == "Cuisines"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.cusinessID = self.cuisine[indexPath.row].id ?? 0
            vc.lblName = self.cuisine[indexPath.row].name ?? ""
            vc.setimage = "soup"
            vc.setValue = "Cuisines"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if setvalue == "Category"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.cusinessID = self.category[indexPath.row].id ?? 0
            vc.lblName = self.category[indexPath.row].title ?? ""
            vc.setimage = "category_icon"
            vc.setValue = "Category"
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.themeID = themeArr[indexPath.row].id ?? 0
            vc.lblName = self.themeArr[indexPath.row].productName ?? ""
            vc.setValue = "Theme"
            vc.setimage = "mask"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
