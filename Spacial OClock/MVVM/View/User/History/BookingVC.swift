//
//  HistoryVC.swift
//  Special O'Clock
//
//  Created by cql197 on 19/06/23.
//

import UIKit

class BookingVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var btnCurrent: CustomButton!
    @IBOutlet weak var btnPast: CustomButton!
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var bookingTV: UITableView!
    
    var arrImg = ["Rectangle1","Rectangle 351"]
    var status = 0
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Actions
    
    @IBAction func currentBtn(_ sender: UIButton) {
        status = 0
        lblHeading.text = "Bookings"
        btnCurrent.setTitleColor(UIColor.white, for: .normal)
        btnPast.setTitleColor(UIColor.black, for: .normal)
        btnCurrent.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        btnPast.backgroundColor = .white
        bookingTV.reloadData()
    }
    
    @IBAction func pastBtn(_ sender: UIButton) {
        status = 1
        lblHeading.text = "Orders"
        btnPast.setTitleColor(UIColor.white, for: .normal)
        btnCurrent.setTitleColor(UIColor.black, for: .normal)
        btnPast.backgroundColor = UIColor(red: 254/255, green: 114/255, blue: 19/255, alpha: 1)
        btnCurrent.backgroundColor = .white
        bookingTV.reloadData()
    }
}
//MARK: - UITableViewDelegateUITableViewDataSource
extension BookingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookingCell") as! bookingCell
        if status == 0{
            cell.bookingStatuslbl.text = "Ongoing"
            cell.bookingStatuslbl.textColor = .red
        }else{
            cell.bookingStatuslbl.text = "Completed"
            cell.bookingStatuslbl.textColor = .systemGreen
        }
        cell.itemImg.image = UIImage(named: arrImg[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.bookingDetailVC) as! bookingDetailVC
        if status == 1{
            screen.buttonTitle = "Add Rating & Review"
            screen.buttonColor = "themeOrange"
            screen.status = "Completed"
            screen.statusColor = "themeGreen"
            screen.image = arrImg[indexPath.row]
            screen.statusVerify = 1
        }else{
            screen.buttonTitle = "Cancel Booking"
            screen.buttonColor = "themeRed"
            screen.status = "Ongoing"
            screen.statusColor = "themeRed"
            screen.image = arrImg[indexPath.row]
            screen.statusVerify = 0
        }
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    
}

//MARK: - UITableViewCell
class bookingCell:UITableViewCell{
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var bookingNumber: UILabel!
    @IBOutlet weak var bookingDatelbl: UILabel!
    @IBOutlet weak var bookingTimelbl: UILabel!
    @IBOutlet weak var bookingStatuslbl: UILabel!
    
    
}
