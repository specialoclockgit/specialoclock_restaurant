//
//  AddOfferVC.swift
//  Spacial OClock
//
//  Created by cql211 on 05/07/23.
//

import UIKit
struct ModelItems{
    var itemName : String
    var check : Bool
}

class AddOfferVC: UIViewController{
    
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
    @IBOutlet weak var btnOffer : UIButton!
    @IBOutlet weak var viewType : UIView!
    
    //MARK: Variables
    var pickerView = UIPickerView()
    var arrItem :  [ModelItems]  = []
    
    
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
        //        pickerView.delegate = self
        //        pickerView.dataSource = self
    }
    
    //MARK: Button Action
    @IBAction func btnBakAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Pop Over Button Action
    @IBAction func btnPopOver(_ sender : UIButton){
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
            vc.arrItem = arrItem
            vc.selectedImage = "tickCheck"
            vc.callBack = { data in
                if self.arrItem[data].check == false {
                    self.arrItem[data].check = true
                }else{
                    self.arrItem[data].check = false
                }
                debugPrint(self.arrItem)
                var selectedItem = [String]()
                self.arrItem.forEach({ data in
                    if data.check {
                        selectedItem.append(data.itemName)
                    }
                })
                self.tfSelectItem.text = selectedItem.joined(separator: ",")
            }
        default :
            debugPrint("")
        }
        vc.statusCheck = sender.tag
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnAddOfferAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddOfferVC: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
            return .none
    }
}
//MARK: Text view delegate
extension AddOfferVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        tvDescription.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tvDescription.text.count == 0 {
            tvDescription.text = "  Write here..."
        }
    }
}
//MARK: UIpicker view
//extension AddOfferVC : UIPickerViewDelegate , UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        <#code#>
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        <#code#>
//    }
//
//
//}
extension AddOfferVC {
    func initialLoad(){
        view.hideKeyboardWhenTappedAround()
        tvDescription.layer.cornerRadius = 10.0
        tvDescription.leftSpace()
        tfOffer.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfSelectMenu.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfSelectItem.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfSelectOffer.setupRightIcon(imageName: "DownArrow", width: 7, height: 5, y: 25)
        tfSelectOffer.inputView = pickerView
        tfType.setupRightImage(imageName: "DownArrow", width: 8, height: 5)
        tfTimeFrame.setupRightImage(imageName: "clock", width: 15, height: 15)
        tfTimeFrame.inputView = pickerView
        
        //Date picker view
        tfSelectDate.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        tfSelectDate.setupRightImage(imageName: "calendar", width: 15, height: 15)
        
        let status = UserDefaults.standard.status
        if status == 0 {
            viewType.isHidden = true
        }
        
        //Item Struct
        for _ in 0..<4{
            arrItem.append(ModelItems(itemName: "Item", check: false))
        }
    }
    //Date Picker target function
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        sender.minimumDate = NSDate() as Date
        let thisYear = Calendar.current.component(.year, from: Date())
        sender.maximumDate = Calendar.current.date(from: DateComponents(year: thisYear+1))
        tfSelectDate.text = dateFormatter.string(from: sender.date)
    }
}

