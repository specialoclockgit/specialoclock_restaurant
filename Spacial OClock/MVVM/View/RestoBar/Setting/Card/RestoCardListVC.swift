//
//  RestoCardListVC.swift
//  Spacial OClock
//
//  Created by cqlios on 03/07/23.
//

import UIKit
struct ModelCardData{
    var img : String
    var check : Bool
}

class RestoCardListVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var btnAddCard : UIButton!
    @IBOutlet weak var tbCard : UITableView!
    
    //MARK: - VARIABLES
    var arrCard : [ModelCardData] = [ModelCardData(img : "visaCard1", check: false),
                                     ModelCardData(img : "creditCard", check: false)]
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        btnAddCard.layer.borderWidth = 1
        btnAddCard.layer.borderColor = UIColor.systemGray5.cgColor
    }
    //MARK: - ACTINOS
    @IBAction func btnAddCard(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProAddCardVc") as! ProAddCardVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnUpdaet(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: - EXTENSIONS
extension RestoCardListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restoCardListTVC", for: indexPath) as! restoCardListTVC
        cell.imgCard.image = UIImage(named: arrCard[indexPath.row].img)
//        switch indexPath.row {
//        case 0 :
//            if arrCard[indexPath.row].check == true {
//            }
//        case 1 :
//            if arrCard[indexPath.row].check == true {
//            }
//        default :
//            debugPrint( "")
//        }
        if arrCard[indexPath.row].check == false {
            cell.viewCell.backgroundColor = UIColor(named: "cardWhiteColor")
            cell.viewCell.layer.borderWidth = 0
            cell.imgBtn.image = UIImage(named: "unselected")
            cell.btnCell.isSelected = false
        }else{
            cell.viewCell.backgroundColor = UIColor(named: "debitThemeColor")
            cell.viewCell.viewBorder(cornerRadius: 10.0, borderWidth: 1, borderColor: UIColor(named: "themeGreen") ?? UIColor())
            cell.imgBtn.image = UIImage(named: "selected")
            cell.btnCell.isSelected = true
        }
        cell.btnCell.addTarget(self, action: #selector(btnCardTarget), for: .touchUpInside)
        cell.btnCell.tag = indexPath.row
        return cell
    }
}
extension RestoCardListVC {
    @objc func btnCardTarget(_ sender : UIButton){
        if sender.isSelected == false{
            arrCard[sender.tag].check = true
        }else{
            arrCard[sender.tag].check = false
        }
        tbCard.reloadData()
    }
}
