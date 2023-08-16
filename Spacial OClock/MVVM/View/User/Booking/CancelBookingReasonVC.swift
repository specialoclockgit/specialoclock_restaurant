//
//  CancelBookingReasonVC.swift
//  Spacial OClock
//
//  Created by cql211 on 30/06/23.
//

import UIKit

class CancelBookingReasonVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var btnCross : UIButton!
    @IBOutlet weak var textArea : UITextView!
    @IBOutlet weak var btnSubmit : UIButton!
    
    //MARK: Variables
    var callBack : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        textArea.delegate = self
    }
    
    //MARK: Button Action
    @IBAction func btnCrossAct(){
        self.dismiss(animated: true)
    }
    @IBAction func btnSubmitAct(sender : UIButton){
        self.dismiss(animated: true)
        self.callBack?()
    }
}
extension CancelBookingReasonVC  : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textArea.text.count == 0{
            textArea.text = "Write here.."
        }else{
            textView.text = textView.text
        }
    }
}
extension CancelBookingReasonVC{
    func initialLoad(){
        btnCross.layer.cornerRadius = btnCross.frame.height / 2
        textArea.leftSpace()
        textArea.layer.cornerRadius = 15.0
    }
}
