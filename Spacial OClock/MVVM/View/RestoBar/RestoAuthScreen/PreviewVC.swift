//
//  PreviewVC.swift
//  Spacial OClock
//
//  Created by cql211 on 13/07/23.
//

import UIKit

class PreviewVC: UIViewController {
    
    //MARK: Outlet
    
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var scrollView : UIScrollView!
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
    @IBOutlet weak var viewM : UIView!
    @IBOutlet weak var viewR : UIView!
    @IBOutlet weak var viewSV : UIView!
    @IBOutlet weak var imgBottomView : UIImageView!
    //MENU Outlets
    @IBOutlet weak var collViewMenu : UICollectionView!
    @IBOutlet weak var tbMenu : UITableView!
    @IBOutlet weak var heightTBMenu : NSLayoutConstraint!
    @IBOutlet weak var heightTBReview : NSLayoutConstraint!
    @IBOutlet weak var btnFav : UIButton!
    @IBOutlet weak var btnBook : UIButton!
    @IBOutlet weak var viewButton : UIView!
    @IBOutlet weak var imgFav : UIImageView!
    @IBOutlet weak var viewFav : UIView!
    
    
    //MARK: Variable
    var arrCollMenu : [ModelMenuCollView] = [ModelMenuCollView(name: ["Tonight" , "Happy Hour" , "Today" , "Tommorow"], time: ["08:00 to 10:00" , "13:00 to 13:30" , "19:00 to 20:00" , "13:00 to 13:30"])]
    
    var arrTBMenu : [ModelMenuTBCell] = [ModelMenuTBCell(heading: "Vodka", image: ["goose" , "belveder", "Ciroc" ],  itemName: ["Grey Goose" , "Belvedere" , "Ciroc"], prevPrice:                                      ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00" , "R20.00"                                   , "R30.00"]) ,
                                         ModelMenuTBCell(heading: "Gin", image: ["goose" , "belveder", "Ciroc" ], itemName: ["Grey Goose" , "Belvedere" , "Ciroc"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00" , "R20.00" , "R30.00"]),
                                         ModelMenuTBCell(heading: "Rum", image: ["goose" , "belveder", "Ciroc" ], itemName: ["Grey Goose" , "Belvedere" , "Ciroc"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00" , "R20.00" , "R30.00"]),
                                         ModelMenuTBCell(heading: "Tequila", image: ["goose" , "belveder", "Ciroc" ], itemName: ["Grey Goose" , "Belvedere" , "Ciroc"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R40.00" , "R20.00" , "R30.00"])]
    var imgName = UIImage()
    var arrCheck : [Bool] = []
    var btnBookStatus = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
      
//        img.image = imgName
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
        for i in 0...arrTBMenu.count{
            arrCheck.append(true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: Button Action
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func isSelected(sender : UIButton){
//        switch sender.tag {
//        case 0 :
//            viewAbout.ChangebgColor(viewSelected: viewAbout, viewUnselected: viewMenu, viewUnselected2: viewReview, labelSelected: lblAbout, labelUnselected: lblMenu, labelUnselecte2: lblReview)
//            viewA.layoutSubviews()
//            viewA.isHidden = false
//            viewM.isHidden = true
//            viewR.isHidden = true
//            viewButton.isHidden = true
//            debugPrint("0")
//
//        case 1 :
//            viewMenu.ChangebgColor(viewSelected: viewMenu, viewUnselected: viewAbout, viewUnselected2: viewReview, labelSelected: lblMenu, labelUnselected: lblAbout, labelUnselecte2: lblReview)
//            viewA.isHidden = true
//            viewM.isHidden = false
//            viewR.isHidden = true
//            viewButton.isHidden = false
//            btnBookStatus = 0
//            btnBook.setTitle("Book", for: .normal)
//            debugPrint("1")
//
//        case 2 :
//            viewReview.ChangebgColor(viewSelected: viewReview, viewUnselected: viewAbout, viewUnselected2: viewMenu, labelSelected: lblReview, labelUnselected: lblAbout, labelUnselecte2: lblMenu)
//            viewA.isHidden = true
//            viewM.isHidden = true
//            viewR.isHidden = false
//            viewButton.isHidden = false
//            btnBookStatus = 1
//            btnBook.setTitle("Write a Review", for: .normal)
//            debugPrint("2")
//        default:
//            debugPrint("Default Run IsSelected")
//        }
    }
    
    //MARK: Hide And show Offer Description
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
    
    //MARK: Book Button
    @IBAction func btnBookAct(_ sender : UIButton){
        if btnBookStatus == 0{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.NewBookingVC) as! NewBookingVC
            self.navigationController?.pushViewController(screen, animated: true)
        }else if btnBookStatus == 1{
            let screenReview = storyboard?.instantiateViewController(withIdentifier: "AddRatingVC") as! AddRatingVC
            self.navigationController?.pushViewController(screenReview, animated: true)
        }
    }
    
    @IBAction func btnFavAct(_ sender : UIButton){
        if sender.isSelected == false {
            viewFav.backgroundColor = UIColor(named: "themeOrange")
            imgFav.image = UIImage(named: "heartBorder")
           
        }else {
            viewFav.backgroundColor = UIColor(named: "themeGreen")
           imgFav.image = UIImage(named: "white h")
        }
        sender.isSelected = !sender.isSelected
    }
}
extension PreviewVC : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collViewMenu
        {
            return arrCollMenu[section].name.count
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collViewMenu{
            let cell =  collViewMenu.dequeueReusableCell(withReuseIdentifier: Cell.CellMenuCV, for: indexPath) as! CellMenuCV
            if ((indexPath.row % 2 ) == 0)  {
                cell.img.image = UIImage(named: "greenRectangle")
                cell.lblTime.backgroundColor = UIColor(named: "themeGreen")
                cell.lblTime.text = ""
                cell.lblOffer.backgroundColor = UIColor(named: "themeGreen")
            }
            cell.lblTime.text = arrCollMenu[indexPath.section].time[indexPath.row]
            cell.lblMenuSchedule.text = arrCollMenu[indexPath.section].name[indexPath.row]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.CellItemDetailVC, for: indexPath) as! CellItemDetailVC
       //cell.img.image = imgName
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collViewMenu {
            return CGSize (width: 120.0, height: 200.0)
        }
            return CGSize(width: 120.0, height: 80.0)
    }
}

extension PreviewVC : UITableViewDelegate , UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if tableView == tbMenu {
                return arrTBMenu[section].image.count
            }
            return 2
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            if tableView == tbMenu{
                return arrTBMenu.count
            }
            return 1
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if tableView == tbMenu{
                    let sectionV = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50) )
                    sectionV.layer.cornerRadius = 10.0
                
                    let titleLbl = UILabel.init(frame: CGRect(x: 20, y: 15, width: tableView.frame.width-150, height: 20) )
                    titleLbl.text = arrTBMenu[section].heading
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
                let arrSection = arrTBMenu[indexPath.section]
                cell.img.image = UIImage(named: arrSection.image[indexPath.row])
                cell.lblItemName.text = arrSection.itemName[indexPath.row]
                cell.lblPrePrice.text = arrSection.prevPrice[indexPath.row]
                cell.lblNewPrice.text = arrSection.newPrice[indexPath.row]
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
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if tableView == tbMenu{
                return  arrCheck[indexPath.section] == true ?  UITableView.automaticDimension : 0
            }else{
               return UITableView.automaticDimension
            }
        }
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            DispatchQueue.main.async { [self] in
                heightTBMenu.constant = tbMenu.contentSize.height
                heightTBReview.constant = tbReview.contentSize.height
            }
        }
}
extension PreviewVC {
    func initialLoad(){
        viewFav.layer.cornerRadius = viewFav.frame.height / 2
        viewAbout.layer.cornerRadius = viewAbout.frame.height / 2
        viewAbout.layer.maskedCorners = [.layerMaxXMinYCorner]
        viewMenu.cornerRadius(cornerRadius: 30.0)
        viewReview.layer.cornerRadius = 30.0
        viewReview.layer.maskedCorners = [.layerMinXMinYCorner]
        imgBottomView.layer.cornerRadius = 30.0
        imgBottomView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
        
        lblMenu.lblCornerRadius(cornerRadius: 18.0)
        lblAbout.lblCornerRadius(cornerRadius: 18.0)
        lblReview.lblCornerRadius(cornerRadius: 18.0)
        
        btnFav.layer.cornerRadius = btnFav.frame.height / 2
        
        viewA.isHidden = false
        viewM.isHidden = true
        viewR.isHidden = true
        viewButton.isHidden = true
    }
//    func ChangebgColor(viewSelected : UIView , viewUnselected : UIView, viewUnselected2: UIView , labelSelected : UILabel , labelUnselected : UILabel , labelUnselecte2 : UILabel){
//        viewSelected.backgroundColor = UIColor.systemGray5
//        viewUnselected.backgroundColor = UIColor.white
//        viewUnselected2.backgroundColor = UIColor.white
//        labelSelected.backgroundColor = UIColor.white
//        labelUnselected.backgroundColor = UIColor.systemGray5
//        labelUnselecte2.backgroundColor = UIColor.systemGray5
//    }
    
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
