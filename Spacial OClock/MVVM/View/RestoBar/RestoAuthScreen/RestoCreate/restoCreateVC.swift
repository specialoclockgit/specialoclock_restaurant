////
////  restoCreateVC.swift
////  Special O'Clock
////
////  Created by cql99 on 16/06/23.
////
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
    @IBOutlet weak var tfCity : UITextField!
    
    //MARK: - VARIABELS
    var heading = String()
    var btnCheckStatus = Int()
    var name = String()
    let timePicker = UIDatePicker()
    let timePicker2 = UIDatePicker()
    var pickerView = UIPickerView()
    var imgArr = [UIImage]()
    var isImageSelected = false
    var singleimage = false
    
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
    var imgmultiple = String()
    var themeId = [Int]()
    var Cuisinid = Int()
    var categoryID = Int()
    var image:[FileuploadModelBody]?
    var images:[FileuploadModelBody]?
    var openTime = String()
    var CloseTime = String()
    var state = String()
    var city = String()
    var country = String()
    var selectedCategory: [Int] = []
    var selectedCusinis: [Int] = []
    var restoVM = restoViewModal()
    var datagetApi : [LocationListBody]?
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        tfTheme.tintColor = UIColor.clear
        ShowtimePicker1()
        ShowtimePicker2()
        tfCusinies.delegate = self
        tfCategory.delegate = self
        tfLocation.delegate = self
        tfCity.delegate = self
        self.setupThemeApi()
        self.setupCuisineApi()
        self.setupCategoryApi()
        self.setupLocations()
    }
    
    func setupLocations(){
        viewmodel.locationGetapicall { data in
            self.datagetApi = data
        }
    }
    
    //MARK: - THEME API
    func setupThemeApi() {
        self.viewmodel.themeapicall { data in
            self.dataTheme = data ?? []
        }
    }
    //MARK: - CATEGORY API
    func setupCategoryApi() {
        self.viewmodel.Categoryapicall { data in
            self.dataCategory  = data ?? []
        }
    }
    //MARK: - CUISINE API
    func setupCuisineApi() {
        self.viewmodel.Cuisineapicall { data in
            self.dataCuisine = data ?? []
        }
    }
    //MARK: - BUTTON BACK
    @IBAction func btnGallay(_ sender: UIButton) {
        ImagePicker().pickImage(self) { (image) in
            self.viewmodel.fileUploadedAPI(type: "image", image: image) { [weak self] imageData in
                //                self?.imgString = imageData
                self?.image = imageData ?? [FileuploadModelBody]()
                self?.singleimage = true
            }
            
            self.imgProfileResto.image = image
        }
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK : - BUTTON SIGNUP
    @IBAction func btnSignUPAct(_ sender : UIButton){
//        if !(singleimage){
//            CommonUtilities.shared.showAlert(message: "Please select  image", isSuccess: .error)
//        } else if self.imgArr.count  <= 2{
//            CommonUtilities.shared.showAlert(message: "Please select 3 image", isSuccess: .error)
//        }else {
        viewmodel.addbusinessApi(singleimage: self.singleimage, isImageSelected: self.isImageSelected,country: self.country,state: self.state,city: self.city,latitude: Double(latitude) ?? 0.0,longitude: Double(longitude) ?? 0.0, Profileimage: self.image ?? [FileuploadModelBody](), type: self.btnCheckStatus, name: self.tfName.text ?? "", image: self.images ?? [FileuploadModelBody](), location: self.tfCity.text ?? "", opentime: self.tfOpenTime.text ?? "", closetime: self.tfCloseTime.text ?? "", themesrestrorantid:self.themeId.description, cusine: self.selectedCusinis.description, shortdescription: self.tvDescription.text ?? "", category: self.selectedCategory.description) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestoVerificationAlertVC")as! RestoVerificationAlertVC
                vc.callBack = {
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: LoginVC.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                }
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
                
            }
        }
    //}
    
    @IBAction func btnInfo(_ sender: UIButton) {
        CommonUtilities.shared.showAlert(message: "You can select multiple cuisine")
    }
    
    
    //MARK: - BUTTON THEME DROP DOWN
    @IBAction func btnTheme(_ sender: UIButton) {
        let data = dataTheme
        dropDown.dataSource = dataTheme?.map({$0.productName}) ?? []
        dropDown.anchorView = tfTheme
        dropDown.width = tfTheme.frame.width
        dropDown.bottomOffset = CGPoint(x: 0, y: (tfTheme as AnyObject).frame.size.height)
        dropDown.show()
        dropDown.multiSelectionAction = { [weak self] (indices: [Int], items: [String]) in
            guard let self = self else { return }
            self.themeId = indices.map { self.dataTheme?[$0].id ?? 0 }
            self.tfTheme.text = items.joined(separator: ", ")
        }
//        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
//            self?.themeId = self?.dataTheme?[index].id ?? 0
//            guard let _ = self else { return }
//            self?.tfTheme.text = "\(item) "
//
//        }
    }
    //MARK: - BUTTON CATEGORY DROP DOWN
    @IBAction func btnCategory(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.dataSource = dataCategory?.map({$0.title}) ?? []
        dropDown.anchorView = tfCategory
        dropDown.width = tfCategory.frame.width
        dropDown.bottomOffset = CGPoint(x: 0, y: (tfCategory as AnyObject).frame.size.height)
        dropDown.show()
        dropDown.multiSelectionAction = { [weak self] (indices: [Int], items: [String]) in
            guard let self = self else { return }
            self.selectedCategory = indices.map { self.dataCategory?[$0].id ?? 0 }
            self.tfCategory.text = items.joined(separator: ", ")
        }
    }
    //MARK: - BUTTON CUISINE DROP DOWN
    @IBAction func btnCuisines(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.dataSource = dataCuisine?.map({$0.name}) ?? []
        dropDown.anchorView = tfCusinies
        dropDown.width = tfCusinies.frame.width
        dropDown.bottomOffset = CGPoint(x: 0, y: (tfCusinies as AnyObject).frame.size.height)
        dropDown.show()
        dropDown.multiSelectionAction = { [weak self] (indices: [Int], items: [String]) in
            guard let self = self else { return }
            self.selectedCusinis = indices.map { self.dataCuisine?[$0].id ?? 0 }
            self.tfCusinies.text = items.joined(separator: ", ")
        }
    }
    //MARK : - BUTTON CROSS
    @objc func crossbtn(_ sender: UIButton){
        imgArr.remove(at:sender.tag)
        self.coolectionVW.reloadData()
    }
    
    //    FUNCTION PHP PICKER
    func openPHPicker() {
        if #available(iOS 14.0, *) {
            var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
            phPickerConfig.selectionLimit = 3
            phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
            let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
            phPickerVC.delegate = self
            present(phPickerVC, animated: true)
        } else {
        }
    }
    //MARK: - START TIME
    func ShowtimePicker1(){
        //Formate Date
        timePicker.datePickerMode = .time
        if #available(iOS 14.0, *) {
            timePicker.preferredDatePickerStyle = .wheels
            timePicker.minuteInterval = 30
        } else {
        }
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneteTime1));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        tfOpenTime.inputAccessoryView = toolbar
        tfOpenTime.inputView = timePicker
    }
    
    @objc func doneteTime1(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        tfOpenTime.text = formatter.string(from: timePicker.date)
        openTime =  formatter.string(from: timePicker.date)
        print(tfOpenTime ?? "")
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func ShowtimePicker2() {
        timePicker2.datePickerMode = .time
        timePicker2.minuteInterval = 30
        timePicker2.minuteInterval = 30
        if #available(iOS 14.0, *) {
            timePicker2.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneteTime2));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker2));
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        tfCloseTime.inputAccessoryView = toolbar
        tfCloseTime.inputView = timePicker2
    }
    
    @objc func doneteTime2() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        //        formatter.dateFormat = "HH:mm a"
        tfCloseTime.text = formatter.string(from: timePicker2.date)
        CloseTime =  formatter.string(from: timePicker2.date)
        
        if CloseTime > openTime{
            tfCloseTime.text = formatter.string(from: timePicker2.date)
            
            print(tfCloseTime ?? "")
            self.view.endEditing(true)
        }else {
            // Show an error message or prevent setting the end time
            // For example, you can show an alert:
            showAlert(message: "End time must be after start time")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func cancelDatePicker2() {
        self.view.endEditing(true)
    }
}


//MARK: - EXTENSION CHANGES UI
extension restoCreateVC{
    func initialLoad(){
        view.hideKeyboardWhenTappedAround()
        lblHeading.text = heading
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 40
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tfTheme.inputView = pickerView
        tfCusinies.inputView = pickerView
        let check =  UserDefaults.standard.status
        if btnCheckStatus == 1 {
            lblName.text = "Restaurant Name"
            viewCategory.isHidden = true
        }else if btnCheckStatus == 2 {
            lblName.text = "Bar Name"
            lblHeading.text = "Pub & Bar Profiler"
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
        
        if collectionView == coolectionVW {
            self.isImageSelected = true
            if indexPath.section != 0 {
            }else{
//                CommonUtilities.shared.showAlertCustomeBrn(message: "Please select", firstTitle: "Gallery", secondTitle: "Camera") { Camera in
                    ImagePicker().pickImage(self) { (img) in
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                            // your code here
//                            self.imgArr.append(img)
//                            self.coolectionVW.reloadData()
//                            print("camera",img)
//                        }
                        DispatchQueue.main.async {
                            self.imgArr.append(img)
                            self.isCompId = true
                            self.coolectionVW.reloadData()
//                            imageCount += 1 // Increment the loaded image count
//                            if imageCount == results.count {
                                // All images have been loaded, you can perform any additional tasks here
                                self.viewmodel.fileUploadeMultipledAPI(type: "image", image: self.imgArr) { (objData) in
                                    self.images = objData
                                }
//                            }
                        }
                        
                        
                    }
//                } CancelMove: { Gallery in
//                    self.openPHPicker()
//
//                }
                
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
                        self.viewmodel.fileUploadeMultipledAPI(type: "image", image: self.imgArr) { (objData) in
                            self.images = objData
                        }
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
// MARK: - EXTENSION OF LOCTAIONS
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
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)") ?? 00
        //21.228124
        let lon: Double = Double("\(pdblLongitude)") ?? 00
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
            if placemarks != nil
            {
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
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
//                    self.locationLbl.text = addressString
                    self.tfLocation.text = addressString
                    self.city = pm.locality ?? ""
                    self.state = pm.administrativeArea  ?? ""
                    self.country = pm.country ?? ""
                }
            }
        })
        
    }
}
// MARK: - EXTENSION OF TEXTFIELD
extension restoCreateVC{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfLocation {
            let dropDown = DropDown()
            dropDown.dataSource = datagetApi?.map({$0.country ?? ""}) ?? []
            dropDown.anchorView = tfLocation
            dropDown.width = tfLocation.frame.width
            dropDown.bottomOffset = CGPoint(x: 0, y: (tfLocation as AnyObject).frame.size.height)
            dropDown.show()
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                self?.tfLocation.text = item
                self?.country = item
                self?.tfCity.text = ""
            }
//            let placePickerController = GMSAutocompleteViewController()
//            placePickerController.delegate = self
//            present(placePickerController, animated: true, completion: nil)
            return false
        }else if textField == tfCity {
            
            if self.tfLocation.text?.trimmingCharacters(in: .whitespaces).isEmpty == true {
                CommonUtilities.shared.showAlert(message: "Please select country", isSuccess: .error)
            }else {
                let dropDown = DropDown()
                let data = datagetApi?.first(where: {$0.country == self.tfLocation.text})?.restaurants?.map({$0.localityArea ?? ""})
                let states = datagetApi?.first(where: {$0.country == self.tfLocation.text})?.restaurants?.map({$0.state ?? ""})
                let citys = datagetApi?.first(where: {$0.country == self.tfLocation.text})?.restaurants?.map({$0.city ?? ""})
                dropDown.dataSource = data ?? []
                //datagetApi?.map({$0.country ?? ""}) ?? []
                dropDown.anchorView = tfLocation
                dropDown.width = tfLocation.frame.width
                dropDown.bottomOffset = CGPoint(x: 0, y: (tfLocation as AnyObject).frame.size.height)
                dropDown.show()
                dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                    self?.tfCity.text = item
                    self?.city = citys?[index] ?? ""
                    self?.state = states?[index] ?? ""
                    
                }
            }
            return false
        }
        return true
    }
}

