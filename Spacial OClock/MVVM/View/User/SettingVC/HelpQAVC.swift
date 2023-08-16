//
//  HelpQAVC.swift
//  Spacial OClock
//
//  Created by cql211 on 29/06/23.
//

import UIKit

class HelpQAVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tbHelpQA : UITableView!
   
   
    //MARK: Variables
    let nib = UINib(nibName: Cell.CellHelpQAVC, bundle: nil)
    var arrSelectedRow : [Bool] = []
    var tblData = [TBLData]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        for i in 0...10 {
            tblData.append(TBLData(cells: i, seleced: true))
        }
        tbHelpQA.register(nib, forCellReuseIdentifier: Cell.CellHelpQAVC)
        tbHelpQA.delegate = self
        tbHelpQA.dataSource = self
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(){
        self.navigationController?.popViewController(animated: true)
    }
}
extension HelpQAVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellHelpQAVC, for: indexPath) as! CellHelpQAVC
        let index =  indexPath.row
        cell.lblHeading.text = "Question " + index.description
//        cell.lblAnswer.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been dummy text ever since the 1500s.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been dummy text ever since the 1500s."
//        
        cell.btnShow.tag = indexPath.row
        cell.btnShow.addTarget(self, action: #selector(isShowign), for: .touchUpInside)
        if tblData[indexPath.row].seleced == true {
            cell.btnShow.isSelected = true
            cell.lblAnswer.isHidden = true
        }else{
            cell.btnShow.isSelected = false
            cell.lblAnswer.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: Objective function
extension HelpQAVC{
    @objc func isShowign(sender : UIButton){
        if sender.isSelected == false{
            tblData[sender.tag].seleced = true
           // sender.isSelected = true
        }else{
            tblData[sender.tag].seleced = false
           // sender.isSelected = false
        }
        tbHelpQA.reloadData()
    }
}


struct TBLData {
    internal init(cells: Int, seleced: Bool) {
        self.cells = cells
        self.seleced = seleced
    }
    
    var cells: Int
    var seleced: Bool
}
