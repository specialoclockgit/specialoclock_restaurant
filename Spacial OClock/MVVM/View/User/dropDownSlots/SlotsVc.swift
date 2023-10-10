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
    var isselect = -1
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        getslots()
    }
    //MARK: - ACTIONS
    
    //MARK: - FUCNTOINS
    func getslots(){
        viewmodal.getslots_API(date: date, menuid: menuid, restrorant_bar_id: self.restobarId, restoid: restoid, offerid: offerid) { dataa in
            self.timeSlots = dataa?.timeSlots ?? []
            self.tblView.reloadData()
        }
    }

}
//MARK: - EXTENSIONS
extension SlotsVc : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.timeSlots?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "slotsTVC", for: indexPath) as! slotsTVC
        if indexPath.row == isselect{
            cell.btnCheck.setImage(UIImage(named: "Group 7059"), for: .normal)
        }else{
            cell.btnCheck.setImage(UIImage(named: "greyDrink"), for: .normal)
        }
        cell.lblNaem.text = "\(timeSlots?[indexPath.row].startTime ?? "")" + "\(timeSlots?[indexPath.row].endTime ?? "")"
        cell.btnCheck.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isselect = indexPath.row
    }
}
