//
//  NotificationVC.swift
//  Spacial OClock
//
//  Created by cql211 on 29/06/23.
//

import UIKit

class NotificationVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tbNotification : UITableView!
    @IBOutlet weak var heigthTB : NSLayoutConstraint!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var viewScroll : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        let nib = UINib(nibName: Cell.CellNotificationVC, bundle: nil)
        tbNotification.register(nib, forCellReuseIdentifier: Cell.CellNotificationVC)
        tbNotification.delegate = self
        tbNotification.dataSource = self
    }
    
    //MARK: Button Action
    @IBAction func btnbackAct(){
        self.navigationController?.popViewController(animated: true)
    }

}
extension NotificationVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbNotification.dequeueReusableCell(withIdentifier: Cell.CellNotificationVC) as! CellNotificationVC
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension //CGFloat(140.0)
    }
}

