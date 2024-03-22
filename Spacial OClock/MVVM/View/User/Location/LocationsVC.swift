//
//  LocationsVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 19/03/24.
//

import UIKit

class LocationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataArr : [LocationList_Body]?
    lazy var viewModel = AuthViewModel()
    var callBack: ((String,String,String)->())?
    @IBOutlet weak var tblVw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblVw.register(UINib(nibName: Cell.HeaderMyOfferCell, bundle: nil), forCellReuseIdentifier:Cell.HeaderMyOfferCell)
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.rowHeight = UITableView.automaticDimension
        getLocationListing()
    }

    //MARK: Get Location List API
    func getLocationListing(){
        viewModel.locationListing { resp in
            self.dataArr = resp ?? []
            self.tblVw.reloadData()
        }
    }
    
    
    
    @IBAction func backBtn (_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnHeaderTarget(_ sender : UIButton){
        for i in 0..<(dataArr?[sender.tag].states?.count ?? 0) {
            dataArr?[sender.tag].states?[i].isSelected = false
        }
        if dataArr?[sender.tag].isSelected == true {
           dataArr?[sender.tag].isSelected = false
       }else {
           dataArr?[sender.tag].isSelected = true
       }
        
        tblVw.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tblVw.dequeueReusableCell(withIdentifier: Cell.HeaderMyOfferCell) as! HeaderMyOfferCell
      
        cellHeader.flagImgVw.isHidden = false
        cellHeader.flagImgVw.showIndicator(baseUrl: imageBaseURL, imageUrl: dataArr?[section].flag_image ?? "")
        cellHeader.lblHeading.text =  dataArr?[section].country?.capitalized ?? ""
        cellHeader.viewHeader.layer.cornerRadius = 10.0
        cellHeader.btnHeader.addTarget(self, action: #selector(btnHeaderTarget), for: .touchUpInside)
        cellHeader.btnHeader.tag = section
        if dataArr?[section].isSelected == true{
            cellHeader.btnArrow.setImage(UIImage.init(named: "arrowIcon1"), for: .normal)
            cellHeader.btnHeader.isSelected = true
            cellHeader.viewHeader.backgroundColor = .systemGray5
            cellHeader.lblSubHeading.isHidden = false
        }else{
            cellHeader.btnArrow.setImage(UIImage.init(named: "arrowDefault"), for: .normal)
            cellHeader.btnHeader.isSelected = false
            cellHeader.viewHeader.backgroundColor = .systemGray6
            cellHeader.lblSubHeading.isHidden = true
        }
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataArr?[section].states?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVw.dequeueReusableCell(withIdentifier: "locationCellOne") as! locationCellOne
        cell.townsArr  = dataArr?[indexPath.section].states?[indexPath.row].cities ?? []
        
        cell.titleLbl.text = dataArr?[indexPath.section].states?[indexPath.row].state?.capitalized ?? ""
        cell.frame = tblVw.bounds
        cell.tblListVw.clipsToBounds = true
        cell.tblListVw.layer.cornerRadius = 12
        cell.layoutIfNeeded()
        cell.tblListVw.reloadData()
        cell.tblListVwHeight.constant = cell.tblListVw.contentSize.height
        if dataArr?[indexPath.section].isSelected == true{
            cell.titleVw.isHidden = false
       }else {
            cell.titleVw.isHidden = true
        }
        
        cell.tblListVw.isHidden = dataArr?[indexPath.section].states?[indexPath.row].isSelected ?? false
         
        if dataArr?[indexPath.section].states?[indexPath.row].isSelected == true {
            cell.tblListVw.isHidden = false
            cell.titleVw.backgroundColor = .systemGray6
            cell.imgVw.image = UIImage.init(named: "arrowIcon1")
        }else {
            cell.titleVw.backgroundColor = .white
            cell.imgVw.image = UIImage.init(named: "arrowDefault")
            cell.tblListVw.isHidden = true
        }
        
        
        cell.callBack = { [weak self] city in
            self?.callBack?(self?.dataArr?[indexPath.section].country ?? "",self?.dataArr?[indexPath.section].states?[indexPath.row].state ?? "",city)
            self?.navigationController?.popViewController(animated: true)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dataArr?[indexPath.section].states?[indexPath.row].isSelected == true {
            dataArr?[indexPath.section].states?[indexPath.row].isSelected = false
        }else {
            dataArr?[indexPath.section].states?[indexPath.row].isSelected = true
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
    var townsArr : [City]?
    var callBack: ((String)->())?
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
        cell.titleLbl.text = townsArr?[indexPath.row].city?.capitalized ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callBack?(townsArr?[indexPath.row].city ?? "")
    }
    
    
    
}
class locationCellTwo: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
}
