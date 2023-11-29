//
//  NotificationRestoVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit
import SDWebImage

class NotificationRestoVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tvNotification : UITableView!
    
    //MARK: - VARIABLES
    var viewmodal = restoViewModal()
    var modal : [notificationListModalBody]?
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        tvNotification.delegate = self
        tvNotification.dataSource = self
        notificationlist()
    }
    
    //MARK: - FUNCTION
    func notificationlist(){
        viewmodal.getNotificationList { [weak self] fetchdata in
            self?.modal = fetchdata
            self?.tvNotification.reloadData()
        }
    }
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension NotificationRestoVC  : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modal?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellNotificationRestoTB, for: indexPath) as! CellNotificationRestoTB
        cell.lblUserName.text = modal?[indexPath.row].userName ?? ""
        cell.lblNotificationMessage.text = modal?[indexPath.row].message ?? ""
        cell.lblDay.text = modal?[indexPath.row].createdAt ?? ""
        let imageIndex = (productImgURL) + (modal?[indexPath.row].userImage ?? "")
        cell.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgUser.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    
}
