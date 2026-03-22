//
//  ScheduleVC.swift
//  Spacial OClock
//
//  Created by Ranpreet Singh on 20/03/26.
//

import UIKit

// MARK: - Models
struct TimeSlot2 {
    var time: String
    var discount: String
}

struct DaySchedule2 {
    var day: String
    var startTime: Date?
    var endTime: Date?
    var slots: [TimeSlot2] = []
}

// MARK: - ViewController
class ScheduleVC: UIViewController {

    var tableView = UITableView(frame: .zero, style: .grouped)

    // ✅ Bottom Bar
    var bottomBar = UIView()
    var dropdownTextField = UITextField()

    var schedules: [DaySchedule2] = []
    var selectedGlobalDiscount: String?

    let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

    let pickerView = UIPickerView()
    let dropdownValues = Array(1...100)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemGroupedBackground

        setupData()
        setupUI()
        setupTableView()
        setupDropdown()

        // ✅ Prevent last cells hiding behind bar
        tableView.contentInset.bottom = 90
        tableView.scrollIndicatorInsets.bottom = 90
    }

    @IBAction func btActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupData() {
        schedules = days.map { DaySchedule2(day: $0) }
    }

    // MARK: UI
    func setupUI() {

        view.addSubview(tableView)
        view.addSubview(bottomBar)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.translatesAutoresizingMaskIntoConstraints = false

        // ✅ TableView FULL (original position)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // ✅ Bottom Floating Bar
        bottomBar.backgroundColor = .orange
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOpacity = 0.1
        bottomBar.layer.shadowRadius = 6
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomBar.isHidden = true

        NSLayoutConstraint.activate([
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 80)
        ])

        // ✅ Dropdown UI
        dropdownTextField.placeholder = "Select Discount ▼"
        dropdownTextField.borderStyle = .roundedRect
        dropdownTextField.tintColor = .clear

        let arrow = UIImageView(image: UIImage(systemName: "chevron.down"))
        arrow.tintColor = .gray
        arrow.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        dropdownTextField.rightView = arrow
        dropdownTextField.rightViewMode = .always

        bottomBar.addSubview(dropdownTextField)

        dropdownTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dropdownTextField.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 15),
            dropdownTextField.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 16),
            dropdownTextField.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -16),
            dropdownTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableView.register(TimeCell.self, forCellReuseIdentifier: "TimeCell")
        tableView.register(SlotCell.self, forCellReuseIdentifier: "SlotCell")
    }
}

// MARK: - TableView
extension ScheduleVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return schedules.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1 for start/end + slots
        return 1 + schedules[section].slots.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 80 : 70
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {

        let container = UIView()
        container.backgroundColor = .clear

        let label = UILabel()
        label.text = "  \(schedules[section].day)"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray

        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let schedule = schedules[indexPath.section]

        if indexPath.row == 0 {
            // ✅ Start / End Time Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell

            cell.startBtn.tag = indexPath.section
            cell.endBtn.tag = indexPath.section

            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"

            // ✅ Reset properly (fix reuse bug)
            if let start = schedule.startTime {
                cell.startBtn.setTitle(formatter.string(from: start), for: .normal)
            } else {
                cell.startBtn.setTitle("Start Time", for: .normal)
            }

            if let end = schedule.endTime {
                cell.endBtn.setTitle(formatter.string(from: end), for: .normal)
            } else {
                cell.endBtn.setTitle("End Time", for: .normal)
            }

            // Actions
            cell.startBtn.addTarget(self, action: #selector(selectStartTime(_:)), for: .touchUpInside)
            cell.endBtn.addTarget(self, action: #selector(selectEndTime(_:)), for: .touchUpInside)

            cell.selectionStyle = .none
            return cell

        } else {
            // ✅ Slot Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "SlotCell", for: indexPath) as! SlotCell

            let slot = schedule.slots[indexPath.row - 1]
            cell.configure(slot: slot)

            // Update model on text change
            cell.discountChanged = { [weak self] text in
                self?.schedules[indexPath.section].slots[indexPath.row - 1].discount = text
            }

            cell.selectionStyle = .none
            return cell
        }
    }
}

extension ScheduleVC {

    @objc func selectStartTime(_ sender: UIButton) {
        showTimePicker(isStart: true, section: sender.tag)
    }

    @objc func selectEndTime(_ sender: UIButton) {
        showTimePicker(isStart: false, section: sender.tag)
    }

    func showTimePicker(isStart: Bool, section: Int) {

        let alert = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)

        let picker = UIDatePicker()
        picker.datePickerMode = .time

        alert.view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            picker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            picker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20)
        ])

        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in

            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"

            if isStart {
                self.schedules[section].startTime = picker.date
            } else {

                guard let start = self.schedules[section].startTime else {
                    self.showAlert("Please select Start Time first")
                    return
                }

                if picker.date <= start {
                    self.showAlert("End time must be greater than Start time")
                    return
                }

                self.schedules[section].endTime = picker.date
                self.generateSlots(section: section)

                // ✅ Show bottom bar
                self.bottomBar.isHidden = false
            }

            self.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }))

        present(alert, animated: true)
    }

    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func generateSlots(section: Int) {

        guard let start = schedules[section].startTime,
              let end = schedules[section].endTime else { return }

        var slots: [TimeSlot2] = []
        var current = start

        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        while current < end {
            let next = Calendar.current.date(byAdding: .minute, value: 30, to: current)!

            let timeStr = "\(formatter.string(from: current)) - \(formatter.string(from: next))"

            let discount = selectedGlobalDiscount ?? ""

            slots.append(TimeSlot2(time: timeStr, discount: discount))
            current = next
        }

        schedules[section].slots = slots
    }
}

extension ScheduleVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func setupDropdown() {
        pickerView.delegate = self
        pickerView.dataSource = self
        dropdownTextField.inputView = pickerView

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        toolbar.setItems([done], animated: false)

        dropdownTextField.inputAccessoryView = toolbar
    }

    @objc func donePicker() {
        dropdownTextField.resignFirstResponder()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dropdownValues.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(dropdownValues[row])%"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGlobalDiscount = "\(dropdownValues[row])"
        dropdownTextField.text = "\(dropdownValues[row])%"
        applyGlobalDiscount()
    }

    func applyGlobalDiscount() {
        guard let value = selectedGlobalDiscount else { return }

        for i in 0..<schedules.count {
            for j in 0..<schedules[i].slots.count {
                schedules[i].slots[j].discount = value
            }
        }

        tableView.reloadData()
    }
}

// MARK: - TimeCell
class TimeCell: UITableViewCell {

    let startBtn = UIButton()
    let endBtn = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 12
        container.layer.shadowOpacity = 0.1
        container.layer.shadowRadius = 4

        contentView.addSubview(container)

        startBtn.setTitle("Start Time", for: .normal)
        startBtn.setTitleColor(.systemBlue, for: .normal)

        endBtn.setTitle("End Time", for: .normal)
        endBtn.setTitleColor(.systemRed, for: .normal)

        let stack = UIStackView(arrangedSubviews: [startBtn, endBtn])
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        container.addSubview(stack)

        container.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            stack.topAnchor.constraint(equalTo: container.topAnchor),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SlotCell
class SlotCell: UITableViewCell {

    let timeLabel = UILabel()
    let discountField = UITextField()

    var discountChanged: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10

        contentView.addSubview(container)

        discountField.borderStyle = .roundedRect
        discountField.placeholder = "%"

        let stack = UIStackView(arrangedSubviews: [timeLabel, discountField])
        stack.axis = .horizontal
        stack.spacing = 10

        container.addSubview(stack)

        container.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
        ])

        discountField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }

    func configure(slot: TimeSlot2) {
        timeLabel.text = slot.time
        discountField.text = slot.discount
    }

    @objc func textChanged() {
        discountChanged?(discountField.text ?? "")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
