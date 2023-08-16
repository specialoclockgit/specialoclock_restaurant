//
//  MyMenuVC.swift
//  Spacial OClock
//
//  Created by cql99 on 27/06/23.
//

import UIKit

class MyMenuVC: UIViewController {

    //MARK: - OUTLETS
    
    //MARK: - VARIABLES
    var menuname = ["Breakfast", "Lunch", "Kid’s", "Dinner"]
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

    }
    //MARK: - ACTIONS
    @IBAction func btnActBack(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddMenuAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.AddMenuVc) as! AddMenuVc
        self.navigationController?.pushViewController(screen, animated: true)
    }

}
//MARK: - EXTENSIONS
extension MyMenuVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuname.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMenuTvc", for: indexPath) as! MyMenuTvc
        cell.lblName.text = menuname[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.BreakfastVC) as! BreakfastVC
        screen.heading = menuname[indexPath.row]
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
