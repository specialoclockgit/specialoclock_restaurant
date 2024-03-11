//
//  AvailabilityDatePopupVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 08/03/24.
//

import UIKit

class AvailabilityDatePopupVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPersonCount: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    var selectedDate : [String] = []
    var date : String?
    var userCount: String?
    var time: String?
    var titleString : String?
    var offer: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI(){
        lblDate.text = nextAvailableDate(selectedDate: self.date ?? "", closedDates: self.selectedDate) ?? "N/A"
        lblTitle.text = titleString
        lblTime.text = "\(self.time ?? "") / \(self.offer ?? "0")%"
        lblPersonCount.text = self.userCount ?? "0"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self.view {
            self.dismiss(animated: true)
        }
    }
    @IBAction func btnGotIt (_ sender: UIButton){
        self.dismiss(animated: true)
    }
    
}
