//
//  RestoHomeVC.swift
//  Special O'Clock
//
//  Created by cql99 on 19/06/23.
//

import UIKit

class RestoHomeVC: UIViewController {
    
    //MARK: - OUTLETS
    
    //MARK: - VARIABLES
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - ACTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnNotification(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.NotificationRestoVC) as! NotificationRestoVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
//MARK: - EXTENSIONS
extension RestoHomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestoHomeTVC", for: indexPath) as! RestoHomeTVC
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.bookingDetailsVC) as! bookingDetailsVC
        screen.statusText = "Ongoing"
        screen.isHidden = true
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
