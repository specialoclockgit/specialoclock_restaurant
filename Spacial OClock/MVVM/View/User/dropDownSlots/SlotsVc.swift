//
//  SlotsVc.swift
//  Spacial OClock
//
//  Created by cqlios on 10/10/23.
//

import UIKit

class SlotsVc: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: - VARIABELS
    var date = String()
    var menuid = Int()
    var restobarId = Int()
    var restoid = Int()
    var offerid = String()
    var timeSlots: [TimeSlot]?
    var viewmodal = HomeViewModel()
    var isselect = Int()
    var callback : ((String)->())?
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        //getslots()
    }
    //MARK: - ACTIONS
    
    //MARK: - FUCNTOINS
  
}

//MARK: - EXTENSIONS
extension SlotsVc : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.timeSlots?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "slotsTVC", for: indexPath) as! slotsTVC
        cell.lblNaem.text = "\(timeSlots?[indexPath.row].startTime ?? "") - " + "\(timeSlots?[indexPath.row].endTime ?? "")"
        cell.btnCheck.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        callback?(<#String#>)
    }
}
