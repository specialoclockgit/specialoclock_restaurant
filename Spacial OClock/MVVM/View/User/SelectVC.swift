//
//  SelectVC.swift
//  Spacial OClock
//
//  Created by cqlios on 26/12/23.
//

import UIKit

class SelectVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnBar: UIButton!
    @IBOutlet weak var btnResto: UIButton!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var viewResto: UIView!
    @IBOutlet weak var viewUser: UIView!
    
    //MARK: - VARIABLES
    var selectStatus = Int()
    var restoselctStatus = Int()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 40
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        Store.status = "\(restoselctStatus)"
        
    }
    //MARK: - ACTIONS
    @IBAction func btnUser(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        if sender.tag == 0 {
            vc.selectStatus = 1
            viewUser.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4470588235, blue: 0.07058823529, alpha: 1)
            btnUser.setTitleColor(UIColor.white, for: .normal)
            viewResto.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
            btnResto.setTitleColor(UIColor.black, for: .normal)
            viewBar.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
            btnBar.setTitleColor(UIColor.black, for: .normal)
        }else if sender.tag == 1{
            vc.selectStatus = 2
            vc.restoselctStatus = 1
            viewUser.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
            btnUser.setTitleColor(UIColor.black, for: .normal)
            viewResto.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4470588235, blue: 0.07058823529, alpha: 1)
            btnResto.setTitleColor(UIColor.white, for: .normal)
            viewBar.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
            btnBar.setTitleColor(UIColor.black, for: .normal)
        }else{
            vc.selectStatus = 3
            vc.restoselctStatus = 2
            viewUser.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
            btnUser.setTitleColor(UIColor.black, for: .normal)
            viewResto.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
            btnResto.setTitleColor(UIColor.black, for: .normal)
            viewBar.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4470588235, blue: 0.07058823529, alpha: 1)
            btnBar.setTitleColor(UIColor.white, for: .normal)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
