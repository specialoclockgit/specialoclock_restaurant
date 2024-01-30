//
//  MyOfferVC.swift
//  Spacial OClock
//
//  Created by cql211 on 04/07/23.
//

import UIKit
import SDWebImage
import SwiftUI
import SwiftGifOrigin

struct ModelMyOffer {
    //For Header
    var titleName : String
    var subTitle : String
    var timming : String
    
    //For Cell
    var img : [String]
    var itemName : [String]
    var prevPrice : [String]
    var newPrice : [String]
}
struct ModelHeader {
    var titleName : String
    var offer : String
    var timming : String
    
}
class MyOfferVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var igmViewGif: UIImageView!
    @IBOutlet weak var tbMyOffer : UITableView!
    
    //MARK: Variable
    var arrCheck : [Bool] = []
    var viewmodal = restoViewModal()
    var datagetApi : [LocationListBody]?
    var modal : [getOfferListModalBody]?
    var callback : ((String,String)->())?
    var seletedIndex = 0
    var imageView: UIImageView?
    var viewmodel = AuthViewModel()
    var valueChange = ""
    var getcountry = String()
    var getstate = String()
    var getcity = String()
    var gettimezone = String()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        if valueChange == "My Offer"{
            lblOffer.text = "My Offer"
            getofferlisting()
        }else if valueChange == "Select Country"{
            lblOffer.text = "Select Country"
            SetupApi()
        }
        
        tabBarController?.tabBar.isHidden = true
        
        let nib = UINib(nibName: Cell.CellMyOfferTB, bundle: nil)
        tbMyOffer.register(nib, forCellReuseIdentifier: Cell.CellMyOfferTB)
        tbMyOffer.register(UINib(nibName: Cell.HeaderMyOfferCell, bundle: nil), forCellReuseIdentifier:Cell.HeaderMyOfferCell)
        tbMyOffer.delegate = self
        tbMyOffer.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - API SETUP
    func SetupApi(){
        viewmodel.locationGetapicall { data in
            self.datagetApi = data
            self.check(count: data?.count ?? 0)
            self.tbMyOffer.reloadData()
        }
    }
    
    //MARK: - FUCNTIONS
    func getofferlisting(){
        viewmodal.offerListingapi(restaurentbarid: Store.userDetails?.bussiness_id ?? 91) { [weak self] data in
            self?.modal = data
            self?.check(count: data?.count ?? 0)
            self?.tbMyOffer.reloadData()
            if self?.modal?.count == 0 {
                self?.igmViewGif.image = UIImage.gif(name: "nodataFound")
                self?.igmViewGif.isHidden = false
            } else {
                self?.igmViewGif.isHidden = true
            }
        }
    }
    //MARK: Button Action
    @IBAction func btnAddOfferAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.AddOfferVC) as! AddOfferVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
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
            
            igmViewGif = UIImageView(frame: tbMyOffer.bounds)
            igmViewGif?.animationImages = images
            igmViewGif?.animationDuration = TimeInterval(frameCount) * 0.1 // Adjust the animation speed if needed
            igmViewGif?.animationRepeatCount = 0 // Repeat indefinitely
            igmViewGif?.contentMode = .scaleAspectFit
            igmViewGif?.startAnimating()
            
            tbMyOffer.backgroundView = imageView
            tbMyOffer.separatorStyle = .none
        }
    }
    
    func removeBackgroundGIF() {
        igmViewGif?.stopAnimating()
        tbMyOffer.backgroundView = nil
        tbMyOffer.separatorStyle = .singleLine
    }
}

extension MyOfferVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if valueChange == "My Offer"{
            return self.modal?[section].products?.count ?? 0
        }else{
            return self.datagetApi?[section].restaurants?.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if valueChange == "My Offer"{
            return modal?.count ?? 0
        }else{
            return datagetApi?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tbMyOffer.dequeueReusableCell(withIdentifier: Cell.HeaderMyOfferCell) as! HeaderMyOfferCell
        if valueChange == "My Offer"{
            cellHeader.lblHeading.text = "\(self.modal?[section].menuName ?? "") " +
            "\(String(describing: self.modal?[section].offerPrice ?? 0))%"
           // cellHeader.lblTimming.text =  "(\(String(describing: self.modal?[section].openTime ?? ""))-\(self.modal?[section].closeTime ?? ""))"
            cellHeader.viewHeader.layer.cornerRadius = 10.0
            cellHeader.btnHeader.addTarget(self, action: #selector(btnHeaderTarget), for: .touchUpInside)
            cellHeader.btnHeader.tag = section
            if arrCheck[section] == true{
                cellHeader.btnHeader.isSelected = true
                cellHeader.viewHeader.backgroundColor = .white
                cellHeader.lblSubHeading.isHidden = true
            }else{
                cellHeader.btnHeader.isSelected = false
                cellHeader.viewHeader.backgroundColor = .systemGray6
                cellHeader.lblSubHeading.isHidden = true
            }
        }else{
            cellHeader.lblHeading.text =  self.datagetApi?[section].country ?? ""
            cellHeader.viewHeader.layer.cornerRadius = 10.0
            cellHeader.btnHeader.addTarget(self, action: #selector(btnHeaderTarget), for: .touchUpInside)
            cellHeader.btnHeader.tag = section
            if arrCheck[section] == true{
                cellHeader.btnHeader.isSelected = true
                cellHeader.viewHeader.backgroundColor = .white
                cellHeader.lblSubHeading.isHidden = false
            }else{
                cellHeader.btnHeader.isSelected = false
                cellHeader.viewHeader.backgroundColor = .systemGray6
                cellHeader.lblSubHeading.isHidden = true
            }
        }
        
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if valueChange == "My Offer"{
            return 68.0
        }else{
            return 50
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbMyOffer.dequeueReusableCell(withIdentifier: Cell.CellMyOfferTB) as! CellMyOfferTB
        if valueChange == "My Offer"{
            cell.lblTittleName.text = self.modal?[indexPath.section].products?[indexPath.row].productName ?? ""
            cell.imgViwe.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.imgViwe.sd_setImage(with: URL(string: productImgURL + (self.modal?[indexPath.section].products?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20") ?? "")),placeholderImage: UIImage(named: "pl"))

//            if Store.userDetails?.bussinesstype == 2 {
//                cell.lblActualPrice.text = "R\(self.modal?[indexPath.section].products?[indexPath.row]. ?? 0)"
//            }else {
                
                let totalamount = self.modal?[indexPath.section].products?[indexPath.row].price ?? 0
                let discount = self.modal?[indexPath.section].offerPrice ?? 0
                cell.lblOfferPrice.text = "R\(calculate(total: totalamount, discount: discount).description)"
          // }
            
            
            
        }else{
            let sections = datagetApi?[indexPath.section].restaurants
            cell.lblTittleName.text = sections?[indexPath.row].city ?? ""
            cell.lblActualPrice.isHidden = true
            cell.lblOfferPrice.isHidden = true
            
        }
        //MARK: Hide And View Cell
        if arrCheck[seletedIndex] == false{
            cell.stackView.isHidden = true
        }else{
            cell.stackView.isHidden = false
        }
        
        return cell
    }

    func calculate(total:Int,discount:Int) -> Int {
        let Amount = total * discount / 100
        let finalAmount = total - Amount
        return finalAmount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if valueChange == "My Offer"{
            return (arrCheck[indexPath.section]) == true ? 60.0 : 0.0
        }else{
            return (arrCheck[indexPath.section]) == true ? 45.0 : 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sections = datagetApi?[indexPath.section].restaurants
        self.getcity = sections?[indexPath.row].city ?? ""
        self.gettimezone = sections?[indexPath.row].timezone ?? ""
        self.callback?(self.getcity, self.gettimezone)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnedit(_ sender : UIButton){
        let combinedTag = sender.tag
        let section = combinedTag / 1000
        let row = combinedTag % 1000
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.EditOfferVC)as! EditOfferVC
        //screen.modal = (self.modal?[section])!
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
}

//MARK: Objective Functions
extension MyOfferVC{
    
    //MARK: Table Header Button Action
    @objc func btnHeaderTarget(_ sender : UIButton){
        seletedIndex = sender.tag
        if sender.isSelected == false {
            if arrCheck[sender.tag] == false{
                sender.isSelected = true
                arrCheck[sender.tag] = true
            }
        }else{
            sender.isSelected = false
            arrCheck[sender.tag] = false
        }
        tbMyOffer.reloadData()
    }
}

//MARK: InitialLoad
extension MyOfferVC {
    func check(count:Int){
        
        for _ in 0...(count){
            arrCheck.append(false)
        }
        print(arrCheck)
        
    }
}
