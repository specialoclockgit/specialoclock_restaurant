//
//  newSeeMoreVC.swift
//  Spacial OClock
//
//  Created by cqlios on 16/11/23.
//

import UIKit
import SkeletonView
import SwiftGifOrigin
#if canImport(CHTCollectionViewWaterfallLayout)
import CHTCollectionViewWaterfallLayout
#endif
class newSeeMoreVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var txtFldSearch: CustomTextField!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var colleVeiw: UICollectionView!
   
    
    //MARK: - VARIABELS
    var location = [HomeListLocation]()
    var cuisine = [Cuisine]()
    var themeArr = [ThemeData]()
    var category = [Category]()
    var all_bars_restos = [AllBarsResto]()
    var highily_rated_bars_restos = [AllBarsResto]()
    var filterlocation = [HomeListLocation]()
    var filterCusine = [Cuisine]()
    var filterthemeAry = [ThemeData]()
    var filtercategory = [Category]()
    var setvalue = ""
    var objArray: [SectionModel] = []
    
    //MARK: - VIEW LIEFCYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldSearch.delegate  = self
        setupCollectionView()
        if setvalue == "Location"{
            lblHeading.text = "Location"
        }else if setvalue == "Cuisines"{
            lblHeading.text = "Cuisines"
        }else if setvalue == "Category"{
            lblHeading.text = "Category"
        }else if setvalue == "Theme"{
            lblHeading.text = "Theme"
        }
        
        colleVeiw.reloadData()
    }
    func setupCollectionView(){
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 5
        layout.minimumInteritemSpacing = 10.0
        // Collection view attributes
        colleVeiw.alwaysBounceVertical = true
        // Add the waterfall layout to your collection view
        colleVeiw.collectionViewLayout = layout
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
extension newSeeMoreVC: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if setvalue == "Cuisines"{
            self.colleVeiw.hideSkeleton()
            if cuisine.count == 0{
                collectionView.setNoDataMessage("No cuisines found", txtColor: .black)
               // imgViewGif.image = UIImage.gif(name: "nodataFound")
               // imgViewGif.isHidden = false
            }else{
                collectionView.backgroundView = nil
                //imgViewGif.isHidden = true
                return filterCusine.count
            }
        }else if setvalue == "Category"{
            self.colleVeiw.hideSkeleton()
            if category.count == 0{
                collectionView.setNoDataMessage("No category found", txtColor: .black)
                //imgViewGif.image = UIImage.gif(name: "nodataFound")
                //imgViewGif.isHidden = false
            }else{
                collectionView.backgroundView = nil
               // imgViewGif.isHidden = true
                return filtercategory.count
            }
        }else if setvalue == "Theme"{
            self.colleVeiw.hideSkeleton()
            if themeArr.count == 0{
                collectionView.setNoDataMessage("No theme found", txtColor: .black)
                //imgViewGif.image = UIImage.gif(name: "nodataFound")
                //imgViewGif.isHidden = false
            }else{
                collectionView.backgroundView = nil
                //imgViewGif.isHidden = true
                return filterthemeAry.count
            }
        }else if setvalue == "Location"{
            self.colleVeiw.hideSkeleton()
            if location.count == 0{
                collectionView.setNoDataMessage("No location found", txtColor: .black)
                //imgViewGif.image = UIImage.gif(name: "nodataFound")
                //imgViewGif.isHidden = false
            }else{
                collectionView.backgroundView = nil
              //  imgViewGif.isHidden = true
                return filterlocation.count
            }
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newSeeMoreCVC", for: indexPath) as! newSeeMoreCVC
        if setvalue == "Location" {
            cell.imgView.showIndicator(baseUrl: "", imageUrl: self.location[indexPath.row].image ?? "")
            cell.lblName.text = self.filterlocation[indexPath.row].locality_area ?? ""
            let countTxt  = Store.screenType == 2 ? (self.filterlocation[indexPath.row].restroCount ?? 0) : (self.filterlocation[indexPath.row].restroCount ?? 0)
            let count = countTxt
            let newCount = count == 0 ? count.description : count < 9 ? "0\(count.description)" : (count).description
            cell.lblTotalREs.text = Store.screenType == 2 ? "\(newCount) Bars/Clubs" : "\(newCount) Restaurants"
            //"\(self.filterlocation[indexPath.row].restroCount ?? 0) Bars" : "\(self.filterlocation[indexPath.row].restroCount ?? 0) Restaurants"
        } else if setvalue == "Cuisines" {
            let image = "\(self.filterCusine[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgView.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            let count  = Store.screenType == 2 ? (self.filterCusine[indexPath.row].restroCount ?? 0) : (self.filterCusine[indexPath.row].restroCount ?? 0)
    
            let newCount = count == 0 ? count.description : count < 9 ? "0\(count.description)" : (count).description
            if newCount == "1" {
                cell.lblTotalREs.text = Store.screenType == 2 ? "\(newCount) Bars/Clubs" : "\(newCount) Restaurant"
            } else {
                cell.lblTotalREs.text = Store.screenType == 2 ? "\(newCount) Bars/Clubs" : "\(newCount) Restaurants"
            }

            //"\(self.filterCusine[indexPath.row].restroCount ?? 0) Bars" : "\(self.filterCusine[indexPath.row].restroCount ?? 0) Restaurants"
            cell.lblName.text = self.filterCusine[indexPath.row].name?.capitalized ?? ""
        } else if setvalue == "Category"{
            let image = "\(self.filtercategory[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgView.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            let count  = Store.screenType == 2 ? (self.filtercategory[indexPath.row].clubCount ?? 0) : (self.filtercategory[indexPath.row].clubCount ?? 0)
    
            let newCount = count == 0 ? count.description : count < 9 ? "0\(count.description)" : (count).description
            cell.lblTotalREs.text = Store.screenType == 2 ? "\(newCount) Bars/Clubs" : "\(newCount) Restaurants"
            //"\(self.filtercategory[indexPath.row].clubCount ?? 0) Bars" : "\(self.filtercategory[indexPath.row].clubCount ?? 0) Restaurants"
            cell.lblName.text = self.filtercategory[indexPath.row].title ?? ""
        } else if setvalue == "Theme" {
            let image = "\(self.filterthemeAry[indexPath.row].image ?? "")"
            let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            cell.imgView.showIndicator(baseUrl: imageBaseURL, imageUrl: urlString)
            let count  = Store.screenType == 2 ? (self.filterthemeAry[indexPath.row].barCount ?? 0) : (self.filterthemeAry[indexPath.row].barCount ?? 0)
    
            let newCount = count == 0 ? count.description : count < 9 ? "0\(count.description)" : (count).description
            cell.lblTotalREs.text = Store.screenType == 2 ? "\(newCount) Bars/Clubs" : "\(newCount) Restaurants"
            //"\(self.filterthemeAry[indexPath.row].barCount ?? 0) Bars" : "\(self.filterthemeAry[indexPath.row].barCount ?? 0) Restaurants"
            cell.lblName.text = self.filterthemeAry[indexPath.row].productName ?? ""
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if setvalue == "Location"{
            if indexPath.row % 3 == 0{
                return CGSize(width: colleVeiw.frame.width / 2, height: 200)
            }else{
                return CGSize(width: colleVeiw.frame.width / 2, height: 260)
            }
           
        }else if setvalue == "Cuisines"{
            if indexPath.row % 3 == 0{
                return CGSize(width: colleVeiw.frame.width / 2, height: 200)
            }else{
                return CGSize(width: colleVeiw.frame.width / 2, height: 260)
            }
        }else if setvalue == "Category"{
            if indexPath.row % 3 == 0{
                return CGSize(width: colleVeiw.frame.width / 2, height: 200)
            }else{
                return CGSize(width: colleVeiw.frame.width / 2, height: 260)
            }
        }else{
            if indexPath.row % 3 == 0{
                return CGSize(width: colleVeiw.frame.width / 2, height: 200)
            }else{
                return CGSize(width: colleVeiw.frame.width / 2, height: 260)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if setvalue == "Location" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.country = self.filterlocation[indexPath.row].country ?? ""
            vc.city = self.filterlocation[indexPath.row].city ?? ""
            vc.lblName = self.filterlocation[indexPath.row].locality_area ?? ""
            vc.setValue = "Location"
            vc.setimage = "pinPerson"
            self.navigationController?.pushViewController(vc, animated: true)
        } else if setvalue == "Cuisines" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.cusinessID = self.filterCusine[indexPath.row].id ?? 0
            vc.lblName = self.filterCusine[indexPath.row].name?.capitalized ?? ""
            vc.setimage = "soup"
            vc.setValue = "Cuisines"
            self.navigationController?.pushViewController(vc, animated: true)
        } else if setvalue == "Category" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.cusinessID = self.filtercategory[indexPath.row].id ?? 0
            vc.lblName = self.filtercategory[indexPath.row].title ?? ""
            vc.setimage = "category_icon"
            vc.setValue = "Category"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailItemViewVC") as! DetailItemViewVC
            vc.themeID = filterthemeAry[indexPath.row].id ?? 0
            vc.lblName = self.filterthemeAry[indexPath.row].productName ?? ""
            vc.setValue = "Theme"
            vc.setimage = "mask"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension newSeeMoreVC : UITextFieldDelegate {
    //MARK: - Search
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if setvalue == "Location" {
            let resultString = txtFldSearch.text ?? ""
            if (resultString.count) > 1{
                if let searchText = txtFldSearch.text {
                    filterlocation = location.filter {$0.state?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                }
            }else{
                filterlocation = location
            }
        } else if setvalue == "Cuisines" {
            let resultString = txtFldSearch.text ?? ""
            if (resultString.count) > 1{
                if let searchText = txtFldSearch.text {
                    filterCusine = cuisine.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                }
            } else {
                filterCusine = cuisine
            }
        } else if setvalue == "Category" {
            let resultString = txtFldSearch.text ?? ""
            if (resultString.count) > 1{
                if let searchText = txtFldSearch.text {
                    filtercategory = category.filter {$0.title?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                }
            } else {
                filtercategory = category
            }
        } else {
            let resultString = txtFldSearch.text ?? ""
            if (resultString.count) > 1{
                if let searchText = txtFldSearch.text {
                    filterthemeAry = themeArr.filter {$0.productName?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
                }
            } else {
                filtercategory = category
            }
        }
        colleVeiw.reloadData()
        return true
    }
}
