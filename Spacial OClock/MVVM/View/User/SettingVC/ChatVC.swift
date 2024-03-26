//
//  ChatVC.swift
//  DatingApp
//
//  Created by cql201 on 10/08/23.
//

import UIKit
import IQKeyboardManagerSwift
import DropDown
import SDWebImage
import MBProgressHUD


class ChatVC: UIViewController, UITextViewDelegate {
    
    //MARK: - OUTLET
    @IBOutlet weak var msgTextView: IQTextView!
    @IBOutlet weak var bottomView: NSLayoutConstraint!
    @IBOutlet weak var chatTbleView: UITableView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var viewBottom: UIView!
    
    //MARK: - VARIABLE
    var selectedText: Bool?
    let dropDown = DropDown()
    var chatmodel :[MessageListModel]?
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scroolTOLast()
        keyboardHandling()
//        if SocketIOManager.sharedInstance.socket.status != .connected
//        {
//            SocketIOManager.sharedInstance.connectMySocket()
//        }
//        SocketIOManager.sharedInstance.connect_user()
        allsockets()
        
        IQKeyboardManager.shared.enable = true
        msgTextView.delegate = self
        if UIDevice.current.userInterfaceIdiom == .pad {
            viewBottom.layer.cornerRadius = 30
        }else {
            viewBottom.layer.cornerRadius = 25
        }
        DispatchQueue.main.async {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    func allsockets(){
        if  SocketIOManager.sharedInstance.socket.status == .connected {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.sockectConnnet()
            }
        } else{
            SocketIOManager.sharedInstance.connectMySocket()
//            SocketIOManager.sharedInstance.connect_user()
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.sockectConnnet()
            }
        }
    }
    // MARK: - socket FUCTIONS
    func sockectConnnet(){
        SocketIOManager.sharedInstance.messageListemitter(user2id: 1, limit: 10, offset: 0)
        fetchMessages()
        sendMessageListener()
        clearChatListener()
    }
    
    //     MARK: - ACTION
    
    @IBAction func btnClearChat(_ sender: UIButton) {
        if chatmodel?.count == 0 {
            CommonUtilities.shared.showAlert(message: "There is no message that needs deleting", isSuccess: .error)
        }
        else {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to clear all message?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Yes", style: .default, handler: { action in
                SocketIOManager.sharedInstance.clearChatemitter(user2id: 1)
                CommonUtilities.shared.showAlert(message: "Messages clear successfully", isSuccess: .success)
            })
            alert.addAction(ok)
            let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
                self.dismiss(animated: true)
            })
            alert.addAction(cancel)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
        
        
       
    }
    
    @IBAction func btnAttachment(_ sender: Any) {
    }
    
    @IBAction func btnMic(_ sender: Any) {
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        let string = self.msgTextView.text?.trimmingCharacters(in: .whitespaces)
        if string != "" {
            SocketIOManager.sharedInstance.send_message_emitter(user2Id: 1, msg_type: 1, message: string ?? "")
            self.msgTextView.text = ""
            self.heightConst.constant = 50
            scroolTOLast()
            self.view.layoutIfNeeded()
        }
        else {
            CommonUtilities.shared.showAlert(message: "Please write a message to send", isSuccess: .error)
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - FUNCTION
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chatmodel?.count == 0 {
            chatTbleView.setNoDataMessage("No message found", txtColor: .black)
        }
        else{
            chatTbleView.backgroundView = nil
            return chatmodel?.count ?? 0
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Store.userDetails?.id ?? 0 != chatmodel?[indexPath.row].senderID ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receverTVC", for: indexPath) as! receverTVC
            cell.receverView.layer.cornerRadius = 6
            cell.receverView.clipsToBounds = true
            cell.receverView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner]
            cell.lblRecever.text = chatmodel?[indexPath.row].message ?? ""
            let isoDate =  self.chatmodel?[indexPath.row].createdAt ?? ""
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                   let date = dateFormatter.date(from: isoDate)
                   cell.lblTime.text = date?.toLocalTime().timeAgoSinceDate()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderTVC", for: indexPath) as! senderTVC
            cell.lblSenderMsg.text = chatmodel?[indexPath.row].message ?? ""
            cell.senderView.layer.cornerRadius = 6
            cell.senderView.clipsToBounds = true
            cell.senderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner]
            let isoDate =  self.chatmodel?[indexPath.row].createdAt ?? ""
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                   let date = dateFormatter.date(from: isoDate)
            cell.lblSenderTime.text = date?.toLocalTime().timeAgoSinceDate()
            return cell
        }
        
        
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


extension ChatVC {
    private func fetchMessages(){
        SocketIOManager.sharedInstance.messageListlisner { data in
            self.chatmodel = data
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if (self.chatmodel?.count ?? 0 ) > 0 {
                    let indexPath = IndexPath(row:( self.chatmodel?.count ?? 0 ) - 1, section: 0)
                    self.chatTbleView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                }
            }
            self.chatTbleView.reloadData()
            DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    func scroolTOLast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if (self.chatmodel?.count ?? 0 ) > 0 {
                let indexPath = IndexPath(row:( self.chatmodel?.count ?? 0 ) - 1, section: 0)
                self.chatTbleView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }
    }
    
    private func sendMessageListener(){
        SocketIOManager.sharedInstance.sendMessageLisner { data in
            
            let results = self.chatmodel?.filter { $0.id == data.id }
            if results?.isEmpty == true {
                self.chatmodel?.append(data)
                self.msgTextView.text = ""
                
                self.chatTbleView.reloadData()
                
                self.scroolTOLast()
            }
            
        }
    }
    
    private func clearChatListener(){
        SocketIOManager.sharedInstance.clearChatListener {
            self.chatmodel?.removeAll()
            self.chatTbleView.reloadData()
        }
    }
    
}

//MARK:- Extensions UITableView view
extension UITableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
    
    func setNoDataMessage(_ message: String,txtColor : UIColor = .black,yPosition : CGFloat = -50) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        let imageOrGifName = "nodataFound"
        if let imageOrGifURL = Bundle.main.url(forResource: imageOrGifName, withExtension: "gif") ?? Bundle.main.url(forResource: imageOrGifName, withExtension: "png") {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.sd_setImage(with: imageOrGifURL)
            view.addSubview(imageView)
            
            let messageLabel = UILabel()
            messageLabel.text = message
            messageLabel.textColor = txtColor
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            messageLabel.sizeToFit()
            view.addSubview(messageLabel)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yPosition), // Adjust this value for vertical positioning
                imageView.widthAnchor.constraint(equalToConstant: 300), // Adjust the width as needed
                imageView.heightAnchor.constraint(equalToConstant: 200), // Adjust the height as needed
                
                messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                messageLabel.widthAnchor.constraint(equalToConstant: self.bounds.width - 60), // Adjust the width as needed
            ])
            
            self.backgroundView = view
            self.separatorStyle = .none
        }
    }
}

//MARK: - UICOLLECTION VIEW 
extension UICollectionView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
    
    func setNoDataMessageLbl(_ message: String,txtColor:UIColor) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = txtColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Poppins-Medium", size: 16)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
    
    func setNoDataMessage(_ message: String,txtColor:UIColor = .black,yPosition : CGFloat = -50) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        
        let imageOrGifName = "nodataFound"
        if let imageOrGifURL = Bundle.main.url(forResource: imageOrGifName, withExtension: "gif") ?? Bundle.main.url(forResource: imageOrGifName, withExtension: "png") {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.sd_setImage(with: imageOrGifURL)
            view.addSubview(imageView)
         //   imageView.layer.borderColor  = UIColor.red.cgColor
           // imageView.layer.borderWidth = 2
            let messageLabel = UILabel()
            messageLabel.text = message
            messageLabel.textColor = txtColor
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            view.addSubview(messageLabel)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yPosition), // Adjust this value for vertical positioning
                imageView.widthAnchor.constraint(equalToConstant: (self.bounds.width / 2) ), // Adjust the width as needed 300
                imageView.heightAnchor.constraint(equalToConstant: (self.bounds.height / 2) ), // Adjust the height as needed 200
                
                messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
                messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                messageLabel.widthAnchor.constraint(equalToConstant: self.bounds.width - 40), // Adjust the width as needed
            ])
            
            self.backgroundView = view
        }
    }
}

// MARK: - EXTENSION FOR DATE
extension Date {
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func timeAgoSinceDate() -> String {
        
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = Date()
        
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "mon ago" : "\(interval)" + " " + "mon ago"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "min ago" : "\(interval)" + " " + "min ago"
        }
        
        return "just now"
    }
}
