//
//  MyInvoiceVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit
import SwiftGifOrigin
import SkeletonView
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
          
        }else{
            tableView.backgroundView = nil
            return modal?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if modal?[indexPath.row].status == 0 {
            let cellPending = tbInvoice.dequeueReusableCell(withIdentifier: Cell.CellMyInvoicePendingTV) as! CellMyInvoicePendingTV
            cellPending.lblInvoiceDate.text = modal?[indexPath.row].endDate
            cellPending.lblInvoiceTime.text = modal?[indexPath.row].time
            cellPending.lblTotalAmmount.text = modal?[indexPath.row].amount
            cellPending.lblInvoiceNumber.text = modal?[indexPath.row].invoiceNumber
            return cellPending
        }else{
            let cell = tbInvoice.dequeueReusableCell(withIdentifier: Cell.CellMyInvoicePaidTV) as! CellMyInvoicePaidTV
            cell.lblTransactionId.text = "\(modal?[indexPath.row].id ?? 0)"
            cell.lblInvoiceTime.text = modal?[indexPath.row].time
            cell.lblInvoiceDate.text = modal?[indexPath.row].endDate
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
        if modal?[indexPath.row].status == 0 {
            screen.checkStatus = 0
        }else{
            screen.checkStatus = 1
        }
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
