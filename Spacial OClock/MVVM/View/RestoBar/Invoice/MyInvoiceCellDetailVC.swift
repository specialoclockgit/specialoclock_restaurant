//
//  MyInvoiceCellDetailVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit

class MyInvoiceCellDetailVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var viewAlert : UIView!
    @IBOutlet weak var viewDetails : UIView!
    @IBOutlet weak var lblstatus : UILabel!
    @IBOutlet weak var lblTranscationId : UILabel!
    @IBOutlet weak var lblTranscationDate : UILabel!
    @IBOutlet weak var lblInvoiceTime : UILabel!
    @IBOutlet weak var lblInvoiceDate : UILabel!
    @IBOutlet weak var lblInvoiceNumber : UILabel!
    @IBOutlet weak var lblTotalAmount : UILabel!
    @IBOutlet weak var tbBookingDetail : UITableView!
    @IBOutlet weak var btnPayment : UIButton!
    
    //MARK: Variables
    var checkStatus = Int()
    var statusText = String()
    var statusColor = String()
    var transactionId = String()
    var transactionDate = String()
    var invoiceTime = String()
    var invoiceDate = String()
    var totalAmmount = String()
    var invoiceNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        hideView()
        // Do any additional setup after loading the view.
        tbBookingDetail.delegate = self
        tbBookingDetail.dataSource = self
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPaymentAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.SelectCardVC) as! SelectCardVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension MyInvoiceCellDetailVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellMyInvoiceDetailBookingTB) as! CellMyInvoiceDetailBookingTB
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0
    }
    
}
extension MyInvoiceCellDetailVC {
    func initialLoad(){
        lblstatus.text = statusText
        lblstatus.textColor = UIColor(named: statusColor)
        lblTranscationId.text = transactionId
        lblTranscationDate.text = invoiceDate
        lblInvoiceTime.text = invoiceTime
        lblInvoiceDate.text = invoiceDate
        lblTotalAmount.text = totalAmmount
        lblInvoiceNumber.text = invoiceNumber
    }
    func hideView(){
        if checkStatus == 0 {
            viewAlert.isHidden = false
            viewDetails.isHidden = true
            btnPayment.isHidden = false
        }else{
            viewAlert.isHidden = true
            viewDetails.isHidden = false
            btnPayment.isHidden = true
            
        }
    }
}
