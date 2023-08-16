//
//  RestoSelectCardVC.swift
//  Spacial OClock
//
//  Created by cqlios on 03/07/23.
//

import UIKit

class RestoSelectCardVC: UIViewController {

    @IBOutlet weak var imgViewTick2: UIImageView!
    @IBOutlet weak var imgViewtick: UIImageView!
    @IBOutlet weak var viewDebit: UIView!
    @IBOutlet weak var viewCredit: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnDebit(_ sender: UIButton) {
        self.viewCredit.backgroundColor = #colorLiteral(red: 0.9251520038, green: 0.9909889102, blue: 0.8764565587, alpha: 1)
        self.viewCredit.alpha = 0.2
        self.viewCredit.layer.borderColor = #colorLiteral(red: 0.4322607219, green: 0.792467773, blue: 0.0966636911, alpha: 1)
        self.viewCredit.layer.borderWidth = 0.5
    }
    @IBAction func btnCredit(_ sender: UIButton) {
        self.viewDebit.backgroundColor = #colorLiteral(red: 0.9251520038, green: 0.9909889102, blue: 0.8764565587, alpha: 1)
        self.viewDebit.alpha = 0.2
        self.viewDebit.layer.borderColor = #colorLiteral(red: 0.4322607219, green: 0.792467773, blue: 0.0966636911, alpha: 1)
        self.viewDebit.layer.borderWidth = 0.5
    }
}
