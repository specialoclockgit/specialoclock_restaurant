//
//  BarMenuVC.swift
//  Spacial OClock
//
//  Created by cql211 on 13/07/23.
//

import UIKit

class BarMenuVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tbMenu : UITableView!
    
    //MARK: - VARIABLES
    var menuname = ["Cocktail", "Wine", "Beer", "Shots"]
    
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
extension BarMenuVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuname.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBarMenuTV", for: indexPath) as! CellBarMenuTV
        cell.lblMenuTitle.text = menuname[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: "BarMenuDetailItemsVC") as! BarMenuDetailItemsVC
        screen.heading = menuname[indexPath.row]
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
