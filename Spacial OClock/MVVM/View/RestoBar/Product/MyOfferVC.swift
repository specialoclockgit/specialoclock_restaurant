//
//  MyOfferVC.swift
//  Spacial OClock
//
//  Created by cql211 on 04/07/23.
//

import UIKit
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
    @IBOutlet weak var tbMyOffer : UITableView!
    
    //MARK: Variable
    var arrModelMyOffer : [ModelMyOffer] = [ModelMyOffer(titleName: "Breakfast Special 10 %",
                                                         subTitle: "", timming: "(08:00 to 09:00)", img: ["clubSandwich" ,"grilledSandwich" ,"planeSanwich"], itemName:["Club Sandwich" ,"Grilled Sandwich" , "Plain Sandwich"],prevPrice:  ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R20.00" , "R20.00","R20.00"]),
                                            ModelMyOffer(titleName: "Lunch Special 50%", subTitle: "", timming: "(08:00 to 09:00 )", img: [], itemName: [""], prevPrice: [""], newPrice: [""]) ,
                                            ModelMyOffer(titleName: "Diner Special 30%", subTitle: "", timming: "(16:00 to 22:00)", img: [], itemName: [""], prevPrice: [""], newPrice: [""]) ,
                                            ModelMyOffer(titleName: "Kids Special 40%", subTitle: "", timming: "(16:00 to 22:00)", img: [], itemName: [""], prevPrice: [""], newPrice: [""])]
    var arrCheck : [Bool] = []
//    var viewmodel =
    var datagetApi : [LocationListBody]?
    var viewmodel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupApi()
        tabBarController?.tabBar.isHidden = true
        check()
        let nib = UINib(nibName: Cell.CellMyOfferTB, bundle: nil)
        tbMyOffer.register(nib, forCellReuseIdentifier: Cell.CellMyOfferTB)
        //Regiter Header View
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
            self.check()
            self.tbMyOffer.reloadData()
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
}

extension MyOfferVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datagetApi?[section].states?.count ?? 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datagetApi?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tbMyOffer.dequeueReusableCell(withIdentifier: Cell.HeaderMyOfferCell) as! HeaderMyOfferCell
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
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbMyOffer.dequeueReusableCell(withIdentifier: Cell.CellMyOfferTB) as! CellMyOfferTB
        let section = arrModelMyOffer[indexPath.section]
        cell.lblItemTitle.text = self.datagetApi?[indexPath.section].states?[indexPath.row].state ?? ""
        
        //MARK: Hide And View Cell
        if arrCheck[indexPath.section] == false{
            cell.stackView.isHidden = true
        }else{
            cell.stackView.isHidden = false
        }

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (arrCheck[indexPath.section]) == true ? 30.0 : 0.0
    }
}

//MARK: Objective Functions
extension MyOfferVC{
    @objc func btnEditTarget(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.EditOfferVC)as! EditOfferVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    @objc func btnDeleteTarget(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: Alert.CenterAlertVC) as! CenterAlertVC
        screen.status = 0
        screen.alertMessage = "Are you sure want to delete this Offer?"
        screen.alertImage = "bin"
        self.navigationController?.present(screen, animated: true)
    }
    //MARK: Table Header Button Action
    @objc func btnHeaderTarget(_ sender : UIButton){
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
    func check(){
        
        for _ in 0...(self.datagetApi?.count ?? 0){
            arrCheck.append(false)
        }
        print(arrCheck)
        
    }
}
