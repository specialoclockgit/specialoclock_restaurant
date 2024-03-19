//
//  LocationsVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 19/03/24.
//

import UIKit
struct staticListing {
    var countryName : String?
    var countryImage: UIImage?
    var isSelected : Bool? = false
    var provinceArr : [staticProvince]?
}

struct staticProvince {
    var provinceName :String?
    var townsArr : [staticTowns]?
    var isSelected : Bool? = false
}
struct staticTowns {
    var townName : String?
}
class LocationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var dataArr = [staticListing]()
    
    
    @IBOutlet weak var tblVw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVw.register(UINib(nibName: Cell.HeaderMyOfferCell, bundle: nil), forCellReuseIdentifier:Cell.HeaderMyOfferCell)
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.rowHeight = UITableView.automaticDimension
       
        let data = staticListing(countryName: "India",countryImage: UIImage(named: "ind"),isSelected: false,provinceArr: [staticProvince(provinceName: "Punjab",townsArr: [staticTowns(townName: "Mohali")], isSelected: false),staticProvince(provinceName: "Himachal",townsArr: [staticTowns(townName: "Una")],isSelected: false)])
        self.dataArr.append(data)
        let data1 = staticListing(countryName: "South Africa",countryImage: UIImage(named: "sa"),isSelected: false,provinceArr: [staticProvince(provinceName: "Free State",townsArr: [staticTowns(townName: "Bethlehem"),staticTowns(townName: "Ladybrand"),staticTowns(townName: "Ficksburg")],isSelected: false),staticProvince(provinceName: "Gauteng",townsArr: [staticTowns(townName: "Johannesburg"),staticTowns(townName: "Pretoria")], isSelected: false),staticProvince(provinceName: "Western cape",townsArr: [staticTowns(townName: "Mossel Bay"),staticTowns(townName: "Knysna"),staticTowns(townName: "George")],isSelected: false)])
        self.dataArr.append(data1)
       
        self.tblVw.reloadData()
    }

    
    @IBAction func backBtn (_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnHeaderTarget(_ sender : UIButton){
        for i in 0..<(dataArr[sender.tag].provinceArr?.count ?? 0) {
            dataArr[sender.tag].provinceArr?[i].isSelected = false
        }
       if dataArr[sender.tag].isSelected == true {
           dataArr[sender.tag].isSelected = false
       }else {
           dataArr[sender.tag].isSelected = true
       }
        
        tblVw.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tblVw.dequeueReusableCell(withIdentifier: Cell.HeaderMyOfferCell) as! HeaderMyOfferCell
      
        cellHeader.flagImgVw.isHidden = false
        cellHeader.flagImgVw.image = dataArr[section].countryImage
        cellHeader.lblHeading.text =  dataArr[section].countryName
        cellHeader.viewHeader.layer.cornerRadius = 10.0
        cellHeader.btnHeader.addTarget(self, action: #selector(btnHeaderTarget), for: .touchUpInside)
        cellHeader.btnHeader.tag = section
        if dataArr[section].isSelected == true{
            cellHeader.btnArrow.setImage(UIImage.init(named: "arrowIcon1"), for: .normal)
            cellHeader.btnHeader.isSelected = true
            cellHeader.viewHeader.backgroundColor = .systemGray6
            cellHeader.lblSubHeading.isHidden = false
        }else{
            cellHeader.btnArrow.setImage(UIImage.init(named: "arrowDefault"), for: .normal)
            cellHeader.btnHeader.isSelected = false
            cellHeader.viewHeader.backgroundColor = .white
            cellHeader.lblSubHeading.isHidden = true
        }
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArr[section].provinceArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVw.dequeueReusableCell(withIdentifier: "locationCellOne") as! locationCellOne
        cell.townsArr  = dataArr[indexPath.section].provinceArr?[indexPath.row].townsArr ?? []
        
        cell.titleLbl.text = dataArr[indexPath.section].provinceArr?[indexPath.row].provinceName ?? ""
        cell.frame = tblVw.bounds
        cell.tblListVw.layer.cornerRadius = 12
        cell.layoutIfNeeded()
        cell.tblListVw.reloadData()
        cell.tblListVwHeight.constant = cell.tblListVw.contentSize.height
        if dataArr[indexPath.section].isSelected == true{
            cell.titleVw.isHidden = false
       }else {
            cell.titleVw.isHidden = true
        }
        
        cell.tblListVw.isHidden = dataArr[indexPath.section].provinceArr?[indexPath.row].isSelected ?? false
         
        if dataArr[indexPath.section].provinceArr?[indexPath.row].isSelected == true {
            cell.tblListVw.isHidden = false
            cell.titleVw.backgroundColor = .systemGray6
            cell.imgVw.image = UIImage.init(named: "arrowIcon1")
        }else {
            cell.titleVw.backgroundColor = .white
            cell.imgVw.image = UIImage.init(named: "arrowDefault")
            cell.tblListVw.isHidden = true
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dataArr[indexPath.section].provinceArr?[indexPath.row].isSelected == true {
            dataArr[indexPath.section].provinceArr?[indexPath.row].isSelected = false
        }else {
            dataArr[indexPath.section].provinceArr?[indexPath.row].isSelected = true
        }
        
        self.tblVw.reloadData()
    }
    
    
}




class locationCellOne: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    

    

    @IBOutlet weak var tblListVw: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleVw: UIView!
    @IBOutlet weak var stackVw: UIStackView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var tblListVwHeight: NSLayoutConstraint!
   var townsArr : [staticTowns]?
    override func awakeFromNib() {
        super.awakeFromNib()
        tblListVw.delegate = self
        tblListVw.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return townsArr?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCellTwo") as! locationCellTwo
        cell.titleLbl.text = townsArr?[indexPath.row].townName ?? ""
        return cell
    }
    
    
    
    
}
class locationCellTwo: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
}
