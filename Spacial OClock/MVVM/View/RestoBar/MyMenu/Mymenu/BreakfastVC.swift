//
//  BreakfastVC.swift
//  Spacial OClock
//
//  Created by cql211 on 03/07/23.
//

import UIKit

class BreakfastVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tbBreakfast : UITableView!
    @IBOutlet weak var btnAddProduct : UIButton!
    @IBOutlet weak var lblHeading : UILabel!
    
    //MARK: Variables
    var arrModel : [BreakFastModel] = [BreakFastModel(img: "planeSanwich", itemName: "Plain Sandwich") ,                                 BreakFastModel(img: "grilledSandwich", itemName:"Grilled Sandwich"),
                                       BreakFastModel(img: "clubSandwich", itemName: "Club Sandwich") ,
                                       BreakFastModel(img: "planeSanwich", itemName: "Plain Sandwich") ,
                                       BreakFastModel(img: "grilledSandwich", itemName: "Grilled Sandwich") ,
                                     BreakFastModel(img: "clubSandwich", itemName: "Club Sandwich") ,
                                     BreakFastModel(img: "planeSanwich", itemName: "Plain Sandwich") ,
                                     BreakFastModel(img: "grilledSandwich", itemName: "Grilled Sandwich") ,
                                    BreakFastModel(img: "clubSandwich", itemName: "Club Sandwich") ,
                                    BreakFastModel(img: "planeSanwich", itemName: "Plain Sandwich")
    ]
    var heading = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHeading.text = heading
        tbBreakfast.delegate = self
        tbBreakfast.dataSource = self
        
        let nib = UINib(nibName: Cell.CellBreakfastTB, bundle: nil)
        tbBreakfast.register(nib, forCellReuseIdentifier: Cell.CellBreakfastTB)
    }
    //MARK: Button Action
    @IBAction func btnBakAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddProductAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.AddProductVC) as! AddProductVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension BreakfastVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellBreakfastTB, for: indexPath) as! CellBreakfastTB
        cell.img.image = UIImage(named: arrModel[indexPath.row].img)
        cell.lblTitle.text = arrModel[indexPath.row].itemName
        cell.btnDelete.addTarget(self, action: #selector(btnDeleteTarget), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(btnEditTarget), for: .touchUpInside)
        cell.btnEdit.tag = indexPath.row
        return cell
    }
}
//MARK: Objective function
extension BreakfastVC{
    //Cell Delete Btn Target
    @objc func btnDeleteTarget(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: Alert.CenterAlertVC) as! CenterAlertVC
        screen.alertImage = "Delete"
        screen.alertMessage = AlertMessage.deleteProduct
        self.navigationController?.present(screen, animated: true)
    }
    //Cell Edit Btn Target
    @objc func btnEditTarget(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.EditProductVC) as! EditProductVC
        screen.price = "R50.00"
        screen.imgName = arrModel[sender.tag].img
        screen.productName = arrModel[sender.tag].itemName
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
struct BreakFastModel{
    var img : String
    var itemName : String
}
