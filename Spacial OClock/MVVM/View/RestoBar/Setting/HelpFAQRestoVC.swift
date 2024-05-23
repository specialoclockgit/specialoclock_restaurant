//
//  HelpFAQRestoVC.swift
//  Spacial OClock
//
//  Created by cql211 on 06/07/23.
//

//import UIKit
//import CoreMedia
//
//class HelpFAQRestoVC: UIViewController {
//
//    //MARK: Outlets
//    @IBOutlet weak var tbHelpFAQ : UITableView!
//
//    //MARK: Variable
//    var viewmodel = AuthViewModel()
//    var datagetApi: [HelpandFAQModelBody]?
//    var arrCheck : [ModelCheck] = []
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//        tabBarController?.tabBar.isHidden = true
//        // Do any additional setup after loading the view.
//        viewmodel.helpandFaq { data in
//            self.datagetApi = data
//            for i in 0..<(data?.count ?? 0){
//                let obj = ModelCheck(check: false)
//                self.arrCheck.append(obj)
////                self.tbHelpFAQ.estimatedRowHeight = (self.arrCheck[i].check) == true ? 120.0 : 70.0
//            }
//            self.tbHelpFAQ.delegate = self
//            self.tbHelpFAQ.dataSource = self
//            self.tbHelpFAQ.reloadData()
//        }
//
//
//
//    }
//
//    //MARK: Button Action
//    @IBAction func btnBackAct(_ sender : UIButton){
//        self.navigationController?.popViewController(animated: true)
//    }
//}
//extension HelpFAQRestoVC : UITableViewDelegate , UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return datagetApi?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tbHelpFAQ.dequeueReusableCell(withIdentifier: Cell.CellHelpFAQTB, for: indexPath) as! CellHelpFAQTB
//        let data = datagetApi
//        cell.lblQuestionHeading.text = data?[indexPath.row].question
//        cell.lblContent.text = data?[indexPath.row].answer
//        cell.lblQuestionHeading.text = "Question "+(indexPath.row + 01 ).description
//        if arrCheck[indexPath.row].check == false{
//            cell.stackView.isHidden = true
//            cell.btnHideShow.isSelected = false
//        }else{
//            cell.stackView.isHidden = false
//            cell.btnHideShow.isSelected = true
//        }
//        cell.btnHideShow.addTarget(self, action: #selector(hideAndShow), for: .touchUpInside)
//        cell.btnHideShow.tag = indexPath.row
//        return cell
//    }
//
//
//
//
//}
//extension HelpFAQRestoVC {
//    @objc func hideAndShow(_ sender : UIButton){
//        if sender.isSelected == false{
//            arrCheck[sender.tag].check = true
//            sender.isSelected = true
//        }else{
//            arrCheck[sender.tag].check = false
//            sender.isSelected = false
//        }
//        tbHelpFAQ.reloadData()
//    }
//}
struct ModelCheck {
    var check : Bool = false
}
import UIKit
import CoreMedia

class HelpFAQRestoVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var stackVW: UIStackView!
    @IBOutlet weak var tbHelpFAQ : UITableView!
    
    //MARK: Variable
    var viewmodel = AuthViewModel()
    var datagetApi: [HelpandFAQModelBody]?
   
    var selected = -1
    var isSelected = [Bool]()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        viewmodel.helpandFaq { data in
            self.datagetApi = data
            for i in 0..<(data?.count ?? 0){
                self.isSelected.append(false)
                self.tbHelpFAQ.reloadData()
            }
            self.tbHelpFAQ.reloadData()
        }
        tbHelpFAQ.delegate = self
        tbHelpFAQ.dataSource = self
    }
    @objc func plusBtnTapped(sender : UIButton){
        isSelected[sender.tag] = !isSelected[sender.tag]
        if self.selected == sender.tag{
            self.selected = -1
        }
        else{
            self.selected = sender.tag
                }
        tbHelpFAQ.reloadData()
    }
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension HelpFAQRestoVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datagetApi?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbHelpFAQ.dequeueReusableCell(withIdentifier: Cell.CellHelpFAQTB, for: indexPath) as! CellHelpFAQTB
        let data = datagetApi
        cell.lblQuestionHeading.text = data?[indexPath.row].question
        cell.lblContent.text = data?[indexPath.row].answer
        //cell.lblQuestionHeading.text = "Question "+(indexPath.row + 01 ).description
        if self.selected == indexPath.row {
            cell.Vw.isHidden = false
            cell.btnHideShow.isSelected = true
        }
        else{
            cell.Vw.isHidden = true
            cell.btnHideShow.isSelected = false
        }
        cell.btnHideShow.tag = indexPath.row
        cell.btnHideShow.addTarget(self, action: #selector(plusBtnTapped(sender:)), for: .touchUpInside)
return cell
    }
    
}
