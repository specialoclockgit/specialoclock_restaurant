//
//  AddCard.swift
//  Spacial OClock
//
//  Created by cqlm2 on 14/08/24.
//

import UIKit

 class AddCardVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var holderName_TF: UITextField!
    @IBOutlet weak var CVV_TF: UITextField!
    @IBOutlet weak var expiryDate_TF: UITextField!
    @IBOutlet weak var cardNo_TF: UITextField!
    
    let datePicker = UIDatePicker()
    let Months = ["January","Febrary","March","April","May","June","July","August","September","October","November","December"]
    var arrMonthCode = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    var monthPickerView = UIPickerView()
    var arrYear = [Int]()
    var month = ""
    var year = ""
   var viewModel = AuthViewModel()
    var cardType = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        CVV_TF.isSecureTextEntry = true
        setUp()
    }
    
     
     func showAlert(){
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         guard let vc = storyBoard.instantiateViewController(withIdentifier: "CompleteProfilePopupVC") as? CompleteProfilePopupVC else { return }
         vc.accessibilityHint = "AddCard"
         vc.modalTransitionStyle = .crossDissolve
         vc.modalPresentationStyle = .overFullScreen
         self.navigationController?.present(vc, animated: true)
     }
     
     
    func setUp() {
        showAlert()
        cardNo_TF.delegate = self
        CVV_TF.delegate = self
        expiryDate_TF.delegate = self
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        for _ in 1 ... 12 {
            let day = cal.component(.year, from: date)
            arrYear.append(day)
            date = cal.date(byAdding: .year, value: 1, to: date)!
        }
        print("arrYear--\(arrYear)")
        monthPickerView.delegate = self
        expiryDate_TF.inputView = monthPickerView
    }
 
     @IBAction func btnSave(_ sender: UIButton) {
         let expiry = expiryDate_TF.text?.split(separator: "-")
         
         if CheckValidations.validateAddCard(name: holderName_TF.text ?? "", cvv: CVV_TF.text ?? "", cardNo: cardNo_TF.text ?? "", expiry: expiryDate_TF.text ?? "") {
             
             viewModel.addCardAPI(nameOnCard: holderName_TF.text ?? "", cardNo: cardNo_TF.text ?? "", expiryMonth: (expiry![0]).description, expiryYear: (expiry![1]).description, cvv: CVV_TF.text ?? "", cardType: cardType.description) {
                 let storyBoard = UIStoryboard.init(name: "RestoBar", bundle: nil)
                 Store.autoLogin = true
                 CommonUtilities.shared.showAlert(message: "Logged in successfully", isSuccess: .success)
                 let tabVC = storyBoard.instantiateViewController(withIdentifier: ViewController.RestoTabBarVC) as! RestoTabBarVC
                 let navigationController = UINavigationController(rootViewController: tabVC)
                 navigationController.navigationBar.isHidden = true
                 navigationController.viewControllers = [tabVC]
                 UIApplication.shared.windows.first?.rootViewController = navigationController
                 UIApplication.shared.windows.first?.makeKeyAndVisible()
             }
         }
     }
     
     func GetCardImage(_ cardName:String) -> UIImage {
            if cardName == "Amex" {
                return UIImage(named: "amex")!
            } else if cardName == "Visa" {
                return  UIImage(named: "Visa-1")!
            } else if cardName == "MasterCard" {
                return  UIImage(named: "mastercard-1")!
            } else if cardName == "Diners" {
                return  UIImage(named: "diners-club-credit-card-logo-1")!
            } else if cardName == "Discover" {
                return  UIImage(named: "discover-1")!
            } else if cardName == "Jcb" {
                return  UIImage(named: "jcb")!
            } else if cardName == "UnionPay" {
                return  UIImage(named: "union-pay-1")!
            }
            return UIImage(named: "diners-club-credit-card-logo-1")!
        }
     
     
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //FOR HELP :- https://github.com/orucanil/StringFormatter
        
        guard let text = textField.text else {
            return true
        }
        
        if textField == cardNo_TF {
                  let cardimage = cardNo_TF.validateCreditCardFormat().type.rawValue
                  print(cardimage)
                  
                  switch cardimage {
                  case "Amex":
                      cardType = 9
                  case "Visa":
                      cardType = 1
                  case "MasterCard":
                      cardType = 2
                  case "Diners":
                      cardType = 8
                  case "Discover":
                      cardType = 7
                  case "Jcb":
                      cardType = 4
                  case "UnionPay":
                      cardType = 3
                  default:
                      cardType = 0
                  }
                 img.image = GetCardImage(cardimage)
              }
        
        let lastText = (text as NSString).replacingCharacters(in: range, with: string) as String
        
        if cardNo_TF == textField {
            textField.text = lastText.format("nnnn nnnn nnnn nnnn", oldString: text)
            return false
        } else if expiryDate_TF == textField {
            textField.text = lastText.format("nn-nnnn", oldString: text)
            return false
        }else if CVV_TF == textField {
            textField.text = lastText.format("nnn", oldString: text)
            return false
        }
        
        
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.cardNo_TF{
            if !self.cardNo_TF.text!.isEmpty && self.cardNo_TF.text!.count > 16{
                //                let last4 = self.tfCardNumber.text!.suffix(4)
                //                self.tfCardNumber.text = "**** **** **** \(last4)"
            }
        }else if textField == self.expiryDate_TF{
            if !self.expiryDate_TF.text!.isEmpty && self.expiryDate_TF.text!.count > 4{
                self.expiryDate_TF.text = "\(self.expiryDate_TF.text!)"
            }
        }
        return true
    }
}

extension AddCardVC:UIPickerViewDelegate,UIPickerViewDataSource
{
    //MARK: Uipikcerview
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0
        {
            return Months.count
        }
        return arrYear.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0
        {
            return Months[row].description
        }
        return arrYear[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if component == 0
        {
            if year == ""
            {
                year = arrYear[0].description
            }
            month = arrMonthCode[row].description
        }
        else
        {
            if month == ""
            {
                month = arrMonthCode[0].description
            }
            year = arrYear[row].description
        }
        expiryDate_TF.text = "\(month)-\(year)"
    }
    
    
}
extension String {

    fileprivate static let ANYONE_CHAR_UPPER = "X"
    fileprivate static let ONLY_CHAR_UPPER = "C"
    fileprivate static let ONLY_NUMBER_UPPER = "N"
    fileprivate static let ANYONE_CHAR = "x"
    fileprivate static let ONLY_CHAR = "c"
    fileprivate static let ONLY_NUMBER = "n"

    func format(_ format: String, oldString: String) -> String {
        let stringUnformated = self.unformat(format, oldString: oldString)
        var newString = String()
        var counter = 0
        if stringUnformated.count == counter {
            return newString
        }
        for i in 0..<format.count {
            var stringToAdd = ""
            let unicharFormatString = format[i]
            let charFormatString = unicharFormatString
            let charFormatStringUpper = unicharFormatString.uppercased()
            let unicharString = stringUnformated[counter]
            let charString = unicharString
            let charStringUpper = unicharString.uppercased()
            if charFormatString == String.ANYONE_CHAR {
                stringToAdd = charString
                counter += 1
            } else if charFormatString == String.ANYONE_CHAR_UPPER {
                stringToAdd = charStringUpper
                counter += 1
            } else if charFormatString == String.ONLY_CHAR_UPPER {
                counter += 1
                if charStringUpper.isChar() {
                    stringToAdd = charStringUpper
                }
            } else if charFormatString == String.ONLY_CHAR {
                counter += 1
                if charString.isChar() {
                    stringToAdd = charString
                }
            } else if charFormatStringUpper == String.ONLY_NUMBER_UPPER {
                counter += 1
                if charString.isNumber() {
                    stringToAdd = charString
                }
            } else {
                stringToAdd = charFormatString
            }

            newString += stringToAdd
            if counter == stringUnformated.count {
                if i == format.count - 2 {
                    let lastUnicharFormatString = format[i + 1]
                    let lastCharFormatStringUpper = lastUnicharFormatString.uppercased()
                    let lasrCharControl = (!(lastCharFormatStringUpper == String.ONLY_CHAR_UPPER) &&
                                            !(lastCharFormatStringUpper == String.ONLY_NUMBER_UPPER) &&
                                            !(lastCharFormatStringUpper == String.ANYONE_CHAR_UPPER))
                    if lasrCharControl {
                        newString += lastUnicharFormatString
                    }
                }
                break
            }
        }
        return newString
    }

    func unformat(_ format: String, oldString: String) -> String {
        var string: String = self
        var undefineChars = [String]()
        for i in 0..<format.count {
            let unicharFormatString = format[i]
            let charFormatString = unicharFormatString
            let charFormatStringUpper = unicharFormatString.uppercased()
            if !(charFormatStringUpper == String.ANYONE_CHAR_UPPER) &&
                !(charFormatStringUpper == String.ONLY_CHAR_UPPER) &&
                !(charFormatStringUpper == String.ONLY_NUMBER_UPPER) {
                var control = false
                for i in 0..<undefineChars.count {
                    if undefineChars[i] == charFormatString {
                        control = true
                    }
                }
                if !control {
                    undefineChars.append(charFormatString)
                }
            }
        }
        if oldString.count - 1 == string.count {
            var changeCharIndex = 0
            for i in 0..<string.count {
                let unicharString = string[i]
                let charString = unicharString
                let unicharString2 = oldString[i]
                let charString2 = unicharString2
                if charString != charString2 {
                    changeCharIndex = i
                    break
                }
            }
            let changedUnicharString = oldString[changeCharIndex]
            let changedCharString = changedUnicharString
            var control = false
            for i in 0..<undefineChars.count {
                if changedCharString == undefineChars[i] {
                    control = true
                    break
                }
            }
            if control {
                var i = changeCharIndex - 1
                while i >= 0 {
                    let findUnicharString = oldString[i]
                    let findCharString = findUnicharString
                    var control2 = false
                    for j in 0..<undefineChars.count {
                        if findCharString == undefineChars[j] {
                            control2 = true
                            break
                        }
                    }
                    if !control2 {
                        string = (oldString as NSString).replacingCharacters(in: NSRange(location: i, length: 1), with: "")
                        break
                    }
                    i -= 1
                }
            }
        }
        for i in 0..<undefineChars.count {
            string = string.replacingOccurrences(of: undefineChars[i], with: "")
        }
        return string
    }

    fileprivate func isChar() -> Bool {
        return regexControlString(pattern: "[a-zA-ZğüşöçıİĞÜŞÖÇ]")
    }

    fileprivate func isNumber() -> Bool {
        return regexControlString(pattern: "^[0-9]*$")
    }

    fileprivate func regexControlString(pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let numberOfMatches = regex.numberOfMatches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            return numberOfMatches == self.count
        } catch {
            return false
        }
    }
}
extension String {

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        let rangeLast: Range<Index> = start..<end
        return String(self[rangeLast])
    }
}
