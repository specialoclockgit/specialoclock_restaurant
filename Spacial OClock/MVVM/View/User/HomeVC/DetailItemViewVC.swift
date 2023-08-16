//
//  DetailItemViewVC.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit

//MARK: Variable image3
var arrModel : [ItemsModel] = []

class DetailItemViewVC: UIViewController  {
   
    //MARK: Outlets
    @IBOutlet weak var tbDetailItemView : UITableView!
    @IBOutlet weak var heightTB : NSLayoutConstraint!
    @IBOutlet weak var subview : UIView!
   
    //MARK: Variables
    var iconImage = String()
    var heading = String()
    var locationName = "India"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: Cell.CellDetailViewTB, bundle: nil)
        self.tbDetailItemView.register(nib, forCellReuseIdentifier: Cell.CellDetailViewTB)
        tbDetailItemView.delegate = self
        tbDetailItemView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}
extension DetailItemViewVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbDetailItemView.dequeueReusableCell(withIdentifier: Cell.CellDetailViewTB, for: indexPath) as! CellDetailViewTB
        cell.imgItemICon.image = UIImage(named: iconImage)
        cell.lblHeading.text = heading
        cell.btnCountry.setTitle(locationName, for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(800.0)
    }
    
    
}

