//
//  Extensions.swift
//  MYKA
//
//  Created by cqlapple on 10/08/21.
//

import Foundation
import UIKit
//import Kingfisher
//import NVActivityIndicatorView

//MARK: EXTENSION UI-TEXT-FIELD PASSWORD HIDE - SHOW
extension UITextField {
    func togglePasswordVisibility() {
        isSecureTextEntry = !isSecureTextEntry
        if let existingText = text, isSecureTextEntry {
            text = nil
            insertText(existingText)
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
    }
}


//MARK: EXTENSION UIVIEW - CONTROLLER
extension UIViewController{
    @discardableResult func pushToVC(_ viewController: UIViewController,_ vcIdentifier: String, _ isAnimate: Bool = true,storyBoard:UIStoryboard = AppStoryboard.Main.instance) -> (UIViewController){
        let vc = storyBoard.instantiateViewController(withIdentifier: vcIdentifier)
        self.navigationController?.pushViewController(vc, animated: isAnimate)
        return vc
    }
    
    func goBackSidemenu() {
        
    }
    func goToBackVC(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func string_date_ToDate(_ date:String?,currentFormat:dateFormat,requiredFormat:dateFormat) -> String
    {
        if let dateStr = date
        {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = currentFormat.rawValue
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let date = dateFormatter.date(from: dateStr)
            return dateConverter(date, format: requiredFormat)
        }
        return ""
    }
    func dateConverter(_ date:Date?,format:dateFormat) -> String
    {
        if let date = date
        {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.current
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = format.rawValue
            let strDate = dateFormatter.string(from: date)
            return strDate
        }
        return ""
    }
}

extension String {
    
    func convertToDateFormate(current: String, convertTo: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = current
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        dateFormatter.dateFormat = convertTo
        return  dateFormatter.string(from: date)
    }
    
    //
    //        var isValidName: Bool {
    //           let RegEx = "(?<! )[-a-zA-Z' ]{2,26}"
    //           let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
    //           return Test.evaluate(with: self)
    //        }
    //
    
    var isBlank : Bool
    {
        if self.count == 0 || self.trimmingCharacters(in: .whitespaces).count == 0{
            return true
        }else{
            return false
        }
    }
    
    var intValue:     Int?        { return NumberFormatter().number(from: self)?.intValue    }
    var int8Value:    Int8?       { return NumberFormatter().number(from: self)?.int8Value   }
    var int16Value:   Int16?      { return NumberFormatter().number(from: self)?.int16Value  }
    var int32Value:   Int32?      { return NumberFormatter().number(from: self)?.int32Value  }
    var int64Value:   Int64?      { return NumberFormatter().number(from: self)?.int64Value  }
    var floatValue:   Float?      { return NumberFormatter().number(from: self)?.floatValue  }
    var doubleValue:  Double?     { return NumberFormatter().number(from: self)?.doubleValue }
    var boolValue:    Bool?       { return NumberFormatter().number(from: self)?.boolValue   }
    var decimalValue: Decimal?    { return NumberFormatter().number(from: self)?.decimalValue}
    var binaryValue:  Data?       { return self.data(using: .utf8)                           }
    
    var isAlphanumericWithWhiteSpace: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Z0-9a-z ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    
    var isOnlyAlphanumeric: Bool {
        return !isEmpty && self.onlyNumbers && self.onlyAlphabet
    }
    
    var isAlphanumeric: Bool {
        
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9]", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
        // return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //MARK:-isValidPassword-
    var isValidPassword: Bool
    {
        if (self.isEmpty){return false}
        
        let passRegEx =  "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        
        //        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,20}"
        let passwordTest=NSPredicate(format: "SELF MATCHES %@", passRegEx);
        return passwordTest.evaluate(with: self)
    }
    var removeWhiteSpace:String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    var trimWhiteSpace: String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isValidEmail: Bool {
        get{
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return !emailPredicate.evaluate(with: self)
        }
    }
    
    var checkSpecial: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9 ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
            
        }else{
            return true
        }
    }
    
    var checkAddress: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9._@#/()-+*., ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
            
        }else{
            return true
        }
    }
    
    var onlyNumbers: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^0-9].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    var isPhoneNumber: Bool
    {
        let phone_regex = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phone_regex)
        return !self.isEmpty && phoneTest.evaluate(with: self)
    }
    var onlyNumbersExpressionPlus: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^0-9+].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    var onlyAlphabet: Bool{
        
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z- -].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    var isAlphabetWithSpace: Bool{
        
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    
    func safelyLimitedTo(length n: Int)->String {
        let c = String(self)
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
    
    // convert string date to Date
    func timeZoneDateFormatter(timeZone :String = "UTC", localFormat:String = "MM-dd-yyyy EEE,HH:mm:ss" , serverFormat:String = "yyyy-MM-dd,HH:mm:ss") -> (date:Date?,dateTimeStr:String?,timeStr:String?){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = serverFormat
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        let date = dateFormatter.date(from: self)// create date from string
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = localFormat
        dateFormatter.timeZone =  TimeZone.current
        
        let dateStamp = dateFormatter.string(from: date!)
        dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: date!)
        return (date,dateStamp,time)
        
    }
    
    var urlQueryAllowed:String?{
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
}




extension String{
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func removeHtmlFromString(inPutString: String) -> String{
        
        return inPutString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func getHtmlStringInWhite(fontSize:Int) -> String{
        let finalString = "<html><body style=\" font-size: \(fontSize); font-family: Play; color: #ffffff\">\(self)</body></html>"
        return finalString
    }
    
    func getHtmlStringInBlack(fontSize:Int) -> String{
        let finalString = "<html><body style=\" font-size: \(fontSize); font-family: Play; color: #000000\">\(self)</body></html>"
        return finalString
    }
    
}
extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

//MARK: DATE
extension Date {
    
    func convertToFormat(_ format: String) -> String?
    {
        let dateFormatter = DateFormatter()
        //        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        let date = dateFormatter.string(from: self)
        return date
    }
}

extension String {
    
    func toUTCDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = .none
        dateFormatter.dateFormat = format
        dateFormatter.calendar = .current
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func htmlAttributed(family: String?, size: CGFloat) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
            "html *" +
            "{" +
            "font-size: \(size)pt !important;" +
            "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
//MARK: CONVERT TIME STAMP TO DATE
extension Int{
    func convertTimeStampToDate(timeStamp:Int) -> Date {
        var unixTimestamp = timeStamp
        if timeStamp == 0{
            unixTimestamp = 1576213261
        }
        let date = Date(timeIntervalSince1970: TimeInterval((unixTimestamp)))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let postDateString = dateFormatter.string(from: date)
        return dateFormatter.date(from: postDateString) ?? Date()
    }
}
//extension Date {
//
//func getElapsedInterval() -> String {
//
//    let interval = Calendar.current.dateComponents([.year, .month, .day,.hour,.minute,.second], from: self, to: Date())
//
//    if let year = interval.year, year > 0 {
//        return year == 1 ? "\(year)" + " " + "year ago" :
//            "\(year)" + " " + "years ago"
//    } else if let month = interval.month, month > 0 {
//        return month == 1 ? "\(month)" + " " + "month ago" :
//            "\(month)" + " " + "months ago"
//    } else if let day = interval.day, day > 0 {
//        return day == 1 ? "\(day)" + " " + "day ago" :
//            "\(day)" + " " + "days ago"
//    } else if let hour = interval.hour, hour > 0 {
//        return hour == 1 ? "\(hour)" + " " + "hour ago" :
//            "\(hour)" + " " + "hours ago"
//    }else if let min = interval.minute, min > 0 {
//        return min == 1 ? "\(min)" + " " + "minute ago" :
//            "\(min)" + " " + "minutes ago"
//    }
//    else if let second = interval.second, second > 0 {
//        return second == 1 ? "\(second)" + " " + "second ago" :
//            "\(second)" + " " + "seconds ago"
//    }else{
//        return "a moment ago"
//    }
//    
//    }
//}

//MARK: ADD SEPRATOR IN STRING
extension Collection {
    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence,Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: maxLength, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return self[start..<end]
        }
    }
    
    func every(n: Int) -> UnfoldSequence<Element,Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer { index = self.index(index, offsetBy: n, limitedBy: endIndex) ?? endIndex }
            return self[index]
        }
    }
    var pairs: [SubSequence] { .init(unfoldSubSequences(limitedTo: 2)) }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert<S: StringProtocol>(separator: S, every n: Int) {
        for index in indices.every(n: n).dropFirst().reversed() {
            insert(contentsOf: separator, at: index)
        }
    }
    func inserting<S: StringProtocol>(separator: S, every n: Int) -> Self {
        .init(unfoldSubSequences(limitedTo: n).joined(separator: separator))
    }
}

//MARK: CARD TYPE
enum CardType: String {
    case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
    
    static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
    
    var regex : String {
        switch self {
        case .Amex:
            return "^3[47][0-9]{5,}$"
        case .Visa:
            return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
            return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .Diners:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .JCB:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .UnionPay:
            return "^(62|88)[0-9]{5,}$"
        case .Hipercard:
            return "^(606282|3841)[0-9]{5,}$"
        case .Elo:
            return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
        default:
            return ""
        }
    }
}
extension UITextField
{
    func validateCreditCardFormat()-> (type: CardType, valid: Bool) {
        // Get only numbers from the input string
        let input = self.text!
        
        let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        var type: CardType = .Unknown
        var formatted = ""
        var valid = false
        
        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }
        
        // check validity
        valid = luhnCheck(number: numberOnly)
        
        // format
        var formatted4 = ""
        for character in numberOnly {
            if formatted4.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }
        
        formatted += formatted4 // the rest
        
        // return the tuple
        return (type, valid)
    }
    
    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
    
    func luhnCheck(number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }
        
        for (index,tuple) in digitStrings.enumerated() {
            guard let digit = Int(tuple) else { return false }
            
            let odd = index % 2 == 1
            
            switch (odd, digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
}



extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "OpenSans-Medium", size: 20)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func scrollToBottom(animated: Bool) {
        
        DispatchQueue.main.async {
            
            if self.contentSize.height > self.frame.height {
                
                // First figure out how many sections there are
                let lastSectionIndex = self.numberOfSections - 1
                
                // Then grab the number of rows in the last section
                let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
                
                // Now just construct the index path
                let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
                
                // Make the last row visible
                self.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
            }
        }
    }
    
}
extension UIViewController{
    func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    func pushToVC(vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIView {
    var parentView: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
extension UIButton{
    func pinkThemebtn(){
        self.layer.cornerRadius = 25
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(named: "themeColor")
    }
    
    func pinkBorderBtn(){
        self.layer.cornerRadius = 25
        self.layer.borderColor = UIColor(named: "themeColor")?.cgColor
        self.layer.borderWidth = 1
        self.setTitleColor(UIColor(named: "themeColor"), for: .normal)
        self.backgroundColor = .white
    }
}
    

func isAge18(from dateString: String, withFormat format: String) -> Bool? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    if let date = dateFormatter.date(from: dateString) {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
        let age = ageComponents.year ?? 0
        return age >= 18 ? true : false
    }
    return nil
}
