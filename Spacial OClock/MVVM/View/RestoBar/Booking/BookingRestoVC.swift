//
//  BookingVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit
struct ModelBooking {
    var img : String
    var bookingID : String
    var bookingDate : String
    var  bookingTime : String
}
class BookingRestoVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var btnCurrent : UIButton!
    @IBOutlet weak var btnPast : UIButton!
    @IBOutlet weak var tbBooking : UITableView!
    
    //MARK: Variable
    var statusButton = 0
    
    var arrModel : [ModelBooking] = [ModelBooking(img: "restoPerson1", bookingID: "25489564",
                                      bookingDate:  "21 May 2023", bookingTime: "16:00 to 22:00") ,
                                ModelBooking(img: "restoPerson2", bookingID: "25489564",
                                 bookingDate: "21 May 2023", bookingTime: "16:00 to 22:00")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(statusButton)
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: Cell.CellBookingRestoTB, bundle: nil)
        tbBooking.register(nib, forCellReuseIdentifier: Cell.CellBookingRestoTB)
        tbBooking.delegate = self
        tbBooking.dataSource =  self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Button Action
    @IBAction func btnCurrentAct(_ sender : UIButton){
        statusButton = 0
        //debugPrint(statusButton)
        if sender.isSelected == false{
            btnPast.backgroundColor = UIColor.white
            btnPast.setTitleColor(UIColor.black, for: .normal)
            btnCurrent.backgroundColor = UIColor(named: "themeOrange")
            btnCurrent.setTitleColor(UIColor.white, for: .normal)
        
        }
        arrModel = [ModelBooking(img: "restoPerson2", bookingID: "25489564", bookingDate:
                                    "21 May 2023", bookingTime: "16:00 to 22:00") ,
                                    ModelBooking(img: "restoPerson3", bookingID: "25489564", bookingDate:
                                    "21 May 2023", bookingTime: "16:00 to 22:00")]
        tbBooking.reloadData()
    }
    @IBAction func btnPastAct(_ sender : UIButton){
        statusButton = 1
        //debugPrint(statusButton)
        if sender.isSelected == false{
            btnPast.backgroundColor = UIColor(named: "themeOrange")
            btnPast.setTitleColor(UIColor.white, for: .normal)
            btnCurrent.backgroundColor = UIColor.white
            btnCurrent.setTitleColor(UIColor.black, for: .normal)
        }
        arrModel = [ModelBooking(img: "restoPerson1", bookingID: "25489565", bookingDate:
                                    "22 May 2023", bookingTime: "16:00 to 22:00") ,
                                    ModelBooking(img: "restoPerson2", bookingID: "25489566", bookingDate:
                                    "23 May 2023", bookingTime: "18:00 to 23:00")]
        tbBooking.reloadData()
    }
}
extension BookingRestoVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbBooking.dequeueReusableCell(withIdentifier: Cell.CellBookingRestoTB, for: indexPath) as! CellBookingRestoTB
        if statusButton == 0 {
            //Curretn
            cell.lblStatus.text = "Ongoing"
            cell.lblStatus.textColor = UIColor(named: "themeAlert")
            cell.lblBookingIDHeading.text = "Booking Number:"
        }else{
            //Past
            cell.lblStatus.text = "Completed"
            cell.lblStatus.textColor = UIColor(named: "themeGreen")
            cell.lblBookingIDHeading.text = "Booking Id:"
        }
        cell.imgUser.image = UIImage(named: arrModel[indexPath.row].img)
        cell.lblBookingID.text = arrModel[indexPath.row].bookingID
        cell.lblBookingDate.text = arrModel[indexPath.row].bookingDate
        cell.lblBookingTime.text = arrModel[indexPath.row].bookingTime
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        debugPrint(arrModel[indexPath.row].bookingID)
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.bookingDetailsVC) as! bookingDetailsVC
        if statusButton == 0 {
            screen.status = 0
            screen.statusText = "Ongoing"
        }else{
            screen.status = 1
            screen.statusText = "Completed"
        }
        
        screen.bookingTime = arrModel[indexPath.row].bookingTime
        screen.bookingDate = arrModel[indexPath.row].bookingDate
        screen.bookingNumber = arrModel[indexPath.row].bookingID
        screen.imgstring = arrModel[indexPath.row].img
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
}
