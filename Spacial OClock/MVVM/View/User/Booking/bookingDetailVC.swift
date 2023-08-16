//
//  bookingDetailVC.swift
//  Spacial OClock
//
//  Created by cql99 on 26/06/23.
//

import UIKit
struct ModelItemDetail {
    var img : String
    var itmeName : String
    var newPrice : String
}

class bookingDetailVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var VeiwOfferCheck: UIView!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var btnMain : UIButton!
    @IBOutlet weak var lblstatus : UILabel!
    
    //MARK: - VARIABLES
    var buttonTitle = String()
    var buttonColor = String()
    var status = String()
    var statusColor = String()
    var image = String()
    var statusVerify = Int()
    var arrData  : [ModelItemDetail] = [ ModelItemDetail(img: "planeSanwich", itmeName: "Sandwich", newPrice: "40.00") , ModelItemDetail(img: "grilledSandwich", itmeName: "Grilled Sandwich", newPrice: "20.00")]
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        btnMain.setTitle(buttonTitle, for: .normal)
        btnMain.backgroundColor = UIColor(named : buttonColor)
        lblstatus.text = status
        lblstatus.textColor = UIColor(named: statusColor)
        img.image = UIImage(named: image)
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnOffer(_ sender: UIButton) {
        if sender.isSelected == false{
            VeiwOfferCheck.isHidden = true
        }else{
            VeiwOfferCheck.isHidden = false
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btnMainAct(_ sender : UIButton){
        debugPrint(statusVerify)
        //Add Ratting
        if statusVerify == 1{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.AddRatingVC) as! AddRatingVC
            self.navigationController?.pushViewController(screen, animated: true)
        }
        //Cancel Booking
        else if statusVerify == 0{
            let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.CancelBookingAlertVC) as! CancelBookingAlertVC
            screen.callBack = {
                let reasonScreen = self.storyboard?.instantiateViewController(withIdentifier: ViewController.CancelBookingReasonVC) as! CancelBookingReasonVC
                reasonScreen.callBack = {
                    let bookingScreen = self.storyboard?.instantiateViewController(withIdentifier: ViewController.BookingVC) as! BookingVC
                    self.navigationController?.pushViewController(bookingScreen, animated: true)
                }
                self.navigationController?.present(reasonScreen, animated: true)
            }
            self.navigationController?.present(screen, animated:true)
            
        }
    }
    
}
//MARK: - EXTENSION
extension bookingDetailVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookingDetailTVC", for: indexPath) as! bookingDetailTVC
        cell.lblPreviousPrice.attributedText =  "R50.00".strikeThrough()
        cell.lblNewPrice.text = "R\(arrData[indexPath.row].newPrice)"
        cell.imgItem.image = UIImage(named: arrData[indexPath.row].img) // arrData[indexPath.row]
        cell.lblItmeName.text = arrData[indexPath.row].itmeName
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tblViewHeight.constant = self.tblView.contentSize.height
        }
    }
}
