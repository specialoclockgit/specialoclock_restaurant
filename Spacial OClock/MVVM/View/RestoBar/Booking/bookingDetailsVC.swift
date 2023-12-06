//
//  bookingDetailsVC.swift
//  Spacial OClock
//
//  Created by cql99 on 19/06/23.
//

import UIKit

class bookingDetailsVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var viewOffer: UIView!
    @IBOutlet weak var imgUser : UIImageView!
    @IBOutlet weak var lblStatus : UILabel!
    @IBOutlet weak var tbItem : UITableView!
    @IBOutlet weak var lblBookingNumebr : UILabel!
    @IBOutlet weak var lblBookingTime : UILabel!
    @IBOutlet weak var lblBookingDate : UILabel!
    @IBOutlet weak var lblNumberOfPeople : UILabel!
    @IBOutlet weak var lblOfferTime : UILabel!
    @IBOutlet weak var btnComplete : UIButton!
    @IBOutlet weak var heightTBItem : NSLayoutConstraint!
    
    //MARK: - VARIABELS
    var offershow = -1
    var status = Int()
    var imgstring = "Ellipse 119"
    var statusText = String()
    var bookingNumber = "05"
    var bookingTime = "16:00 to 22:00"
    var bookingDate = "21 May 2023 "
    var isHidden = Bool()
    var restoid = Int()
    
    //MARK: Variables
    var arrData  : [ModelItemDetail] = [ ModelItemDetail(img: "planeSanwich", itmeName: "Sandwich", newPrice: "40.00") , ModelItemDetail(img: "grilledSandwich", itmeName: "Grilled Sandwich", newPrice: "20.00")]
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        initialLoad()
        tbItem.delegate = self
        tbItem.dataSource = self
    }
    //MARK: - ACTIONS
    @IBAction func btnCheckOffer(_ sender: UIButton) {
        viewOffer.isHidden = sender.isSelected == false ? true : false
        sender.isSelected = !sender.isSelected
//        if offershow == 0 {
//            viewOffer.isHidden = true
//        }else{
//            viewOffer.isHidden = false
//        }
    }
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueAct(_ sender : UIButton){
    }
    
}
extension bookingDetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellBookingDetailTB, for: indexPath) as! CellBookingDetailTB
        cell.lblPrevPrice.attributedText =  "R50.00".strikeThrough()
        cell.lblNewPrice.text = "R\(arrData[indexPath.row].newPrice)"
        cell.img.image = UIImage(named: arrData[indexPath.row].img) 
        cell.lblItemName.text = arrData[indexPath.row].itmeName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [self] in
            heightTBItem.constant = tbItem.contentSize.height
        }
    }
    
}
extension bookingDetailsVC{
    func initialLoad(){
        imgUser.image = UIImage(named: imgstring)
        lblStatus.text = statusText
        lblBookingNumebr.text = bookingNumber
        lblBookingTime.text = bookingTime
        lblBookingDate.text = bookingDate
        lblOfferTime.text = "Offer from " + bookingTime
        viewOffer.isHidden = false
        
        //Complete Buuton Hide and Show
        if status == 0{
            lblStatus.textColor = UIColor(named: "themeAlert")
            btnComplete.isHidden = false
        }else{
            lblStatus.textColor = UIColor(named: "themeGreen")
            btnComplete.isHidden = true
            //Invoice Button
            let barStatus = UserDefaults.standard.status
            if barStatus == 1 {
                btnComplete.isHidden = false
                btnComplete.setTitle("Invoice", for: .normal)
                btnComplete.backgroundColor = UIColor(named: "themeOrange")
            }
        }
        if isHidden == true {
            btnComplete.isHidden = true
        }  
    }
}
