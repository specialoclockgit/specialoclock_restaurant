//
//  BreakfastVC.swift
//  Spacial OClock
//
//  Created by cql211 on 03/07/23.
//

import UIKit
import SDWebImage
import SwiftGifOrigin

class BreakfastVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var imgGif: UIImageView!
    @IBOutlet weak var tbBreakfast : UITableView!
    @IBOutlet weak var btnAddProduct : UIButton!
    @IBOutlet weak var lblHeading : UILabel!
    
    //MARK: Variables
    var viewmodel = restoViewModal()
    var datagetAPI: [ProductListingModelBody]?
    var menuID = String()
    var imageView: UIImageView?
    var menuid = Int()
    var heading = String()
    var price = Int()
    var offerpice = Int()
    var offerlessprice = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHeading.text = heading
        tbBreakfast.delegate = self
        tbBreakfast.dataSource = self
        let nib = UINib(nibName: Cell.CellBreakfastTB, bundle: nil)
        tbBreakfast.register(nib, forCellReuseIdentifier: Cell.CellBreakfastTB)
    }
    override func viewWillAppear(_ animated: Bool) {
        setupAPI()
       // calculation()
    }
    
    //MARK: - API SETUP
    func setupAPI(){
        viewmodel.ProductListingapi(menuid:menuid) { [weak self] data in
            self?.datagetAPI = data
            self?.tbBreakfast.reloadData()
        }
    }
    func calculation(){
        offerpice = datagetAPI?.first?.offerpercentage ?? 0
        price = datagetAPI?.first?.price ?? 0
        let newprice = price * 100/offerpice
        self.offerlessprice = price - newprice
        
    }
    
    //MARK: Button Action
    @IBAction func btnBakAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddProductAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.AddProductVC) as! AddProductVC
        screen.menuID  = menuid
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension BreakfastVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datagetAPI?.count == 0{
            imgGif.image = UIImage.gif(name: "nodataFound")
            imgGif.isHidden = false
        }else{
            imgGif.isHidden = false
            return datagetAPI?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellBreakfastTB, for: indexPath) as! CellBreakfastTB
        let data = datagetAPI?[indexPath.row]
        cell.lblTitle.text = data?.productName ?? ""
        cell.lblNewPrice.text = data?.price?.description
        cell.lblPrevPrice.text = "\(offerpice)"
        let imageIndex = (productImgURL) + (data?.image?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "placeholder (1)"))
        return cell
    }
}
struct BreakFastModel{
    var img : String
    var itemName : String
}
