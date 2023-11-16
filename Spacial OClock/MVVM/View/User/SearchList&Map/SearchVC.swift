//
//  SearchVC.swift
//  Spacial OClock
//
//  Created by cqlios on 16/10/23.
//

import UIKit
import SDWebImage
import SwiftGifOrigin

class SearchVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var searchCV: UICollectionView!
    @IBOutlet weak var txtFldSearch: CustomTextField!
    
    //MARK: - VARIABLES
    var allresto : [AllBarsResto]?
    var filterdata : [AllBarsResto]?
    var viewmodal = HomeViewModel()
    var type = Int()
    var country = String()
    var city = String()
    var latitude = Double()
    var longitude = Double()
    
    //MARK: - VIEW LFIECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFldSearch.delegate = self
    }
    
    //MARK: - FUNCTIONS
    func search_list(){
        viewmodal.homeApi(type: type, country: "", city: city, state: "", lat: latitude, long: longitude,timezone: "asdf") { data in
            self.allresto = data?.all_bars_restos ?? []
            self.filterdata = data?.all_bars_restos ?? []
            self.searchCV.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        search_list()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - EXTENSIONS
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filterdata?.count == 0{
            imgViewGif.image = UIImage.gif(name: "nodataFound")
            imgViewGif.isHidden = false
        }else{
            imgViewGif.isHidden = true
            return filterdata?.count ?? 0
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCVC", for: indexPath) as! SearchCVC
        let imageIndex = (imageURL) + (filterdata?[indexPath.row].profileImage ?? "")
        
        if cell.imgView != nil {
            cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
        }
       
        cell.lblName.text = filterdata?[indexPath.row].name ?? ""
        cell.lblDis.text = filterdata?[indexPath.row].shortDescription ?? ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: searchCV.frame.width / 2.1, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
        vc.ProductID = filterdata?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension SearchVC : UITextFieldDelegate {
    //MARK: - Search
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultString = txtFldSearch.text ?? ""
        if (resultString.count) > 1{
            if let searchText = txtFldSearch.text {
                filterdata = allresto?.filter {$0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
            }
        }else{
            filterdata = allresto
        }
        searchCV.reloadData()
        return true
    }
}
