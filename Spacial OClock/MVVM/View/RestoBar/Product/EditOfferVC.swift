//
//  EditOfferVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit

class EditOfferVC: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var tvDescription : UITextView!
    @IBOutlet weak var tfOffer : UITextField!
    @IBOutlet weak var tfSelectMenu : UITextField!
    @IBOutlet weak var tfSelectItem : UITextField!
    @IBOutlet weak var tfSelectOffer : UITextField!
    @IBOutlet weak var tfTimeFrame : UITextField!
    @IBOutlet weak var tfSelectDate : UITextField!
    @IBOutlet weak var tfSelectNoOfUser : UITextField!
    @IBOutlet weak var tfType : UITextField!
    @IBOutlet weak var btnUpdate : UIButton!
    @IBOutlet weak var viewType : UIView!
    
    //MARK: Variables
    var pickerView = UIPickerView()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return datePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPopOverAct(_ sender : UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopOverVC") as! PopOverVC
        vc.preferredContentSize = CGSize(width:330,height: 250)
        vc.modalPresentationStyle = .popover
        if let pres = vc.presentationController {
            pres.delegate = self
        }
        if let pop = vc.popoverPresentationController {
            pop.sourceView = sender
            pop.permittedArrowDirections = .up
            pop.sourceRect =  (sender).bounds
        }
        switch sender.tag {
        case 0:
            vc.arr = ["Breakfast Special" , "Lunch Special" , "Dinner Special" , "Add Title"]
            vc.selectedImage = "dotSelected"
            vc.callBack = { data in
                debugPrint(data)
                self.tfOffer.text = vc.arr[data]
            }
        case 1:
            vc.arr = ["Menu 1" , "Menu 2" , "Menu 3","Menu 4"]
            vc.selectedImage = "tickCheck"
            vc.callBack = { data in
                self.tfSelectMenu.text = vc.arr[data]
            }
        case 2:
            vc.arr = ["Item 1" , "Item 2" , "Item 3","Item 4"]
            vc.selectedImage = "tickCheck"
            vc.callBack = { data in
                self.tfSelectItem.text = vc.arr[data]
            }
        default :
            debugPrint("")
        }
        vc.statusCheck = sender.tag
        self.present(vc, animated: true, completion: nil)
    }
}
extension EditOfferVC: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
            return .none
    }
}
//MARK: Text view delegate
extension EditOfferVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        tvDescription.text = ""
        tvDescription.textColor = UIColor.black
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if tvDescription.text.count == 0 {
            tvDescription.text = "Write here..."
            tvDescription.textColor = UIColor.lightGray
        }else{
            //tvDescription.textColor = UIColor.black
        }
    }
}
extension EditOfferVC{
    func initialLoad(){
        view.hideKeyboardWhenTappedAround()
        tvDescription.layer.cornerRadius = 10.0
        tvDescription.leftSpace()
        tfType.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfOffer.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfSelectMenu.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfSelectItem.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfSelectOffer.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfTimeFrame.setupRightImage(imageName: "clock", width: 15, height: 15)
        tfTimeFrame.inputView = pickerView
        
        //Date picker view
        tfSelectDate.setupRightImage(imageName: "calendar", width: 15, height: 15)
        tfSelectDate.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        //Check for Bar
        let status = UserDefaults.standard.status
        if status == 0{
            viewType.isHidden = true
        }else {
            btnUpdate.setTitle("Save", for: .normal)
        }
    }
    
    //Date Picker
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        sender.minimumDate = NSDate() as Date
        let thisYear = Calendar.current.component(.year, from: Date())
        sender.maximumDate = Calendar.current.date(from: DateComponents(year: thisYear+1))
        tfSelectDate.text = dateFormatter.string(from: sender.date)
    }
}

