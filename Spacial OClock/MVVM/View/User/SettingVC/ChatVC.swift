//
//  ChatVC.swift
//  DatingApp
//
//  Created by cql201 on 10/08/23.
//

import UIKit
import IQKeyboardManagerSwift
import DropDown
class ChatVC: UIViewController, UITextViewDelegate {
    
    //    MARK: - OUTLET
    @IBOutlet weak var msgTextView: IQTextView!
    @IBOutlet weak var bottomView: NSLayoutConstraint!
    @IBOutlet weak var chatTbleView: UITableView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var viewBottom: UIView!
    
    //    MARK: - VARIABLE
    var selectedText: Bool?
    let dropDown = DropDown()
    
    //     MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHandling()
        IQKeyboardManager.shared.enable = true
        msgTextView.delegate = self
        if UIDevice.current.userInterfaceIdiom == .pad {
            viewBottom.layer.cornerRadius = 30
        }else {
            viewBottom.layer.cornerRadius = 25
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    //     MARK: - ACTION
    @IBAction func btnAttachment(_ sender: Any) {
    }
    @IBAction func btnMic(_ sender: Any) {
    }
    @IBAction func btnSend(_ sender: Any) {
    }
//    @IBAction func btnDot(_ sender: UIButton) {
//        dropDown.anchorView = sender
//        dropDown.dataSource = ["Report","Block"]
//        dropDown.show()
//        dropDown.width = 100
//        dropDown.cellHeight = 30
//        dropDown.direction = .bottom
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 10
//        // Top of drop down will be below the anchorView
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            if index == 0 {
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpReportReasonVC") as! PopUpReportReasonVC
//                vc.modalPresentationStyle = .overFullScreen
//                self.navigationController?.present(vc, animated: true)
//            }else {
//
//            }
//        }
//    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //     MARK: - FUNCTION
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == msgTextView {
            selectedText = true
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height >= 45{
            if textView.contentSize.height >= 100 {
                heightConst.constant = 100
            }
            else {
                heightConst.constant = textView.contentSize.height + 5
            }
        }
    }
}
// MARK: - EXTENSION OF TABLEVIEW
extension ChatVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderTVC", for: indexPath) as! senderTVC
        return cell
    }
}
//MARK: - KEYBOARD HANDLING
extension ChatVC {
    private func keyboardHandling(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.bottomView.constant = 10
    }
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136,1334,1920, 2208:
                    print("")
                    self.bottomView.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom+3)
                case 2436,2688,1792:
                    print("")
                    self.bottomView.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom+10)
                default:
                    print("")
                    self.bottomView.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom+10)
                }
            }
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        }
    }
    
    //MARK: - TABLE VIEW SCROLL TO BOTTOM
    func tableViewScrollToBottom() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0)) {
            let numberOfSections = self.chatTbleView.numberOfSections
            let numberOfRows = self.chatTbleView.numberOfRows(inSection: 0)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows - 1, section: (numberOfSections - 1))
                self.chatTbleView.scrollToRow(at: indexPath, at: .bottom, animated: false )
            }
        }
    }
}
