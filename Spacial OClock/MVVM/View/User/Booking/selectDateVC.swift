//
//  selectDateVC.swift
//  Spacial OClock
//
//  Created by cqlios on 17/10/23.
//

import UIKit
import FSCalendar

class selectDateVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var viewFsCalendar: FSCalendar!
    var callBack: ((String)->())?
    
    //MARK: - VARIABLES
    var pickerSelectTime = UIPickerView()
    private var currentPage: Date?
    let df = DateFormatter()
    var currentDate = String()
    var now = String()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewFsCalendar.delegate = self
        viewFsCalendar.dataSource = self
    }
    //MARK: - ACTIONS
    
    //MARK: - FUNCTIONS
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self.view {
            self.dismiss(animated: true)
        }
    }
}
extension selectDateVC{
    func initialLoad(){
        viewFsCalendar.layer.cornerRadius = 15.0
        viewFsCalendar.calendarHeaderView.backgroundColor = UIColor.systemGray
        viewFsCalendar.calendarWeekdayView.backgroundColor = UIColor(named: "themeGreen")
        viewFsCalendar.calendarWeekdayView.clipsToBounds = true
        viewFsCalendar.appearance.headerMinimumDissolvedAlpha = 0
//        tfSelectPeople.setupRightImage(imageName: "dropDown" , width: 7, height: 5)
//        tfSelectPeople.inputView = pickerSelectPeople
//        tfSelectTime.inputView = pickerSelectTime
        
        //Current Year and current month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: Date())
        let heading = monthString + yearString
       // lblMonth.text = heading
    }
}
extension selectDateVC :FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let now = df.string(from: date)
        self.dismiss(animated: true){
            self.callBack?(now)
        }
        
    }
}
