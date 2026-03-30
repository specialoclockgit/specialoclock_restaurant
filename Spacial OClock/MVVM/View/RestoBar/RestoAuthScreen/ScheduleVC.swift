//
//  ScheduleVC.swift
//  Spacial OClock
//
//  Created by Ranpreet Singh on 20/03/26.
//

import UIKit

// MARK: - Models
struct TimeSlot2 {
    var id: Int = 0             // ✅ DB row id from API
    var slotID: Int = 0         // ✅ slot_id from API
    var menuID: Int = 0
    var offerID: Int = 0
    var time: String
    var discount: String
    var startTime: String = ""
    var endTime: String = ""
}

struct DaySchedule2 {
    var day: String
    var startTime: Date?
    var endTime: Date?
    var slots: [TimeSlot2] = []
    var isLoadedFromAPI: Bool = false
}

// MARK: - API Response Models (matching actual response)
struct TimeSlotsResponse: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: TimeSlotsBody?
}

struct TimeSlotsBody: Codable {
    var timeSlots: [String: [SlotData]]?

    enum CodingKeys: String, CodingKey {
        case timeSlots = "timeSlots"
    }
}

struct SlotData: Codable {
    var id: Int?
    var restrorantBarId: Int?
    var day: String?
    var menuId: Int?
    var offerId: Int?
    var startTime: String?
    var endTime: String?
    var slotId: Int?
    var isFifty: Int?
    var customDiscount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case restrorantBarId  = "restrorant_bar_id"
        case day
        case menuId           = "menu_id"
        case offerId          = "offer_id"
        case startTime        = "start_time"
        case endTime          = "end_time"
        case slotId           = "slot_id"
        case isFifty          = "is_fifty"
        case customDiscount   = "custom_discount"
    }
}

// MARK: - ViewController
class ScheduleVC: UIViewController {

    var tableView = UITableView(frame: .zero, style: .grouped)
    var bottomBar = UIView()
    var dropdownTextField = UITextField()
    var loaderView = UIActivityIndicatorView(style: .large)

    var schedules: [DaySchedule2] = []
    var selectedGlobalDiscount: String?

    let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    let pickerView = UIPickerView()
    let dropdownValues = Array(1...100)

    var restaurantBarID: Int = 0
    let menuID = 42
    let offerID = 445
    let bearerToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoxNjgwLCJyZXN0b19pZCI6MjI5fSwiaWF0IjoxNzczNTc3MjI2fQ.2E1bmYCTGogrYs3iNMDxcJmWmf5mQIpyInXu2s6iPQ0"
    let secretKey  = "sk_Dac1t2GMfvvgO1+ZtLvOjwEhQluidxzVy9Av5fiV5kCZzCr+PjdB0ap0Qx6zCPkBDRS8gSGyFw=="
    let publishKey = "pk_ndhUQm9z9VVAEDQAKUjM5nQ6F690crObNnPPobC36LUWJcUKQQC/aSzj9kqTQ22rurF2B6DvyiI="

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        setupData()
        setupUI()
        setupTableView()
        setupDropdown()
        tableView.contentInset.bottom = 90
        tableView.scrollIndicatorInsets.bottom = 90
        fetchTimeSlots()
    }

    @IBAction func btActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func setupData() {
        schedules = days.map { DaySchedule2(day: $0) }
    }

    // MARK: - UI Setup
    func setupUI() {
        view.addSubview(tableView)
        view.addSubview(bottomBar)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

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

        // ✅ Full screen loader
        loaderView.color = .gray
        loaderView.hidesWhenStopped = true
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)

        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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

// MARK: - ✅ Fetch TIME_SLOTS API
extension ScheduleVC {

    func fetchTimeSlots() {

        guard let url = URL(string: "https://api.specialoclock.com/api/time_slot_restaurant") else { return }

        loaderView.startAnimating()
        tableView.isUserInteractionEnabled = false

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(secretKey,   forHTTPHeaderField: "secret_key")
        request.setValue(publishKey,  forHTTPHeaderField: "publish_key")
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")

        // ✅ urlencoded body as per Postman
        let bodyString = "restrorant_bar_id=\(restaurantBarID)"
        request.httpBody = bodyString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }

                self.loaderView.stopAnimating()
                self.tableView.isUserInteractionEnabled = true

                if let error = error {
                    print("❌ Fetch Error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("❌ No data received")
                    return
                }

                if let raw = String(data: data, encoding: .utf8) {
                    print("📥 TIME_SLOTS Response:\n\(raw)")
                }

                self.parseAndPopulateSlots(data: data)
            }
        }.resume()
    }

    // MARK: - ✅ Parse Response → Populate schedules
    // MARK: - ✅ Parse Response → Populate schedules (FIXED)
    func parseAndPopulateSlots(data: Data) {

        do {
            let response = try JSONDecoder().decode(TimeSlotsResponse.self, from: data)

            guard let timeSlots = response.body?.timeSlots else {
                print("⚠️ No timeSlots in response body")
                return
            }

            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "hh:mm a"

            let apiFormatter = DateFormatter()
            apiFormatter.dateFormat = "HH:mm"

            // ✅ Reset all schedules cleanly before repopulating
            for i in 0..<schedules.count {
                schedules[i].slots = []
                schedules[i].startTime = nil
                schedules[i].endTime = nil
                schedules[i].isLoadedFromAPI = false
            }

            for (dayKey, slotArray) in timeSlots {

                // ✅ Skip "Unknown" key (empty day field from server)
                guard dayKey != "Unknown" else { continue }

                guard let idx = schedules.firstIndex(where: {
                    $0.day.lowercased() == dayKey.lowercased()
                }) else {
                    print("⚠️ Day '\(dayKey)' not found in schedules")
                    continue
                }

                // ✅ FIX: Sort slots by start_time before processing
                // This ensures startTime/endTime are always correctly set
                // from the earliest and latest slots respectively
                let sortedSlots = slotArray.sorted {
                    ($0.startTime ?? "") < ($1.startTime ?? "")
                }

                var mappedSlots: [TimeSlot2] = []

                for (index, slot) in sortedSlots.enumerated() {
                    let startStr = slot.startTime ?? ""
                    let endStr   = slot.endTime ?? ""

                    var displayStr = "\(startStr) - \(endStr)"

                    if let startDate = apiFormatter.date(from: startStr),
                       let endDate   = apiFormatter.date(from: endStr) {

                        displayStr = "\(displayFormatter.string(from: startDate)) - \(displayFormatter.string(from: endDate))"

                        // ✅ FIX: Set section startTime ONLY from first (earliest) slot
                        if index == 0 {
                            schedules[idx].startTime = startDate
                        }

                        // ✅ FIX: Set section endTime ONLY from last slot
                        if index == sortedSlots.count - 1 {
                            schedules[idx].endTime = endDate
                        }
                    }

                    mappedSlots.append(TimeSlot2(
                        id        : slot.id ?? 0,
                        slotID    : slot.slotId ?? 0,
                        menuID    : slot.menuId ?? 0,
                        offerID   : slot.offerId ?? 0,
                        time      : displayStr,
                        discount  : "\(slot.customDiscount ?? 0)",
                        startTime : startStr,
                        endTime   : endStr
                    ))
                }

                schedules[idx].slots = mappedSlots
                schedules[idx].isLoadedFromAPI = true

                if !mappedSlots.isEmpty {
                    bottomBar.isHidden = false
                }
            }

            tableView.reloadData()

        } catch {
            print("❌ Decode Error: \(error)")
        }
    }
    
}

// MARK: - TableView
extension ScheduleVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return schedules.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + schedules[section].slots.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 80 : 70
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {

        let container = UIView()
        container.backgroundColor = .clear

        let label = UILabel()
        label.text = schedules[section].day
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false

        let saveBtn = UIButton(type: .system)
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.backgroundColor = .systemGreen
        saveBtn.layer.cornerRadius = 8
        saveBtn.tag = section
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.addTarget(self, action: #selector(saveDaySchedule(_:)), for: .touchUpInside)

        container.addSubview(label)
        container.addSubview(saveBtn)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            saveBtn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            saveBtn.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            saveBtn.widthAnchor.constraint(equalToConstant: 70),
            saveBtn.heightAnchor.constraint(equalToConstant: 32)
        ])

        return container
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let schedule = schedules[indexPath.section]

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell

            cell.startBtn.tag = indexPath.section
            cell.endBtn.tag = indexPath.section

            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"

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

            cell.startBtn.addTarget(self, action: #selector(selectStartTime(_:)), for: .touchUpInside)
            cell.endBtn.addTarget(self, action: #selector(selectEndTime(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SlotCell", for: indexPath) as! SlotCell
            let slot = schedule.slots[indexPath.row - 1]
            cell.configure(slot: slot)

            cell.discountChanged = { [weak self] text in
                self?.schedules[indexPath.section].slots[indexPath.row - 1].discount = text
            }

            cell.selectionStyle = .none
            return cell
        }
    }
}

// MARK: - Time Picker + Slot Generation
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

        // ✅ FIX: Snapshot existing API slots BEFORE clearing
        // so we can restore slotID/menuID/offerID for matching times
        let existingSlots = schedules[section].slots

        var slots: [TimeSlot2] = []
        var current = start

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "hh:mm a"

        let apiFormatter = DateFormatter()
        apiFormatter.dateFormat = "HH:mm"

        while current < end {
            let next = Calendar.current.date(byAdding: .minute, value: 30, to: current)!

            let displayStr = "\(displayFormatter.string(from: current)) - \(displayFormatter.string(from: next))"
            let startAPI   = apiFormatter.string(from: current)
            let endAPI     = apiFormatter.string(from: next)

            // ✅ FIX: Match against snapshotted existing slots (not schedules[section].slots
            // which may already be partially mutated)
            let existingSlot = existingSlots.first(where: { $0.startTime == startAPI })

            slots.append(TimeSlot2(
                id        : existingSlot?.id ?? 0,
                slotID    : existingSlot?.slotID ?? 0,
                menuID    : existingSlot?.menuID ?? menuID,
                offerID   : existingSlot?.offerID ?? offerID,
                time      : displayStr,
                discount  : existingSlot?.discount ?? (selectedGlobalDiscount ?? "0"),
                startTime : startAPI,
                endTime   : endAPI
            ))

            current = next
        }

        // ✅ FIX: Replace slots all at once, not incrementally
        schedules[section].slots = slots
    }
    
}

// MARK: - ✅ Save + API Call
extension ScheduleVC {

    @objc func saveDaySchedule(_ sender: UIButton) {
        let section = sender.tag
        let schedule = schedules[section]

        guard !schedule.slots.isEmpty else {
            showAlert("No slots available for \(schedule.day). Please set start and end time first.")
            return
        }

        var slotsPayload: [[String: Any]] = []

        for slot in schedule.slots {
            // ✅ Ensure all types are correct — Int for IDs and discount, String for times
            let slotDict: [String: Any] = [
                "slot_id"         : slot.slotID,              // Int
                "menu_id"         : slot.menuID,              // Int
                "offer_id"        : slot.offerID,             // Int
                "start_time"      : slot.startTime,           // String "HH:mm"
                "end_time"        : slot.endTime,             // String "HH:mm"
                "custom_discount" : Int(slot.discount) ?? 0   // Int
            ]
            slotsPayload.append(slotDict)
        }

        // ✅ Pass structured payload to API
        let payload: [String: Any] = [
            "restrorant_bar_id" : restaurantBarID,            // Int
            "day"               : schedule.day,               // String
            "slots"             : slotsPayload
        ]

        print("🧾 Slot count being sent: \(slotsPayload.count)")
        print("🧾 Payload being sent: \(payload)")
        sendToAPI(payload: payload, dayName: schedule.day)
    }

    func sendToAPI(payload: [String: Any], dayName: String) {

        guard let url = URL(string: "https://api.specialoclock.com/api/edit_time_slot_restaurant") else {
            showAlert("Invalid API URL")
            return
        }

        // ✅ Build exact JSON body matching Postman raw JSON format
        guard let slots = payload["slots"] as? [[String: Any]] else {
            showAlert("Invalid slots data")
            return
        }

        // ✅ Build slots array cleanly with correct types
        var slotsArray: [[String: Any]] = []
        for slot in slots {
            let cleanSlot: [String: Any] = [
                "slot_id"         : slot["slot_id"] as? Int ?? 0,
                "menu_id"         : slot["menu_id"] as? Int ?? 0,
                "offer_id"        : slot["offer_id"] as? Int ?? 0,
                "start_time"      : slot["start_time"] as? String ?? "",
                "end_time"        : slot["end_time"] as? String ?? "",
                "custom_discount" : slot["custom_discount"] as? Int ?? 0
            ]
            slotsArray.append(cleanSlot)
        }

        let jsonBody: [String: Any] = [
            "restrorant_bar_id" : restaurantBarID,
            "day"               : dayName,
            "slots"             : slotsArray
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody, options: []) else {
            showAlert("Failed to encode JSON")
            return
        }

        // ✅ Debug — print exact JSON being sent
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("📤 RAW JSON Sending [\(dayName)]:\n\(jsonString)")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        // ✅ Must be application/json for raw JSON body
        request.setValue("application/json",  forHTTPHeaderField: "Content-Type")
        request.setValue("application/json",  forHTTPHeaderField: "Accept")
        request.setValue(bearerToken,         forHTTPHeaderField: "Authorization")
        request.setValue(secretKey,           forHTTPHeaderField: "secret_key")
        request.setValue(publishKey,          forHTTPHeaderField: "publish_key")

        let loader = UIActivityIndicatorView(style: .medium)
        loader.color = .gray
        loader.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loader)

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.navigationItem.rightBarButtonItem = nil

                if let error = error {
                    self.showAlert("Network Error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    self.showAlert("No response from server")
                    return
                }

                // ✅ Always print full raw response for debugging
                if let responseStr = String(data: data, encoding: .utf8) {
                    print("📥 Save Response [\(dayName)]:\n\(responseStr)")
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("📡 HTTP Status: \(httpResponse.statusCode)")

                    // ✅ Parse response JSON
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        let success = json["success"] as? Bool ?? false
                        let message = json["message"] as? String ?? "Unknown response"

                        if success {
                            self.showAlert("✅ \(message)")
                        } else {
                            self.showAlert("❌ \(message)")
                        }
                    } else {
                        if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                            self.showAlert("✅ \(dayName) slots saved successfully!")
                        } else {
                            self.showAlert("❌ Server error: \(httpResponse.statusCode)")
                        }
                    }
                }
            }
        }.resume()
    }
    
}

// MARK: - Dropdown / Picker
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
        discountField.keyboardType = .numberPad

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
