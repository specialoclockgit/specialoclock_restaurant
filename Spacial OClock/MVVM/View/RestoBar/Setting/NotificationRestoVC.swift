//
//  NotificationRestoVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

import UIKit

class NotificationRestoVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tvNotification : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
//        let nib = UINib(nibName: Cell.CellNotificationRestoTB, bundle: nil)
//        tvNotification.register(nib, forCellReuseIdentifier: Cell.CellNotificationRestoTB)
        tvNotification.delegate = self
        tvNotification.dataSource = self
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension NotificationRestoVC  : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.CellNotificationRestoTB, for: indexPath) as! CellNotificationRestoTB
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    
}
