//
//  BarOfferVC.swift
//  Spacial OClock
//
//  Created by cql211 on 13/07/23.
//

import UIKit

class BarOfferVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tbMyOffer : UITableView!

    //MARK: Variable
    var arrModelMyOffer : [ModelMyOffer] = [ModelMyOffer(titleName: "Tonight special", subTitle: "Beer",
                                                         timming: "(08:00 am to 09:00 am)", img: ["goose" ,"Ciroc" ,"belveder"], itemName:["Grey Goose" ,"Ciroc" , "Belvedere"],prevPrice:  ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R20.00" , "R20.00","R20.00"]),
                                            ModelMyOffer(titleName: "Happy hours", subTitle: "", timming: "(08:00 am to 09:00 am)", img: [], itemName: ["Grey Goose" ,"Ciroc" , "Belvedere"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R20.00" , "R20.00", "R20.00"]) ,
                                            ModelMyOffer(titleName: "Club special", subTitle: "", timming: "(16:00 to 22:00)", img: [], itemName: ["Grey Goose" ,"Ciroc" , "Belvedere"], prevPrice: ["R50.00" , "R50.00" , "R50.00"], newPrice: ["R20.00" , "R20.00", "R20.00"])]
    var arrCheck : [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        check()
        let nib = UINib(nibName: Cell.CellBarOfferTV, bundle: nil)
        tbMyOffer.register(nib, forCellReuseIdentifier: Cell.CellBarOfferTV)
        //Regiter Header View
        tbMyOffer.register(UINib(nibName: Cell.HeaderMyOfferCell, bundle: nil), forCellReuseIdentifier:Cell.HeaderMyOfferCell)
        tbMyOffer.delegate = self
        tbMyOffer.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
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
extension BarOfferVC : UITableViewDelegate , UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  arrModelMyOffer[section].img.count
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return arrModelMyOffer.count
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let cellHeader = tbMyOffer.dequeueReusableCell(withIdentifier: Cell.HeaderMyOfferCell) as! HeaderMyOfferCell
            cellHeader.lblHeading.text = arrModelMyOffer[section].titleName
            cellHeader.lblSubHeading.text = arrModelMyOffer[section].subTitle
            cellHeader.lblTimming.text = arrModelMyOffer[section].timming
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
            let cell = tbMyOffer.dequeueReusableCell(withIdentifier: Cell.CellBarOfferTV, for: indexPath) as! CellBarOfferTV
            let section = arrModelMyOffer[indexPath.section]
            cell.imgItem.image = UIImage(named: section.img[indexPath.row])
            cell.lblItemTitle.text = section.itemName[indexPath.row]
            cell.lblItemPrevPrice.text = section.prevPrice[indexPath.row]
            cell.lblItemNewPRice.text = section.newPrice[indexPath.row]
            //MARK: Hide And View Cell
            if arrCheck[indexPath.section] == false{
                cell.stackView.isHidden = true
            }else{
                cell.stackView.isHidden = false
            }
            cell.btnEdit.addTarget(self, action: #selector(btnEditTarget), for: .touchUpInside)
            cell.btnEdit.tag = indexPath.section
            cell.btnDelete.addTarget(self, action: #selector(btnDeleteTarget), for: .touchUpInside)
            cell.btnDelete.tag = indexPath.section
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return (arrCheck[indexPath.section]) == true ? 60.0 : 0.0
        }
}
//MARK: Objective Functions
extension BarOfferVC{
    
    @objc func btnEditTarget(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: "EditOfferVC") as! EditOfferVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    @objc func btnDeleteTarget(_ sender : UIButton){
        debugPrint("My offer VC Btn Edit" , sender.tag)
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
extension BarOfferVC {
    func check(){
        for _ in 0...arrModelMyOffer.count{
            arrCheck.append(false)
        }
        debugPrint(arrCheck)
    }
}
