//
//  MyReviewVC.swift
//  Spacial OClock
//
//  Created by cqlios on 02/07/23.
//

import UIKit

class MyReviewVC: UIViewController {

    //MARK: - OUTLETS
    
    //MARK: - VARIABLES
    
    //MARK: - VEIW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
    }
    //MARK: - ACTIONS
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: - EXTENSIONS
extension MyReviewVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyReviewTVC", for: indexPath) as! MyReviewTVC
        return cell
    }
}
