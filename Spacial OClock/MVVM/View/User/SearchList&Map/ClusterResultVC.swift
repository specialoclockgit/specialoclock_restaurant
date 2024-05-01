//
//  ClusterResultVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 01/05/24.
//

import UIKit

class ClusterResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblVw: UITableView!
    var nearByBody : [NearbyRestaurant]?
    var callBack: ((NearbyRestaurant?)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
       // tblVw.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tblVw.bounds.size.width - 10)
       // tblVw.transform = CGAffineTransform(rotationAngle: (-.pi))
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.reloadData()
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
       // cell.transform = CGAffineTransform(rotationAngle: (-.pi))
        cell.listing = nearByBody?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true){
            self.callBack?(self.nearByBody?[indexPath.row])
        }
    }
   

}
