//
//  ItemDetailsVC.swift
//  Spacial OClock
//
//  Created by cql211 on 28/06/23.
//

import UIKit
import SDWebImage
import IQKeyboardManagerSwift
import Cosmos
import SwiftUI

struct ModelMenuCollView {
    var name : [String]
    var time :[String]
}
struct ModelMenuTBCell{
    var heading : String
    var image : [String]
    var itemName : [String]
    var prevPrice : [String]
    var newPrice : [String]
}
class ItemDetailsVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var scrollView : UIScrollView!
//    @IBOutlet weak var viewSubSV : UIView!
    @IBOutlet weak var collView : UICollectionView!
    @IBOutlet weak var tbReview : UITableView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var viewAbout : UIView!
    @IBOutlet weak var viewMenu : UIView!
    @IBOutlet weak var viewReview : UIView!
    @IBOutlet weak var lblAbout : UILabel!
    @IBOutlet weak var lblMenu : UILabel!
    @IBOutlet weak var lblReview : UILabel!
    @IBOutlet weak var viewA : UIView!
    @IBOutlet weak var lblAboutDetail : UILabel!
    @IBOutlet weak var viewM : UIView!
    @IBOutlet weak var viewR : UIView!
    @IBOutlet weak var viewSV : UIView!
    @IBOutlet weak var lblNameREsto: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationOne: UILabel!
    @IBOutlet weak var lblOpenCloseTime: UILabel!
    @IBOutlet weak var imgBottomView : UIImageView!
    //MENU Outlets
    @IBOutlet weak var collViewMenu : UICollectionView!
    @IBOutlet weak var tbMenu : UITableView!
    @IBOutlet weak var heightTBMenu : NSLayoutConstraint!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var heightTBReview : NSLayoutConstraint!
    @IBOutlet weak var imgFav : UIImageView!
    @IBOutlet weak var btnFav : UIButton!
    @IBOutlet weak var btnBook : UIButton!
    @IBOutlet weak var viewButton : UIView!
    
    //MARK: Variable
    var ProductID = Int()
    var viewmodal = HomeViewModel()
    var modal : productDetailModalBody?
    var images: [Imaged]?
    var reviews: [Reviewsd]?
    var ourMenu: [OurMenud]?
    var productModal : menuProductModalBody?
    
    //    var arrCollMenu : [ModelMenuCollView] = [ModelMenuCollView(name: ["Tonight" , "Happy Hour" , "Today" , "Tommorow"], time: ["08:00 to 10:00" , "13:00 to 13:30" , "19:00 to 20:00" , "13:00 to 13:30"])]
    var arrCollMenu : [ModelMenuCollView] = []
    var arrTBMenu : [ModelMenuTBCell] = [ModelMenuTBCell(heading: "Sandwich", image: ["goose" , "belveder",                                            "Ciroc" ],
                                        itemName: ["Plain Sandwich" , "Grilled Sandwich" ,                                   "Club Sandwich"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00",  "R20.00" ,"R30.00"]) ,
                                         
                                         ModelMenuTBCell(heading: "Burgers", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""]),
                                         ModelMenuTBCell(heading: "Pizzas", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""]),
                                         ModelMenuTBCell(heading: "Soups", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""])]
    var imgName = UIImage()
    var arrCheck : [Bool] = []
    var btnBookStatus = Int()
    let status = UserDefaults.standard.dineDrinkStatus
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tbMenu.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        initialLoad()
        img.image = imgName
        collView.delegate = self
        collView.dataSource = self
        
        let nib = UINib(nibName: Cell.CellItemDetailReviewTB, bundle: nil)
        tbReview.register(nib, forCellReuseIdentifier: Cell.CellItemDetailReviewTB)
        tbReview.delegate = self
        tbReview.dataSource = self
        
        //Menu view
        collViewMenu.delegate = self
        collViewMenu.dataSource = self
        let nibMenu = UINib(nibName: Cell.CellMenuCV, bundle: nil)
        self.collViewMenu.register(nibMenu, forCellWithReuseIdentifier: Cell.CellMenuCV)
        
        let nibMenuTB = UINib(nibName: Cell.CellMenuTV, bundle: nil)
        self.tbMenu.register(nibMenuTB, forCellReuseIdentifier: Cell.CellMenuTV)
        tbMenu.delegate = self
        tbMenu.dataSource = self
        for _ in 0...arrTBMenu.count{
            arrCheck.append(false)
        }
    }
    
    
    //MARK: - FUNCTION
    func product_detail(){
        viewmodal.restoDetial_API(resto_id: ProductID) { data in
            self.modal = data
            self.images = data?.images ?? []
            self.reviews = data?.reviews ?? []
            self.ourMenu = data?.ourMenu ?? []
            let imageIndex = (imageURL) + (self.modal?.images?.first?.image ?? "")
            self.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Userssss"))
            self.lblNameREsto.text = self.modal?.name ?? ""
            self.lblOpenCloseTime.text = (self.modal?.openTime ?? "") + "-" + (self.modal?.closeTime ?? "")
            self.lblLocationOne.text = self.modal?.location ?? ""
            self.lblLocation.text = self.modal?.city ?? ""
            if self.modal?.isLiked == 0{
                self.imgFav.image = UIImage(named: "white h")
            }else{
                self.imgFav.image = UIImage(named: "red h")
            }
            self.lblAboutDetail.text = self.ourMenu?.first?.offers?.description ?? ""
            self.cosmosView.rating = Double(self.modal?.avgRating ?? "") ?? 0.0
            self.lblRating.text = self.modal?.avgRating ?? ""
            self.lblAboutDetail.text = self.modal?.shortDescription ?? ""
            self.collViewMenu.reloadData()
            self.collView.reloadData()
            self.tbReview.reloadData()
            self.tbMenu.reloadData()
            //self.menuProductAPI()
        }
    }
    
    //MARK: - MENU PRODUCT API
    func menuProductAPI(id: Int){
        viewmodal.menuProductAPI(restoid: ProductID, menutypeid: id) { dataa in
            self.productModal = dataa
            self.tbMenu.reloadData()
            self.collViewMenu.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        product_detail()
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: Button Action
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func isSelected(sender : UIButton){
        switch sender.tag {
        case 0 :
            ChangebgColor(viewSelected: viewAbout, viewUnselected: viewMenu, viewUnselected2: viewReview, labelSelected: lblAbout, labelUnselected: lblMenu, labelUnselecte2: lblReview)
            viewA.layoutSubviews()
            viewA.isHidden = false
            viewM.isHidden = true
            viewR.isHidden = true
            viewButton.isHidden = true
            debugPrint("0")
            
        case 1 :
            ChangebgColor(viewSelected: viewMenu, viewUnselected: viewAbout, viewUnselected2: viewReview, labelSelected: lblMenu, labelUnselected: lblAbout, labelUnselecte2: lblReview)
            viewA.isHidden = true
            viewM.isHidden = false
            viewR.isHidden = true
            viewButton.isHidden = false
            btnBookStatus = 0
            btnBook.setTitle("Book", for: .normal)
            //MARK: Set Menu tabel Data
            if status == 0 {
                product_detail()
                let arrDineMenu : [ModelMenuTBCell] = [ModelMenuTBCell(heading: "Sandwich",
                                                                        image: ["planeSanwich" , "grilledSandwich", "clubSandwich" ],
                                                                         itemName: ["Plain Sandwich" , "Grilled Sandwich" ,  "Club Sandwich"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00",  "R20.00" ,"R30.00"]) ,
                                                                          
                                                                          ModelMenuTBCell(heading: "Burgers", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""]),
                                                                          ModelMenuTBCell(heading: "Pizzas", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""]),
                                                                          ModelMenuTBCell(heading: "Soups", image: ["" ], itemName: [""], prevPrice: [""], newPrice: [""])]
                arrTBMenu.removeAll()
                arrTBMenu.append(contentsOf: arrDineMenu)
            }else if status == 1 {
                product_detail()
                let arrMenu : [ModelMenuTBCell] = [ModelMenuTBCell(heading: "Vodka",
                                                  image: ["goose" , "belveder",  "Ciroc" ],  itemName: ["Grey Goose" , "Belvedere" , "Ciroc"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00" ,  "R20.00" ,"R30.00"]) ,
                                                    ModelMenuTBCell(heading: "Gin", image: ["goose" , "belveder", "Ciroc" ], itemName: ["Grey Goose" , "Belvedere" , "Ciroc"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00" , "R20.00" , "R30.00"]),
                                                    ModelMenuTBCell(heading: "Rum", image: ["goose" , "belveder", "Ciroc" ], itemName: ["Grey Goose" , "Belvedere" , "Ciroc"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00" , "R20.00" , "R30.00"]),
                                                    ModelMenuTBCell(heading: "Tequila", image: ["goose" , "belveder", "Ciroc" ], itemName: ["Grey Goose" , "Belvedere" , "Ciroc"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00" , "R20.00" , "R30.00"])]
                arrTBMenu.removeAll()
                arrTBMenu.append(contentsOf: arrMenu)
               
            }
            tbMenu.reloadData()
            
        case 2 :
            product_detail()
            ChangebgColor(viewSelected: viewReview, viewUnselected: viewAbout, viewUnselected2: viewMenu, labelSelected: lblReview, labelUnselected: lblAbout, labelUnselecte2: lblMenu)
            viewA.isHidden = true
            viewM.isHidden = true
            viewR.isHidden = false
            viewButton.isHidden = false
            btnBookStatus = 1
            btnBook.setTitle("Write a Review", for: .normal)
            debugPrint("2")
        default:
            debugPrint("Default Run IsSelected")
        }
    }
    
    //Hide And show Offer Description
    @IBAction func isViewHide(sender : UIButton){
        if sender.isSelected  == false{
            debugPrint("True")
            viewSV.isHidden = true
            sender.isSelected = true
        }else{
            debugPrint("False")
            viewSV.isHidden = false
            sender.isSelected = false
        }
    }
    
    //Book Button
    @IBAction func btnBookAct(_ sender : UIButton){
        if btnBookStatus == 0{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.NewBookingVC) as! NewBookingVC
            self.navigationController?.pushViewController(screen, animated: true)
        }
        else if btnBookStatus == 1{
            let screenReview = storyboard?.instantiateViewController(withIdentifier: "AddRatingVC") as! AddRatingVC
            screenReview.restoID = ProductID
            self.navigationController?.pushViewController(screenReview, animated: true)
        }
    }
    
    @IBAction func btnFavAct(_ sender : UIButton){
        if sender.isSelected == false{
            viewmodal.resto_likeAPI(Restoid: ProductID, status: 0) { data in
                self.imgFav.image = UIImage(named: "red h")
            }
        }else{
            viewmodal.resto_likeAPI(Restoid: ProductID, status: 0) { data in
                self.imgFav.image = UIImage(named: "white h")
            }
        }
        sender.isSelected = !sender.isSelected
    }
}
extension ItemDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collView{
            return images?.count ?? 0
        }
        else if collectionView == collViewMenu
        {
            return ourMenu?.count ?? 0
        }else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellItemDetailVC", for: indexPath) as! CellItemDetailVC
            let imageIndex = (imageURL) + (self.images?[indexPath.row].image ?? "")
            cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Userssss"))
            return cell
        }
        else if collectionView == collViewMenu{
            let cell =  collViewMenu.dequeueReusableCell(withReuseIdentifier: Cell.CellMenuCV, for: indexPath) as! CellMenuCV
            if ((indexPath.row % 2 ) == 0)  {
                cell.img.image = UIImage(named: "greenRectangle")
                cell.lblTime.backgroundColor = UIColor(named: "themeGreen")
                cell.lblTime.text = ""
                cell.lblOffer.backgroundColor = UIColor(named: "themeGreen")
            }
            let data = ourMenu?[indexPath.row]
            cell.lblTime.text = "\(data?.offers?.openTime ?? "") - " + "\(data?.offers?.closeTime ?? "")"
            cell.lblMenuSchedule.text = data?.offers?.offerName ?? ""
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.CellItemDetailVC, for: indexPath) as! CellItemDetailVC
            cell.img.image = imgName
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collViewMenu {
            return CGSize (width: 120.0, height: 200.0)
        }
            return CGSize(width: 120.0, height: 80.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == collView{
//
//        }
        debugPrint(indexPath.row)
        let index = indexPath.row
        if index == 0{
            if status == 0 {
                menuProductAPI(id: ourMenu?[indexPath.row].id ?? 0)
                
                let breakfastArr : [ModelMenuTBCell] = [ModelMenuTBCell(heading: "Breakfast",
                                                                        image: ["clubSandwich" , "grilledSandwich", "planeSanwich" ],
                                                                        itemName: ["Grey Goose" , "Grilled Sandwich" , "Sandwich"],
                                                                        prevPrice: ["R50.00" , "R50.00" , "R50.00"],
                                                                        newPrice: ["R40.00" , "R20.00" ,"R30.00"])]
                arrTBMenu.removeAll()
                arrTBMenu.append(contentsOf: breakfastArr)
            }else if status == 1 {
                let drinksArr : [ModelMenuTBCell] = [ModelMenuTBCell(heading: "Vodka",
                                                                        image: ["goose" , "belveder", "Ciroc" ],
                                                                        itemName: ["Grey Goose" , "Belvedere" , "Ciroc"],
                                                                        prevPrice: ["R50.00" , "R50.00" , "R50.00"],
                                                                        newPrice: ["R40.00" , "R20.00" ,"R30.00"])]
                arrTBMenu.removeAll()
                arrTBMenu.append(contentsOf: drinksArr)
            }
            tbMenu.reloadData()
        }
    }
}
extension ItemDetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbMenu {
            return productModal?.categories?[section].products?.count ?? 0
        }
        return reviews?.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tbMenu{
            return productModal?.categories?.count ?? 0
        }
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tbMenu{
                let sectionV = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50) )
                sectionV.layer.cornerRadius = 10.0
                let titleLbl = UILabel.init(frame: CGRect(x: 20, y: 15, width: tableView.frame.width-150, height: 20) )

            titleLbl.text = productModal?.categories?[section].products?.first?.menuTypeName ?? ""
//            titleLbl.text = ourMenu?[indexPath.row].name ?? ""
                titleLbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
            
                let viewAllBtn = UIButton.init(frame: CGRect(x: tableView.frame.width-150, y: 10, width: self.view.frame.width - titleLbl.frame.width, height: 30))
                viewAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                if arrCheck[section] == true {
                    sectionV.backgroundColor = .systemGray5
                    viewAllBtn.setImage(UIImage(named: "arrowIcon"), for: .normal)
                }else{
                    sectionV.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
                    viewAllBtn.setImage(UIImage(named: "arrowDefault"), for: .normal)
                    
                }
                viewAllBtn.setTitleColor(.black, for: .normal)
                viewAllBtn.tag = section
                viewAllBtn.addTarget(self, action: #selector(isHidden), for: .touchUpInside)
                viewAllBtn.tag = section
                sectionV.addSubview(titleLbl)
                sectionV.addSubview(viewAllBtn)
                sectionV.bringSubviewToFront(viewAllBtn)
                return sectionV
        }
       return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tbMenu{
            return 50.0
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbMenu{
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellMenuTV, for: indexPath) as! CellMenuTV
            let arrSection = productModal?.categories?[indexPath.section].products
            let imageIndex = (imageURL) + (arrSection?[indexPath.row].image ?? "")
            cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Userssss"))
            cell.lblItemName.text = arrSection?[indexPath.row].productName ?? ""
            cell.lblNewPrice.text = "\(arrSection?[indexPath.row].price ?? 0)"
//            cell.lblPrePrice.attributedText = arrSection.prevPrice[indexPath.row].strikeThrough()
            if arrCheck[indexPath.section] == true {
                cell.viewCell.isHidden = false
                cell.dataStackVW.isHidden = false
            }else{
                cell.viewCell.isHidden = true
                cell.dataStackVW.isHidden = true
            }
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellItemDetailReviewTB, for: indexPath) as! CellItemDetailReviewTB
        let imageIndex = (imageURL) + (self.reviews?[indexPath.row].user?.image ?? "")
        cell.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.img.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "Userssss"))
        cell.lblName.text = self.reviews?[indexPath.row].user?.name ?? ""
        cell.lblReview.text = self.reviews?[indexPath.row].review ?? ""
        cell.cosmosView.rating = Double(self.reviews?[indexPath.row].rating ?? 0)
        cell.lblDate.text = string_date_ToDate(reviews?[indexPath.row].createdAt ?? "", currentFormat: .BackEndFormat, requiredFormat: .mon_dd_yyyy
        )
        return cell
    }
       
       override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if(keyPath == "contentSize"){
               if let newvalue = change?[.newKey]
               {
                   let newsize  = newvalue as! CGSize
                   heightTBMenu.constant = newsize.height
               }
           }
       }

    

}

//MARK: InitialLoad Fnction
extension ItemDetailsVC{
    func initialLoad(){
        viewAbout.layer.cornerRadius = viewAbout.frame.height / 2
        viewAbout.layer.maskedCorners = [.layerMaxXMinYCorner]
        viewMenu.cornerRadius(cornerRadius: 55)
        viewReview.layer.cornerRadius = viewReview.frame.height / 2
        viewReview.layer.maskedCorners = [.layerMinXMinYCorner]
        imgBottomView.layer.cornerRadius = 30.0
        imgBottomView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
        
        lblMenu.lblCornerRadius(cornerRadius: 15.0)
        lblAbout.lblCornerRadius(cornerRadius: 15.0)
        lblReview.lblCornerRadius(cornerRadius: 15.0)
        
        btnFav.layer.cornerRadius = btnFav.frame.height / 2
        
        viewA.isHidden = false
        viewM.isHidden = true
        viewR.isHidden = true
        viewButton.isHidden = true
        //lblAbout Text
        lblAboutDetail.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem \n It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled \n It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem It is a long established fact that a reader will be distracted by the readable c \n It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem It is a long established fact that a reader will be distracted by the readable c"
        //MARK: Menu Offer Arr
     
        if status == 0 {
            let collDineData : [ModelMenuCollView] = [ModelMenuCollView(name: ["Breakfast" , "Lunch" , "Dinner" , "Special"], time: ["08:00 to 10:00" , "13:00 to 13:30" , "19:00 to 20:00" , "13:00 to 13:30"])]
            arrCollMenu.removeAll()
            arrCollMenu.append(contentsOf: collDineData)
        }else{
            let collDrinkData : [ModelMenuCollView] = [ModelMenuCollView(name: ["Tonight" , "Happy Hour" ,                                           "Today" , "Tommorow"],
                                                    time: ["08:00 to 10:00" , "13:00 to 13:30" , "19:00 to 20:00" , "13:00 to 13:30"])]
            arrCollMenu.removeAll()
            arrCollMenu.append(contentsOf: collDrinkData)
        }
    }
    func ChangebgColor(viewSelected : UIView , viewUnselected : UIView, viewUnselected2: UIView , labelSelected : UILabel , labelUnselected : UILabel , labelUnselecte2 : UILabel){
        viewSelected.backgroundColor = UIColor.systemGray5
        viewUnselected.backgroundColor = UIColor.white
        viewUnselected2.backgroundColor = UIColor.white
        labelSelected.backgroundColor = UIColor.white
        labelUnselected.backgroundColor = UIColor.systemGray5
        labelUnselecte2.backgroundColor = UIColor.systemGray5
    }
    
}

//MARK: Objective function
extension ItemDetailsVC{
    @objc func isHidden(sender : UIButton){
        debugPrint(sender.tag)
        switch sender.tag {
        case 0 :
            if sender.isSelected  == false{
                if arrCheck[sender.tag] == false{
                    arrCheck[sender.tag] = true
                    debugPrint(arrCheck)
                    debugPrint(sender.tag)
                    sender.isSelected = true
                    sender.setImage(UIImage(named: "aarrowIcon"), for: .selected)
                }else{
                    arrCheck[sender.tag] = false
                    debugPrint(arrCheck)
                    debugPrint(sender.tag)
                    sender.isSelected = false
                    sender.setImage(UIImage(named: "arrowDefault"), for: .selected)
                }
            }
            debugPrint("Case 0")
        case 1 :
            if sender.isSelected  == false{
                if arrCheck[sender.tag] == false{
                    arrCheck[sender.tag] = true
                    sender.isSelected = true
                }else{
                    arrCheck[sender.tag] = false
                    sender.isSelected = false
                }
            }
            debugPrint("Case 1")
        case 2 :
            if sender.isSelected  == false{
                if arrCheck[sender.tag] == false{
                    arrCheck[sender.tag] = true
                    sender.isSelected = true
                }else{
                    arrCheck[sender.tag] = false
                    sender.isSelected = false
                }
            }
            debugPrint("Case 2")
        case 3 :
            if sender.isSelected  == false{
                if arrCheck[sender.tag] == false{
                    arrCheck[sender.tag] = true
                    sender.isSelected = true
                }else{
                    arrCheck[sender.tag] = false
                    sender.isSelected = false
                }
            }
            debugPrint("Case 3")
            
        default:
            debugPrint("Is Hideen default run")
        }
        tbMenu.reloadData()
    }

}
