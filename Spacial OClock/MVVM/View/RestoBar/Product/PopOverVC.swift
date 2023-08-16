//
//  PopOverVC.swift
//  Spacial OClock
//
//  Created by cql211 on 07/07/23.
//

import UIKit

class PopOverVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tbPopOver : UITableView!
    
    //MARK: Variables
    var arr = [""]
    var arrCheck : [ModelCheck] = []
    var arrItem : [ModelItems] = []
    var selectedImage = String()
    var callBack: ((Int) -> ())?
    var statusCheck = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<arr.count{
            arrCheck.append(ModelCheck(check: false))
        }
        setUp()
    }
    
    //MARK: Function
    private func setUp(){
        tbPopOver.delegate = self
        tbPopOver.dataSource = self
    }
}
extension PopOverVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if statusCheck == 2 {
//            return arrItem.count
//        }else {
            return arr.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbPopOver.dequeueReusableCell(withIdentifier: Cell.CellPopOverTV) as! CellPopOverTV
//        cell.lblTitleName.text = arr[indexPath.row]
        
        //Set button selected and unselected and set image
        if arrCheck[indexPath.row].check == false{
            cell.btnCell.isSelected = false
            cell.btnCell.setImage(UIImage(), for: .normal)
        }else{
            cell.btnCell.isSelected = true
            cell.btnCell.setImage(UIImage(named: selectedImage), for: .normal)
        }
        
        //Button Image for offer text field
        if statusCheck == 0 {
            cell.btnCell.layer.cornerRadius = cell.btnCell.frame.height / 2
            cell.btnCell.backgroundColor = UIColor(named: "themeOrange")
            if indexPath.row == arr.count - 1{
                cell.btnCell.backgroundColor = UIColor.systemGray4
                cell.btnCell.setImage(UIImage(named: "addTitlePlus"), for: .normal)
                cell.btnCell.layer.cornerRadius = 0
            }
        }else if statusCheck == 2 {
            cell.lblTitleName.text =  arrItem[indexPath.row].itemName
            if arrItem[indexPath.row].check == true{
                cell.btnCell.setImage(UIImage(named: selectedImage), for: .normal)
            }
        }else {
            cell.lblTitleName.text = arr[indexPath.row]
        }
     
        cell.btnCell.addTarget(self, action: #selector(btnCellTarget), for: .touchUpInside)
        cell.btnCell.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        debugPrint(arr.count)
        self.dismiss(animated: false) {
            self.callBack?(indexPath.row)
        }
    }
}

//MARK: Objective Funcion
extension PopOverVC{
    @objc func btnCellTarget(_ sender : UIButton){
        if sender.isSelected == false{
            arrCheck[sender.tag].check = true
            if statusCheck == 0 {
                self.dismiss(animated: true)
            }else if  statusCheck == 1 {
                self.dismiss(animated: true)
            }
            //self.dismiss(animated: true)
        }else{
            arrCheck[sender.tag].check = false
         
        }
        self.callBack?(sender.tag)
        tbPopOver.reloadData()
    }
}
struct ModelPopOverCheck{
    var checkBtn : Bool
}
