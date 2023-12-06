//
//  ReportUserReasonVC.swift
//  Spacial OClock
//
//  Created by cqlios on 30/10/23.
//

import UIKit

class ReportUserReasonVC: UIViewController {
    @IBOutlet weak var btnCross : UIButton!
    @IBOutlet weak var textArea : UITextView!
    @IBOutlet weak var btnSubmit : UIButton!
    var callBack : ((String) -> ())?
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
        self.callBack?(textArea.text)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ReportUserReasonVC  : UITextViewDelegate{
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
extension ReportUserReasonVC{
    func initialLoad(){
        btnCross.layer.cornerRadius = btnCross.frame.height / 2
        textArea.leftSpace()
        textArea.layer.cornerRadius = 15.0
    }
}
