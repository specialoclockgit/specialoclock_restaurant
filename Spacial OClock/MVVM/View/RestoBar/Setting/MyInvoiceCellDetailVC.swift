//
//  MyInvoiceCellDetailVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit
import StripePaymentSheet

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
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tbBookingDetail : UITableView!
    @IBOutlet weak var btnPayment : UIButton!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    //MARK: Variables
    var checkStatus = Int()
    var invoice_Id = String()
    var viewmodal = restoViewModal()
    var modal : invoiceDetailModalBody?
    var bookings: [Booking]?
    var paymentSheet: PaymentSheet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideView()
        tbBookingDetail.delegate = self
        tbBookingDetail.dataSource = self
        invoice_Detail()
        tbBookingDetail.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if(keyPath == "contentSize"){
                if let newvalue = change?[.newKey] {
                    let newsize  = newvalue as! CGSize
                    tblHeight.constant = newsize.height
                }
            }
        }
    
    //MARK: - FUNCTION
    func invoice_Detail(){
        viewmodal.get_Invoice_Detail(invoice_number: invoice_Id) { data in
            self.modal = data
            self.bookings = data?.bookings ?? []
            if self.modal?.invoice?.status == 0{
                self.lblstatus.text = "Pending"
                self.lblstatus.textColor = UIColor(named: "themeYellow")
            }else{
                self.lblstatus.text = "Paid"
                self.lblstatus.textColor = UIColor(named: "themeGreen")
            }
            self.lblInvoiceNumber.text = data?.invoice?.invoiceNumber ?? ""
            self.lblInvoiceDate.text = data?.invoice?.endDate ?? ""
            self.lblInvoiceTime.text = data?.invoice?.time ?? ""
            let totalAmount = data?.bookings?.map({Int($0.bookingAmount ?? "0") ?? 0}).reduce(0, +) ?? 0
            self.lblTotalAmount.text =  totalAmount.description
            //data?.invoice?.amount ?? ""
            self.tbBookingDetail.reloadData()
            
        }
    }
    
    //MARK: - SET STRIPE
    func setupStripe(model: paymentModalBody) {
        STPAPIClient.shared.publishableKey = model.stripePublishKey
        // MARK: Create a PaymentSheet instance
        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Example, Inc."
        configuration.customer = .init(id: model.customer ?? "", ephemeralKeySecret: model.ephemeralKey ?? "")
        // Set `allowsDelayedPaymentMethods` to true if your business handles
        // delayed notification payment methods like US bank accounts.
        configuration.allowsDelayedPaymentMethods = true
        self.paymentSheet = PaymentSheet(paymentIntentClientSecret: model.paymentIntent ?? "", configuration: configuration)
        
        DispatchQueue.main.async {
            // self.checkoutButton.isEnabled = true
            self.paymentSheet?.present(from: self) { paymentResult in
                // MARK: Handle the payment result
                switch paymentResult {
                case .completed:
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentCenterAlertVC") as! PaymentCenterAlertVC
                    vc.callback = {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestoHomeVC") as! RestoHomeVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    self.navigationController?.present(vc, animated: true)
                    print("Your order is confirmed")
                case .canceled:
                    print("Canceled!")
                case .failed(let error):
                    print("Payment failed: \(error)")
                }
            }
        }
        
        //})
        //  task.resume()
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPaymentAct(_ sender : UIButton){
        viewmodal.invoice_Payment_aPI(amount: 100, invoiceNumber: self.lblInvoiceNumber.text ?? "") { data in
            self.setupStripe(model: data!)
        }
    }
}
extension MyInvoiceCellDetailVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellMyInvoiceDetailBookingTB) as! CellMyInvoiceDetailBookingTB
        cell.lblPrice.text = bookings?[indexPath.row].bookingAmount ?? ""
        cell.lblBookingNumber.text = bookings?[indexPath.row].invoiceNumber ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0
    }
    
}
extension MyInvoiceCellDetailVC {
    
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
