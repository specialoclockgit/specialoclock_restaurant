//
//  EditRestoProfileVC.swift
//  Spacial OClock
//
//  Created by cql211 on 12/07/23.
//

import UIKit
import Photos
import PhotosUI
import MobileCoreServices
import SDWebImage
import DropDown
class EditRestoProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tfOffer: CustomTextField!
    @IBOutlet weak var tfLocation: CustomTextField!
    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var lblHeading : UILabel!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfTheme : UITextField!
    @IBOutlet weak var tfCategory : UITextField!
    @IBOutlet weak var tfCusinies : UITextField!
    @IBOutlet weak var tvDescription : UITextView!
    @IBOutlet weak var viewCuisines : UIView!
    @IBOutlet weak var viewOffer : UIView!
    @IBOutlet weak var viewCategory : UIView!
    @IBOutlet weak var tfClose: CustomTextField!
    @IBOutlet weak var tfOpen: CustomTextField!
    @IBOutlet weak var imgMain : UIImageView!
    @IBOutlet weak var imgOptionOne : UIImageView!
    @IBOutlet weak var imgOptionTwo : UIImageView!
    @IBOutlet weak var imgOptionThree : UIImageView!
    
    //MARK: Variables
    var isImageSelected = false
    var heading = String()
    var pickerView = UIPickerView()
    var imgArr = [UIImage]()
//    var isImageSelected = false
    var isCompId:Bool? = false
    var viewmodel = AuthViewModel()
    var dataTheme: [ThemeModelBody]?
    var dataCategory: [CategoryListingModelBody]?
    var dataCuisine: [CuisineListingModelBody]?
    var viewmodelresto = restoViewModal()
    var datagetApi : RestaurentDetailsModelBody?
    var arrayimage : [RestaurantImage]?
    var images:[FileuploadModelBody]?
    var image:[FileuploadModelBody]?
    let timePicker = UIDatePicker()
    let timePicker2 = UIDatePicker()
    var openTime = String()
    var CloseTime = String()
    let dropDown = DropDown()
    var themeId = Int()
    var Cuisinid = Int()
    var categoryID = Int()
    var isSingleImage = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVW.delegate = self
        collectionVW.dataSource = self
        ShowtimePicker1()
        ShowtimePicker2()
        initialLoad()
        self.setupAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
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
    //MARK: - FUNCTION API RESTSURENT DETAILS
    func setupAPI() {
        viewmodelresto.restaurentDetails { data in
            self.datagetApi = data
            self.tfName.text = data?.name?.capitalized ?? ""
            self.tvDescription.text = data?.shortDescription
            self.tfLocation.text = data?.location ?? ""
            self.tfOpen.text =  data?.openTime ?? ""
            self.tfClose.text = data?.closeTime ?? ""
            self.tfTheme.text =  data?.themesRestrorant?.productName ?? ""
            self.tfCusinies.text = data?.cuisineNames?.first?.name ?? ""
            self.themeId = data?.themesRestrorantID ?? 0
            self.imgMain.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.imgMain.sd_setImage(with: URL(string: imageURL + (data?.profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")),placeholderImage: UIImage(named: "placeholder 1"))
            self.arrayimage = self.datagetApi?.restaurantImages ?? []
            
            DispatchQueue.main.async {
                            for i in 0..<( self.datagetApi?.restaurantImages?.count ?? 0) {
                                // let url = URL(string: (productInfo?.image![i].image ?? ""))
                                SDWebImageDownloader.shared.downloadImage(with: URL(string: (imageURL) + (self.datagetApi?.restaurantImages![i].image ?? "")), options: [.highPriority], progress: nil) { (img, data, error, result) in
                                    if img != nil{
                                        self.imgArr.append(img ?? UIImage())
                                        self.collectionVW.reloadData()
                                    }
                                }
                            }
                        }
            
            
            
          //  self.collectionVW.reloadData()
            //          for i in 0..<(self.arrayimage?.count ?? 0){
            //              if i == 0{
            //                  let imgUrl = (imageURL) + (self.arrayimage?[i].image ?? "" )
            //                  self.imgFirst.sd_setImage(with: URL.init(string: imgUrl),placeholderImage:UIImage.init(named: ""), completed: nil)
            //              }else if i == 1{
            //                  let imgUrl = (imageURL) + (self.arrayimage?[i].image ?? "" )
            //                  self.imgSecond.sd_setImage(with: URL.init(string: imgUrl),placeholderImage:UIImage.init(named: ""), completed: nil)
            //              }else if i == 2{
            //                  let imgUrl = (imageURL) + (self.arrayimage?[i].image ?? "" )
            //                  self.imgThird.sd_setImage(with: URL.init(string: imgUrl),placeholderImage:UIImage.init(named: ""), completed: nil)
            //              }
            //
            //          }
        }
    }
    
    //MARK: Button Action
    @IBAction func btnBackAct(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCameraAct(_ sender : UIButton){
        if sender.tag == 0 {
            ImagePicker().pickImage(self) { (image) in
                self.viewmodel.fileUploadedAPI(type: "image", image: image) { [weak self] imageData in
                    //                self?.imgString = imageData
                    self?.image = imageData ?? [FileuploadModelBody]()
                }
                self.imgMain.image = image
                self.isSingleImage = true
            }
        }
    }
    @IBAction func btnCategory(_ sender: Any) {
        setupCuisineApi()
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
    @IBAction func btnTheme(_ sender: Any) {
        setupThemeApi()
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
    @IBAction func btnCusine(_ sender: Any) {
        setupCuisineApi()
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
    
    @IBAction func btnSaveAct(_ sender : UIButton){
            self.viewmodel.fileUploadeMultipledAPI(type: "image", image: self.imgArr) { (objData) in
                self.images = objData
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.viewmodelresto.editRestaurent(isSingleImage:self.isSingleImage,isImageSelected: self.isImageSelected, restrorant_id: self.datagetApi?.id ?? 0, profile_image: self.image ?? [FileuploadModelBody](), name: self.tfName.text ?? "", image: self.images ?? [FileuploadModelBody](), location: self.tfLocation.text ?? "" , open_time:self.tfOpen.text ?? "" , category_id: self.categoryID , themes_restrorant_id: self.themeId.description , short_description: self.tvDescription.text ?? "", closetime: self.tfClose.text ?? "") {
                        self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @objc func crossbtn(_ sender: UIButton){
        imgArr.remove(at:sender.tag)
        self.collectionVW.reloadData()
    }
    
    //FUNCTION PHP PICKER
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
        } else {
        }
        timePicker.locale = Locale(identifier: "en")
        timePicker.calendar = Calendar(identifier: .gregorian)
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneteTime1));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        tfOpen.inputAccessoryView = toolbar
        tfOpen.inputView = timePicker
    }
    
    @objc func doneteTime1(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        formatter.locale = Locale(identifier: "en")
        formatter.calendar = Calendar(identifier: .gregorian)
        //        formatter.dateFormat = "HH:mm a"
        tfOpen.text = formatter.string(from: timePicker.date)
        openTime =  formatter.string(from: timePicker.date)
        print(tfOpen ?? "")
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func ShowtimePicker2() {
        timePicker2.datePickerMode = .time
        timePicker2.locale = Locale(identifier: "en")
        timePicker2.calendar = Calendar(identifier: .gregorian)
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
        tfClose.inputAccessoryView = toolbar
        tfClose.inputView = timePicker2
    }
    
    @objc func doneteTime2() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        formatter.locale = Locale(identifier: "en")
        formatter.calendar = Calendar(identifier: .gregorian)
        //        formatter.dateFormat = "HH:mm a"
        tfClose.text = formatter.string(from: timePicker2.date)
        CloseTime =  formatter.string(from: timePicker2.date)
        
        if CloseTime > openTime{
            tfClose.text = formatter.string(from: timePicker2.date)
            
            print(tfClose ?? "")
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

extension EditRestoProfileVC{
    func initialLoad(){
        view.hideKeyboardWhenTappedAround()
        lblHeading.text = heading
        tvDescription.layer.cornerRadius = 10.0
        tfCategory.inputView = pickerView
        tfTheme.inputView = pickerView
        tfCusinies.inputView = pickerView
//        imgMain.layer.cornerRadius = 10.0
//        imgOptionOne.layer.cornerRadius = 10.0
//        imgOptionTwo.layer.cornerRadius = 10.0
//        imgOptionThree.layer.cornerRadius = 10.0
        let status = Store.userDetails?.bussinesstype
        if status == 1{
            lblName.text = "Restaurant Name"
            tfName.placeholder = "Enter Name"
            viewCategory.isHidden = true
        }else if status == 2{
            lblName.text = "Bar/Club Name"
            tfName.placeholder = "Bar/Club Name"
            viewCuisines.isHidden = true
            viewOffer.isHidden = true
        }
    }
}
//EXTENSION COLLECTION VIEW
extension EditRestoProfileVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            print("uuuuuu",self.imgArr.count ?? 0)
            return self.imgArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestoEditProfileCVC", for: indexPath) as! RestoEditProfileCVC
        cell.btnCross.tag = indexPath.row
        cell.btnCross.addTarget(self, action: #selector(crossbtn), for: .touchUpInside)
        
        if indexPath.section == 1 {
            cell.imgCar.isHidden = false
            cell.btnCross.isHidden = false
            cell.btncamera.isHidden = true
          //  cell.imgCar.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.imgCar.image = imgArr[indexPath.row]
                //.sd_setImage(with: URL(string: imageURL + (arrayimage?[indexPath.row].image ?? "")),placeholderImage: UIImage(named: "pl"))
        } else {
            cell.imgCar.image = UIImage(named: "About")
            cell.btnCross.isHidden = true
            cell.imgCar.isHidden = true
            cell.btncamera.isHidden = false
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
            }else {
                openPHPicker()
            }
        }
    }
}
//EXTENSION MULTIPLE SELECT IMAGE
@available(iOS 14, *)
extension EditRestoProfileVC: PHPickerViewControllerDelegate {
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
//
                    self.collectionVW.reloadData()
                    imageCount += 1 // Increment the loaded image count
                    if imageCount == results.count {
//                        self.viewmodel.fileUploadeMultipledAPI(type: "image", image: self.imgArr) { (objData) in
//                            self.images = objData
//                        }
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
