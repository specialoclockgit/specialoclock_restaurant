//
//  restoCreateVC.swift
//  Special O'Clock
//
//  Created by cql99 on 16/06/23.
//

import UIKit
import Photos
import PhotosUI
import MobileCoreServices
import DropDown
import GooglePlaces
class restoCreateVC: UIViewController, UITextFieldDelegate {

    //MARK: - OUTLETS
    @IBOutlet weak var tfLocation: CustomTextField!
    @IBOutlet weak var coolectionVW: UICollectionView!
    @IBOutlet weak var tfCloseTime: CustomTextField!
    @IBOutlet weak var tfOpenTime: CustomTextField!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfCusinies : UITextField!
    @IBOutlet weak var imgProfileResto : UIImageView!
    @IBOutlet weak var tfTheme : UITextField!
    @IBOutlet weak var tvDescription : UITextView!
    @IBOutlet weak var viewTheme : UIView!
    @IBOutlet weak var viewCategory : UIView!
    @IBOutlet weak var viewCuisines : UIView!
    @IBOutlet weak var viewOffer : UIView!
    @IBOutlet weak var tfCategory: CustomTextField!
    
    //MARK: - VARIABELS
    var heading = String()
    var btnCheckStatus = Int()
    var name = String()
    let timePicker = UIDatePicker()
    let timePicker2 = UIDatePicker()
    var pickerView = UIPickerView()
    var imgArr = [UIImage]()
    var isImageSelected = false
    var isCompId:Bool? = false
    let dropDown = DropDown()
    var latitude = String()
    var longitude = String()
    let dropDown2 = DropDown()
    var viewmodel = AuthViewModel()
    var dataTheme: [ThemeModelBody]?
    var dataCategory: [CategoryListingModelBody]?
    var dataCuisine: [CuisineListingModelBody]?
    var imgString:String?
    var imgmultiple:String?
    var themeId = Int()
    var Cuisinid = Int()
    var categoryID = Int()
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        tfTheme.tintColor = UIColor.clear
        self.showTimePicker()
        self.showTimePicker2()
        tfCusinies.delegate = self
        tfCategory.delegate = self
        tfLocation.delegate = self
        self.setupThemeApi()
        self.setupCuisineApi()
        self.setupCategoryApi()

    }
    func setupThemeApi() {
        self.viewmodel.themeapicall { data in
            self.dataTheme = data ?? []
        }
    }
    func setupCategoryApi() {
        self.viewmodel.Categoryapicall { data in
            self.dataCategory  = data ?? []
        }
    }
    func setupCuisineApi() {
        self.viewmodel.Cuisineapicall { data in
            self.dataCuisine = data ?? []
        }
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSignUPAct(_ sender : UIButton){
        viewmodel.addbusinessApi(isImageSelected: isImageSelected, Profileimage: imgProfileResto, type: 1, name: tfName.text ?? "", image: ["imgArr"], location: tfLocation.text ?? "", opentime: tfOpenTime.text ?? "", closetime: tfCloseTime.text ?? "", themesrestrorantid: String(themeId ?? 0), cusine: String(Cuisinid ?? 0), shortdescription: tvDescription.text ?? "") {
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: ViewController.RestoTabBarVC)as! RestoTabBarVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
//    @IBAction func btnRestoProfileAct(_ sender : UIButton){
//        ImagePicker().pickImage(self) { (image) in
//            self.imgProfile.image = image
//            self.viewmodel.fileUploadedAPI(type: "image", image: image) { [weak self] imageData in
//                self?.image = imageData ?? [FileuploadModelBody]()
//            }
//            self.isImageSelected = true
//        }
//    }
    @IBAction func btnTheme(_ sender: UIButton) {
        let data = dataTheme
        dropDown.dataSource = dataTheme?.map({$0.productName}) ?? []
        dropDown.anchorView = tfTheme
        dropDown.width = tfTheme.frame.width
        dropDown.bottomOffset = CGPoint(x: 0, y: (tfTheme as AnyObject).frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.themeId = self?.dataTheme?[index].id ?? 0
            guard let _ = self else { return }
            self?.tfTheme.text = "\(item) "
            
        }
    }
    @IBAction func btnCategory(_ sender: Any) {
        
        dropDown.dataSource = dataCategory?.map({$0.title}) ?? []
        dropDown.anchorView = tfCategory
        dropDown.width = tfCategory.frame.width
        dropDown.bottomOffset = CGPoint(x: 0, y: (tfCategory as AnyObject).frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.tfCategory.text = "\(item) "
            
        }
    }
        @IBAction func btnCuisines(_ sender: Any) {
            dropDown.dataSource = dataCuisine?.map({$0.name}) ?? []
            dropDown.anchorView = tfCusinies
            dropDown.width = tfCusinies.frame.width
            dropDown.bottomOffset = CGPoint(x: 0, y: (tfCusinies as AnyObject).frame.size.height)
            dropDown.show()
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                self?.Cuisinid = self?.dataCuisine?[index].id ?? 0
                guard let _ = self else { return }
                self?.tfCusinies.text = "\(item) "
                
            }
        }
    @objc func crossbtn(_ sender: UIButton){
        imgArr.remove(at:sender.tag)
        self.coolectionVW.reloadData()
    }
    //    FUNCTION PHP PICKER
        func openPHPicker() {
            if #available(iOS 14.0, *) {
                var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
                phPickerConfig.selectionLimit = 15
                phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
                let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
                phPickerVC.delegate = self
                present(phPickerVC, animated: true)
            } else {
            }
        }
//    FUNCTION TIME PICKER
    func showTimePicker(){
           //Formate Date
        timePicker.datePickerMode = .time
        
           if #available(iOS 14.0, *) {
               timePicker.preferredDatePickerStyle = .wheels
           } else {
           }
           let toolbar = UIToolbar();
           toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker));
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker));
           
           toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
           tfOpenTime.inputAccessoryView = toolbar
        tfOpenTime.inputView = timePicker
       }
       
       @objc func doneTimePicker(){
           let formatter = DateFormatter()
           formatter.dateFormat = " h:mm a"
        
           //  datePicker.datePickerMode = UIDatePicker.Mode.time
           tfOpenTime.text = formatter.string(from: timePicker.date)
           formatter.dateFormat = " h:mm a"
           let resultString = formatter.string(from: timePicker.date)
           //          self.startDate = resultString
           print(resultString)
           self.view.endEditing(true)
       }
    @objc func cancelTimePicker(){
            self.view.endEditing(true)
        }
    
    //    FUNCTION TIME PICKER SECOND
    func showTimePicker2(){
           //Formate Date
        timePicker2.datePickerMode = .time
           if #available(iOS 14.0, *) {
               timePicker2.preferredDatePickerStyle = .wheels
           } else {
               // Fallback on earlier versions
           }
           
           //ToolBar
           let toolbar = UIToolbar();
           toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker2));
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker2));
           
           toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
           tfCloseTime.inputAccessoryView = toolbar
        tfCloseTime.inputView = timePicker2
       }
       
       @objc func doneTimePicker2(){
           let formatter = DateFormatter()
           formatter.dateFormat = " h:mm a"
        
           //  datePicker.datePickerMode = UIDatePicker.Mode.time
           tfCloseTime.text = formatter.string(from: timePicker2.date)
           formatter.dateFormat = " h:mm a"
           let resultString = formatter.string(from: timePicker2.date)
           //          self.startDate = resultString
           print(resultString)
           self.view.endEditing(true)
       }
    @objc func cancelTimePicker2(){
            self.view.endEditing(true)
        }
}
extension restoCreateVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        tvDescription.text = .none
    }
    
}
extension restoCreateVC{
    func initialLoad(){
        view.hideKeyboardWhenTappedAround()
        lblHeading.text = heading
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 40
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tfTheme.inputView = pickerView
        tfCusinies.inputView = pickerView
//        imgOptionOne.layer.cornerRadius = 10.0
//        imgOptionTwo.layer.cornerRadius = 10.0
//        imgOptionThree.layer.cornerRadius = 10.0
        if btnCheckStatus == 0 {
            lblName.text = "Restaurant Name"
            viewCategory.isHidden = true
        }else if btnCheckStatus == 1 {
            lblName.text = "Bar Name"
            viewCuisines.isHidden = true
            viewOffer.isHidden = true
            viewCategory.isHidden = false
        }
    }
}
//EXTENSION COLLECTION VIEW
extension restoCreateVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.imgArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadImgCVC", for: indexPath) as! UploadImgCVC
        cell.btnCross.tag = indexPath.row
        cell.btnCross.addTarget(self, action: #selector(crossbtn), for: .touchUpInside)
        
        if indexPath.section == 1 {
            cell.carImg.isHidden = false
            cell.btnCross.isHidden = false
            cell.cameraImg.isHidden = true
            cell.carImg.image = imgArr[indexPath.row]
        } else {
            cell.carImg.image = UIImage(named: "About")
            cell.btnCross.isHidden = true
            cell.carImg.isHidden = true
            cell.cameraImg.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 13 , height: 100 )
//        collectionVW.frame.height / 1 - 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionView {
            self.isImageSelected = true
            if indexPath.section != 0 {
//                self.imgArr.removeAll()
            
                
            }else{
                openPHPicker()

            }
        }
    }
}

//EXTENSION MULTIPLE SELECT IMAGE
@available(iOS 14, *)
extension restoCreateVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        var imageCount = 0 // Track the number of successfully loaded images
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                if let error = error {
                    // Handle the error here, you can print it for debugging purposes
                    print("Error loading image: \(error.localizedDescription)")
                    return
                }
                guard let image = reading as? UIImage else { return }
                DispatchQueue.main.async {
                    self.imgArr.append(image)
                    self.isCompId = true
                    self.coolectionVW.reloadData()
                    imageCount += 1 // Increment the loaded image count
                    if imageCount == results.count {
                        // All images have been loaded, you can perform any additional tasks here
                    }
                }
            }
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: kUTTypeImage as String) { [weak self] url, error in
                if let error = error {
                    print("Error getting image URL: \(error.localizedDescription)")
                    return
                }
                if let imageURL = url {
                    
                }
            }
        }
    }
}
// MARK: - EXTENSION OF
extension restoCreateVC:GMSAutocompleteViewControllerDelegate {
    //MARK:- GMSAutocompleteViewController delegates
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place attributions: \(place.attributions)")
        print(place)
        self.latitude = String(place.coordinate.latitude)
        self.longitude = String(place.coordinate.longitude)
        getAddressFromLatLon(pdblLatitude: self.latitude, withLongitude: self.longitude)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
        dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)") ?? 0.0
        //21.228124
        let lon: Double = Double("\(pdblLongitude)") ?? 0.0
        //72.833770
       
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.administrativeArea != nil {
                        addressString = addressString + pm.administrativeArea! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(pm.postalCode)
                    print(pm.country)
                    print(pm.locality)
                    print(pm.administrativeArea)
                    print(addressString)

                    self.tfLocation.text = addressString
//                    self.tfPostalCode.text = pm.postalCode
//                    self.tfState.text = pm.administrativeArea
///                    self.tfCountry.text = pm.country
                }
        })
    }
    
}
// MARK: - EXTENSION OF TEXTFIELD
extension restoCreateVC{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      if textField == tfLocation {
          let placePickerController = GMSAutocompleteViewController()
          placePickerController.delegate = self
          present(placePickerController, animated: true, completion: nil)
          return false
      }
     return true
    }
}

