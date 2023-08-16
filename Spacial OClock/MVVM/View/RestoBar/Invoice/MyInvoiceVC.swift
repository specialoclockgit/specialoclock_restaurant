//
//  MyInvoiceVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit
struct ModelInvoiceData{
    var transactionId : String
    var invoiceNumber : String
    var invoiceDate : String
    var inoiceTime : String
    var totalAmmount : String
}
class MyInvoiceVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tbInvoice : UITableView!
    
    //MARK: Variable
//    var arrPrice = ["","R110" , "R40" , "R130" , "R70" , "R100"]
    var arrData : [ModelInvoiceData] = [ModelInvoiceData(transactionId: "", invoiceNumber: "22546",                                         invoiceDate: "21 May 2023", inoiceTime: "20:00", totalAmmount: "R60"),
                                        ModelInvoiceData(transactionId: "2547845962358", invoiceNumber: "22546", invoiceDate: "21 May 2023", inoiceTime: "20:00", totalAmmount: "R60") ,
                                        ModelInvoiceData(transactionId: "2547845962358", invoiceNumber: "22546", invoiceDate: "21 May 2023", inoiceTime: "20:00", totalAmmount: "R60") ,
                                        ModelInvoiceData(transactionId: "2547845962358", invoiceNumber: "22546", invoiceDate: "21 May 2023", inoiceTime: "20:00", totalAmmount: "R60"),
                                        ModelInvoiceData(transactionId: "2547845962358", invoiceNumber: "22546", invoiceDate: "21 May 2023", inoiceTime: "20:00", totalAmmount: "R60"),
                                        ModelInvoiceData(transactionId: "2547845962358", invoiceNumber: "22546", invoiceDate: "21 May 2023", inoiceTime: "20:00", totalAmmount: "R60")]
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        tbInvoice.delegate = self
        tbInvoice.dataSource = self
        let nib = UINib(nibName: Cell.CellMyInvoicePendingTV, bundle: nil)
        tbInvoice.register(nib, forCellReuseIdentifier: Cell.CellMyInvoicePendingTV)
        let nibPaid = UINib(nibName: Cell.CellMyInvoicePaidTV, bundle: nil)
        tbInvoice.register(nibPaid, forCellReuseIdentifier: Cell.CellMyInvoicePaidTV)
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension MyInvoiceVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbInvoice.dequeueReusableCell(withIdentifier: Cell.CellMyInvoicePaidTV) as! CellMyInvoicePaidTV
        if indexPath.row == 0 {
            let cellPending = tbInvoice.dequeueReusableCell(withIdentifier: Cell.CellMyInvoicePendingTV) as! CellMyInvoicePendingTV
            cell.lblInvoiceDate.text = arrData[indexPath.row].invoiceDate
            cell.lblInvoiceTime.text = arrData[indexPath.row].inoiceTime
            cell.lblTotalAmmount.text = arrData[indexPath.row].totalAmmount
            return cellPending
        }else{
            cell.lblTransactionId.text = arrData[indexPath.row].totalAmmount
            cell.lblInvoiceTime.text = arrData[indexPath.row].inoiceTime
            cell.lblInvoiceDate.text = arrData[indexPath.row].invoiceDate
            cell.lblInvoiceNumber.text = arrData[indexPath.row].invoiceNumber
            cell.lblTotalAmmount.text = arrData[indexPath.row].totalAmmount
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.MyInvoiceCellDetailVC) as! MyInvoiceCellDetailVC
        let indexData = arrData[indexPath.row]
        screen.transactionId = indexData.transactionId
        screen.totalAmmount = indexData.totalAmmount
        screen.invoiceDate = indexData.invoiceDate
        screen.invoiceTime = indexData.inoiceTime
        screen.invoiceNumber = indexData.invoiceNumber
        if indexPath.row == 0 {
            screen.checkStatus = 0
            screen.statusText = "Pending"
            screen.statusColor = "themeYellow"
        }else{
            screen.checkStatus = 1
            screen.statusText = "Paid"
            screen.statusColor = "themeGreen"
        }
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
