//
//  NewBookingVC.swift
//  Spacial OClock
//
//  Created by cql211 on 30/06/23.
//

import UIKit
import FSCalendar

class NewBookingVC: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlet
    @IBOutlet weak var viewCalendar : UIView!
    @IBOutlet weak var viewFSCalendar : FSCalendar!
    @IBOutlet weak var viewSelectTime : UIView!
    @IBOutlet weak var tfSelectTime : UITextField!
    @IBOutlet weak var viewSelectPeople : UIView!
    @IBOutlet weak var tfSelectPeople : UITextField!
    @IBOutlet weak var lblMonth : UILabel!
    
    //MARK: Variable
    var pickerSelectPeople = UIPickerView()
    var pickerSelectTime = UIPickerView()
    var arrNumberOfPeople : [Int] = []
    var resto_id = Int()
    var offer_id = String()
    var numberofperson = Int()
    private var currentPage: Date?
    var viewmodal = HomeViewModel()
    let df = DateFormatter()
    var currentDate = String()
    var now = String()
    var pickmenuid = Int()
    var restrorant_bar_id = Int()
    var modal : getSlotsModalBody?
    var timeSlots : [TimeSlot]?
    var slotId = Int()
    var oldDateSelect = String()
    var selectslot = String()
    var offerSelectePretns = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfSelectTime.text = selectslot
        
        for i in 0...numberofperson{
            arrNumberOfPeople.append(i)
        }
        initialLoad()
        viewFSCalendar.scope = .month
        viewFSCalendar.placeholderType = .none
        pickerSelectPeople.delegate = self
        pickerSelectPeople.dataSource = self
        pickerSelectTime.delegate = self
        pickerSelectTime.dataSource = self
        viewFSCalendar.delegate = self
        viewFSCalendar.dataSource = self
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        let calenderDate = formatter.date(from: oldDateSelect)
        viewFSCalendar.select(calenderDate)
        viewFSCalendar.reloadData()
        viewFSCalendar.calendarHeaderView.reloadData()
        currentDate = result
        now = result
    
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK: Buttton Action
    @IBAction func btnSelectSlot(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SlotsVc") as! SlotsVc
        vc.preferredContentSize = CGSize(width: 320, height: 360)
        vc.modalPresentationStyle = .popover
        vc.date = currentDate
        vc.menuid = self.pickmenuid
        vc.restobarId = self.restrorant_bar_id
        vc.restoid = self.resto_id
        vc.offerid = self.offer_id
        if let pres = vc.presentationController {
            pres.delegate = self
        }
        if let pop = vc.popoverPresentationController {
            pop.sourceView = (sender)
            pop.permittedArrowDirections = .down
            pop.sourceRect = (sender).bounds
        }
        self.present(vc, animated: true)
    }
    
    @IBAction func btnContinueAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.CustomTopAlertVC) as! CustomTopAlertVC
        screen.callBack = {
            self.viewmodal.booking_API(bookingDate: self.oldDateSelect, slotid: self.slotId, numberofPeople: self.tfSelectPeople.text ?? "", restoid: self.restrorant_bar_id, offerid: self.offer_id, persents: self.offerSelectePretns) { data in
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: HomeVC.self) {
                        UserDefaults.standard.setValue("1", forKey: "Dine")
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
        }
        self.navigationController?.present(screen, animated: true)
    }
    
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Calendar Private Function
    private func updateMonthAndYearLabels(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        let heading = monthString + yearString
        lblMonth.text = heading
    }
    
    private func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.viewFSCalendar.setCurrentPage(self.currentPage!, animated: true)
    }

    private var currDate: Date?
        private lazy var today: Date = {
            return Date()
        }()
    
    //Calendar button action
    @IBAction func btnBackAct(_ sender : UIButton){
        self.moveCurrentPage(moveUp: false)
    }
    @IBAction func btnNextAct(_ sender : UIButton){
        self.moveCurrentPage(moveUp: true)
    }
}
extension NewBookingVC {
    func CalendarDesign(){
        debugPrint("")
    }
}
extension NewBookingVC : FSCalendarDelegate , FSCalendarDataSource {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let displayedMonth = calendar.currentPage
        updateMonthAndYearLabels(for: displayedMonth)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        df.dateFormat = "yyyy-MM-dd"
        df.locale = Locale.current
        currentDate = df.string(from: date)
    }
}
extension NewBookingVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == pickerSelectTime{
            return 1
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerSelectTime{
            return timeSlots?.count ?? 0
        }else {
            return arrNumberOfPeople.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerSelectTime{
            
            return (timeSlots?[row].startTime ?? "") + " - " + (timeSlots?[row].endTime ?? "")
        }else{
            return arrNumberOfPeople[row].description
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerSelectTime{
            self.slotId = timeSlots?[row].id ?? 0
            tfSelectTime.text = (timeSlots?[row].startTime ?? "") + " - " + (timeSlots?[row].endTime ?? "")
        }else{
            tfSelectPeople.text = arrNumberOfPeople[row].description
        }
    }
}

extension NewBookingVC{
    func initialLoad(){
        viewFSCalendar.layer.cornerRadius = 15.0
        viewFSCalendar.calendarHeaderView.backgroundColor = UIColor.systemGray5
        //viewFSCalendar.calendarWeekdayView.backgroundColor = UIColor(named: "themeGreen")
        viewFSCalendar.calendarWeekdayView.clipsToBounds = true
        viewFSCalendar.appearance.headerMinimumDissolvedAlpha = 0
        tfSelectPeople.setupRightImage(imageName: "dropDown" , width: 7, height: 5)
        tfSelectPeople.inputView = pickerSelectPeople
        tfSelectTime.inputView = pickerSelectTime
        
        //Current Year and current month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: Date())
        let heading = monthString + yearString
        lblMonth.text = heading
    }
}

//MARK: EXTENSIONS
extension NewBookingVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
