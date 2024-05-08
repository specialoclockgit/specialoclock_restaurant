//
//  ClusterResultVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 01/05/24.
//

import UIKit

class ClusterResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var nearByBody : [NearbyRestaurant]?
    var callBack: ((NearbyRestaurant?)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.reloadData()
        tblVw.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if(keyPath == "contentSize"){
                if let newvalue = change?[.newKey]  {
                    let newsize  = newvalue as! CGSize
                    if newsize.height >= (self.view.frame.height / 2) {
                        tableHeight.constant = (self.view.frame.height / 2)
                        tblVw.isScrollEnabled = true
                    } else {
                        tblVw.isScrollEnabled = false
                        tableHeight.constant = newsize.height
                    }
                }
            }
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self.view {
            self.dismiss(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearByBody?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblVw.dequeueReusableCell(withIdentifier: "mapViewTVC", for: indexPath) as? mapViewTVC else {
            return UITableViewCell()
        }
        cell.listing = nearByBody?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true){
            self.callBack?(self.nearByBody?[indexPath.row])
        }
    }
   

}
