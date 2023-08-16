//
//  RestoProfileVC.swift
//  Spacial OClock
//
//  Created by cql99 on 27/06/23.
//

import UIKit

class RestoProfileVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var btnPreview : UIButton!
    @IBOutlet weak var lblname : UILabel!
    @IBOutlet weak var viewPreview : UIView!
    
    //MARK: - VARIABLES
    var btnCheckStatus = Int()
    var heading = String()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - EXTENSIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEdit(_ sender: UIButton) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.EditRestoProfileVC) as! EditRestoProfileVC
        let status = UserDefaults.standard.status
        if status  == 1 {
            screen.heading = "Edit Bar Profile"
        }else if status == 0{
            screen.heading = "Edit Restaurant Profile"
        }
        self.navigationController?.pushViewController(screen, animated: true)
    }
    @IBAction func btnPreviewAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: "PreviewVC") as! PreviewVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
}

extension RestoProfileVC{
    func initialLoad(){
        lblHeading.text = heading
        debugPrint(heading)
        lblname.text = UserDefaults.standard.name
        btnCheckStatus = UserDefaults.standard.status
        if btnCheckStatus == 0 {
            viewPreview.isHidden = false
        }else if btnCheckStatus == 1{
            viewPreview.isHidden = true
        }
    }
}
