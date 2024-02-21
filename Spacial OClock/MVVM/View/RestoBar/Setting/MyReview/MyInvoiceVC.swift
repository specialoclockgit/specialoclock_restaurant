//
//  MyInvoiceVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit
import SwiftGifOrigin

class MyInvoiceVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var tbInvoice : UITableView!
    
    //MARK: Variable
    var viewmodal = restoViewModal()
    var modal : [getInvoiceListModalBody]?
    
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
        get_invoice()
    }
    
    //MARK: - FUNCTIONS
    func get_invoice(){
        viewmodal.get_Invoice { [weak self] fetch in
            self?.modal = fetch
            self?.tbInvoice.reloadData()
        }
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension MyInvoiceVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if modal?.count == 0{
            tableView.setNoDataMessage("No invoice found")
            //imgViewGif.image = UIImage.gif(name: "nodataFound")
           // imgViewGif.isHidden = false
        }else{
            tableView.backgroundView = nil
           // imgViewGif.isHidden = true
            return modal?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbInvoice.dequeueReusableCell(withIdentifier: Cell.CellMyInvoicePaidTV) as! CellMyInvoicePaidTV
        if indexPath.row == 0 {
            let cellPending = tbInvoice.dequeueReusableCell(withIdentifier: Cell.CellMyInvoicePendingTV) as! CellMyInvoicePendingTV
            cell.lblInvoiceDate.text = modal?[indexPath.row].startDate
            cell.lblInvoiceTime.text = modal?[indexPath.row].time
            cell.lblTotalAmmount.text = modal?[indexPath.row].amount
            return cellPending
        }else{
            cell.lblTransactionId.text = "\(modal?[indexPath.row].id ?? 0)"
            cell.lblInvoiceTime.text = modal?[indexPath.row].time
            cell.lblInvoiceDate.text = modal?[indexPath.row].startDate
            cell.lblInvoiceNumber.text = modal?[indexPath.row].invoiceNumber
            cell.lblTotalAmmount.text = modal?[indexPath.row].amount
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.MyInvoiceCellDetailVC) as! MyInvoiceCellDetailVC
        screen.invoice_Id = modal?[indexPath.row].invoiceNumber ?? ""
        if indexPath.row == 0 {
            screen.checkStatus = 0
            screen.statusColor = "themeYellow"
        }else{
            screen.checkStatus = 1
            screen.statusText = "Paid"
            screen.statusColor = "themeGreen"
        }
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
