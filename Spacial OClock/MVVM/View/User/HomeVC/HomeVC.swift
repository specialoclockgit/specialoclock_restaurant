//
//  HomeVC.swift
//  Spacial OClock
//
//  Created by cql99 on 27/06/23.
//

import UIKit
import AVFAudio
import MapKit
import CoreLocation
import GooglePlaces
import GoogleMaps
import SDWebImage

struct Header {
    var heading : String
    var img : String
}
var arrHomeTBModel : [HomeTBModel] = [HomeTBModel(heading: "Location", name:["Central Cape Town","Rondebosch" ],
                                                  img: ["location1" ,"location2"],  restoClub: ["32 Restaurants" , "7 Restaurants"]) ,
                                      HomeTBModel(heading: "Cuisines", name: ["Grill","Sushi" ], img: ["image3" ,"image2"], restoClub:  ["32 Restaurants" , "7 Restaurants"]),
                                      HomeTBModel(heading: "", name: [""], img: [""], restoClub: [""]),
                                      HomeTBModel(heading: "Theme", name: ["OceanView","Hotel" ], img:  ["Theme1","theme2" ], restoClub:  ["32 Restaurants" , "7 Restaurants"])]

var arrHome = ["Location","Cuisines","","Theme"]

class HomeVC: UIViewController, MKMapViewDelegate, GMSMapViewDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var gmsMapView: GMSMapView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var tfSearch : UITextField!
    @IBOutlet weak var lblDrinks: UILabel!
    @IBOutlet weak var imgViewDrinks: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblDineIn: UILabel!
    @IBOutlet weak var imgViewDinein: UIImageView!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var tbHomeData : UITableView!
    @IBOutlet weak var heightTBHomeData : NSLayoutConstraint!
    @IBOutlet weak var mapView : MKMapView!
    @IBOutlet weak var btnDine : UIButton!
    @IBOutlet weak var btnDrinks : UIButton!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var mapIcon: UIImageView!
    @IBOutlet weak var mapTitleLbl: UILabel!
    //MARK: - VARIABELS
    var lat : Double?
    var long : Double?
    var locationManager: CLLocationManager!
    let manager = CLLocationManager()
    var isSelected  = Bool()
    var viewModel = HomeViewModel()
    var nearBy = [NearbyRestaurant]()
    var locationUpdated = Bool()
    var getstate = "Western Cape"
    var getcity = "Cape Town"
    var getcountry = "South Africa"
    var gettimezone = String()
    var timeZone = String()
    
    fileprivate var sectionArray: [SectionModel] = []
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblUserName.text = "Hi \(Store.userDetails?.name?.capitalized ?? ""), you’re in"
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.timeZone = TimeZone.current.identifier
        print(timeZone)
        gmsMapView.isMyLocationEnabled = true
        gmsMapView.delegate = self
        initialLoad()
        tbHomeData.delegate = self
        tbHomeData.dataSource = self
        self.isSelected = true
        self.lblLocation.text = self.getcity
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        if Store.screenType == 2 {
            self.setDrink()
        } else {
            self.setDine()
        }
        
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func appMovedToBackground() {
        print("appMovedToBackground")
    }
    
    @objc func appMovedToForeground() {
        print("appMovedToForeground")
        locationManagerDidChangeAuthorization(locationManager)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.requestLocationPermission()
    }
    
    func requestLocationPermission() {
        if locationManager == nil {
            locationManager = CLLocationManager()
        }
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden  = false
        self.tbHomeData.layoutSubviews()
        self.imgProfile.showIndicator(baseUrl: imageURL, imageUrl: Store.userDetails?.image ?? "")
    }
    
    
    
    func setData(type: Int) {
        self.sectionArray.removeAll()
        self.viewModel.homeApi(type: type, country: self.getcountry, city: self.getcity, state: self.getstate,lat: self.lat ?? 0.0, long: self.long ?? 0.0, timezone: self.timeZone) { (objData) in
            self.sectionArray.removeAll()
            self.nearBy = objData?.nearby_restaurants ?? []
            self.getalllocations()
            if objData?.location?.count ?? 0 != 0 {
                let obj = SectionModel(name: "Location",objArray: objData?.location ?? [],image: "PIN")
                self.sectionArray.append(obj)
            }
            
            if objData?.category?.count ?? 0 != 0{
                let obj = SectionModel(name: "Category",objArray: objData?.category ?? [],image: "category_icon")
                self.sectionArray.append(obj)
            }
            
            if objData?.cuisine?.count ?? 0 != 0 {
                let obj = SectionModel(name: "Cuisines",objArray: objData?.cuisine ?? [],image: "soup")
                self.sectionArray.append(obj)
            }
            
            if objData?.highily_rated_bars_restos?.count ?? 0 != 0 {
                let filterArray = objData?.highily_rated_bars_restos?.filter({$0.avgRating != 0})
                let obj = SectionModel(name: "Popular",objArray: filterArray ?? [],image: "Popular")
                self.sectionArray.append(obj)
            }
            
            if objData?.banners?.count ?? 0 != 0 {
                let obj = SectionModel(name: "Banner",objArray: objData?.banners ?? [],image: "")
                self.sectionArray.append(obj)
            }
            
            if objData?.theme?.count ?? 0 != 0 {
                let obj = SectionModel(name: "Theme",objArray: objData?.theme ?? [],image: "mask")
                self.sectionArray.append(obj)
            }
            
            if objData?.all_bars_restos?.count ?? 0 != 0 {
                let obj = SectionModel(name: "A-Z",objArray: objData?.all_bars_restos ?? [],image: "9411889")
                self.sectionArray.append(obj)
            }
            self.mapIcon.isHidden = false
            self.mapTitleLbl.isHidden = false
            self.viewModel.homeData = objData
            self.gmsMapView.isHidden = false
            self.tabBarController?.tabBar.isHidden  = false
            self.tbHomeData.layoutSubviews()
            self.tbHomeData.reloadData()
            
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnLocationAct(_ sender : UIButton){
//        let serviceStoryboard = UIStoryboard.init(name: "RestoBar", bundle: nil)
//        let vc = serviceStoryboard.instantiateViewController(withIdentifier: "MyOfferVC") as! MyOfferVC
//        vc.valueChange = "Select Country"
//        vc.callback = { dataa, time in
//            self.getcity = dataa
//            self.gettimezone = time
//            self.lblLocation.text = self.getcity
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let serviceStoryboard = UIStoryboard.init(name: "RestoBar", bundle: nil)
        let vc = serviceStoryboard.instantiateViewController(withIdentifier: "LocationsVC") as! LocationsVC
        vc.hidesBottomBarWhenPushed = true
        vc.callBack = {  [weak self] countryy, statee, cityy in
            print(countryy,statee,cityy)
            self?.lblLocation.text = cityy.capitalized
            self?.getcity = cityy
            self?.getcountry = countryy
            self?.getstate = statee
            self?.setData(type: Store.screenType ?? 1)
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnDine(_ sender: UIButton) {
        if sender.isSelected == false{
            sender.isSelected = false
        }
        setDine()
    }
    
    @IBAction func btnDrinks(_ sender: UIButton) {
        if sender.isSelected == false{
            
            sender.isSelected = false
        }
        setDrink()
    }
    
    func setDine() {

        imgViewDinein.image = UIImage(named: "DiningGreen")
        imgViewDrinks.image = UIImage(named: "greyDrink")
        lblDrinks.textColor = UIColor.lightGray
        lblDineIn.textColor = UIColor.black
        isSelected = true
        UserDefaults.standard.set(1, forKey: "dineDrinkStatus")
        UserDefaults.standard.synchronize()
        Store.screenType = 1
        setData(type: 1)
        self.tbHomeData.layoutSubviews()
    }
    
    func setDrink() {
        imgViewDrinks.image = UIImage(named: "greenDrink")
        imgViewDinein.image = UIImage(named: "DiningGray")
        lblDineIn.textColor = UIColor.lightGray
        lblDrinks.textColor = UIColor.black
        isSelected = false
        
        UserDefaults.standard.set(2, forKey: "dineDrinkStatus")
        UserDefaults.standard.synchronize()
        Store.screenType = 2
        setData(type: 2)
        self.tbHomeData.layoutSubviews()
    }
    @IBAction func btnMapView(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "mapViewController") as! mapViewController
        vc.iscomeFrom = 1
        vc.nearBy = self.nearBy.filter({ $0.offer_available == 1})
        vc.latitude = self.lat ?? 0.0
        vc.longitude = self.long ?? 0.0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        vc.city = self.getcity
        vc.type = Store.screenType ?? 1
        vc.latitude = self.lat ?? 0.0
        vc.longitude = self.long ?? 0.0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnProfileAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.UserProfileVC) as! UserProfileVC
        self.navigationController?.pushViewController(screen, animated: true)
    }

}

//MARK: - EXETNSIONS
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if sectionArray[indexPath.section].name == "Banner" {
            let cell = tbHomeData.dequeueReusableCell(withIdentifier: Cell.CellImageViewTB, for: indexPath) as! CellImageViewTB
            cell.initializeBannerData(resp: self.viewModel.homeData?.banners)
            //cell.banners = self.viewModel.homeData?.banners ?? [Banner]()
           // cell.collView.reloadData()
            return cell
        } else {
            let cell = tbHomeData.dequeueReusableCell(withIdentifier: Cell.CellHomeTB, for: indexPath) as! CellHomeTB
            cell.city = self.getcity
            cell.country = self.getcountry
            cell.lblHeading.text = sectionArray[indexPath.section].name
            cell.img.image =  UIImage(named: sectionArray[indexPath.section].image ?? "")
            cell.btnSeeMore.addTarget(self, action: #selector(btnSeeMoreAct), for: .touchUpInside)
            cell.btnSeeMore.tag = indexPath.section
            cell.objArray = sectionArray
            cell.collView.tag = indexPath.section
            cell.iconString = sectionArray[indexPath.section].image ?? ""
            cell.heading = sectionArray[indexPath.section].name ?? ""
            if sectionArray[indexPath.section].name == "Location" {
                cell.location = sectionArray[indexPath.section].objArray as? [HomeListLocation] ?? []
                cell.collView.reloadData()
            } else if sectionArray[indexPath.section].name == "Cuisines" {
                cell.isCellSelected = true
                cell.cuisine = sectionArray[indexPath.section].objArray as? [Cuisine] ?? []
                cell.collView.reloadData()
            } else if sectionArray[indexPath.section].name == "Category"{
                cell.isCellSelected = true
                cell.category = sectionArray[indexPath.section].objArray as? [Category] ?? []
                cell.collView.reloadData()
            } else if sectionArray[indexPath.section].name == "Popular" {
                cell.heishtresto = sectionArray[indexPath.section].objArray as? [AllBarsResto] ?? []
                cell.collView.reloadData()
            } else if sectionArray[indexPath.section].name == "Theme" {
                cell.themeArr = sectionArray[indexPath.section].objArray as? [ThemeData] ?? []
                cell.collView.reloadData()
            } else if sectionArray[indexPath.section].name == "A-Z" {
                cell.allresto = sectionArray[indexPath.section].objArray as? [AllBarsResto] ?? []
                cell.collView.reloadData()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sectionArray[indexPath.section].name == "Banner" {
            return CGFloat(260)
        } else if sectionArray[indexPath.section].name == "Popular" {
            if sectionArray[indexPath.section].objArray?.count  ==  0{
                return CGFloat(0)
            }else{
                return CGFloat(300)
            }
           // return CGFloat(300)
        } else if sectionArray[indexPath.section].name == "A-Z" {
            return CGFloat(300)
        } else {
            return CGFloat(280)//260
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.heightTBHomeData.constant = self.tbHomeData.contentSize.height
        }
    }
}

//MARK: Table Button Objective function
extension HomeVC {
    @objc func btnSeeMoreAct(sender : UIButton){
        switch sectionArray[sender.tag].name {
        case "Location" :
            let screen = storyboard?.instantiateViewController(withIdentifier: "newSeeMoreVC") as! newSeeMoreVC
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.location = sectionArray[sender.tag].objArray as? [HomeListLocation] ?? []
            screen.filterlocation = sectionArray[sender.tag].objArray as? [HomeListLocation] ?? []
            screen.getcity = self.getcity
            screen.getcountry = self.getcountry
            screen.iconImg = sectionArray[sender.tag].image ?? ""
            self.navigationController?.pushViewController(screen, animated: true)
            
        case "Cuisines" :
            let screen = storyboard?.instantiateViewController(withIdentifier: "newSeeMoreVC") as! newSeeMoreVC
            screen.setvalue = "Cuisines"
            screen.cuisine = sectionArray[sender.tag].objArray as? [Cuisine] ?? []
            screen.filterCusine = sectionArray[sender.tag].objArray as? [Cuisine] ?? []
            screen.getcity = self.getcity
            screen.getcountry = self.getcountry
            screen.iconImg = sectionArray[sender.tag].image ?? ""
            self.navigationController?.pushViewController(screen, animated: true)
            
        case "Category" :
            let screen = storyboard?.instantiateViewController(withIdentifier: "newSeeMoreVC") as! newSeeMoreVC
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.category = sectionArray[sender.tag].objArray as? [Category] ?? []
            screen.filtercategory = sectionArray[sender.tag].objArray as? [Category] ?? []
            screen.getcity = self.getcity
            screen.getcountry = self.getcountry
            screen.iconImg = sectionArray[sender.tag].image ?? ""
            self.navigationController?.pushViewController(screen, animated: true)
            
        case "Popular" :

            let vc = storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.highilyRatedBarsRestos = sectionArray[sender.tag].objArray as? [AllBarsResto] ?? []
            vc.filterHighilyRatedBarsRestos = sectionArray[sender.tag].objArray as? [AllBarsResto] ?? []
            vc.lblName =  ""
            vc.setValue = "Popular"
            vc.setimage = "Popular"
            vc.country = self.getcountry
            vc.city = self.getcity
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "Theme" :
            let screen = storyboard?.instantiateViewController(withIdentifier: "newSeeMoreVC") as! newSeeMoreVC
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.themeArr = sectionArray[sender.tag].objArray as? [ThemeData] ?? []
            screen.filterthemeAry = sectionArray[sender.tag].objArray as? [ThemeData] ?? []
            screen.getcity = self.getcity
            screen.getcountry = self.getcountry
            screen.iconImg = sectionArray[sender.tag].image ?? ""
            self.navigationController?.pushViewController(screen, animated: true)
            
        case "A-Z" :
            
            let vc = storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
            vc.allBarsRestos = sectionArray[sender.tag].objArray as? [AllBarsResto] ?? []
            vc.filterAllBarsRestos = sectionArray[sender.tag].objArray as? [AllBarsResto] ?? []
            vc.lblName =  ""
            vc.setValue = "A-Z"
            vc.setimage = "9411889"
            vc.country = self.getcountry
            vc.city = self.getcity
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        default:
            debugPrint("default btnSeeMoreAct")
        }
    }
}

//MARK: Text Field Delegate
extension HomeVC : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tfSearch.text = .none
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if tfSearch.text!.count == 0 {
            tfSearch.text = "Location, cuisine, restaurant name,..."
        }
    }
}

//MARK: InitialLoad
extension HomeVC {
    func initialLoad() {
        //Cell Nib
        let nib = UINib(nibName: Cell.CellHomeTB, bundle: nil)
        self.tbHomeData.register(nib, forCellReuseIdentifier: Cell.CellHomeTB)
        let nibImgView = UINib(nibName: Cell.CellImageViewTB, bundle: nil)
        self.tbHomeData.register(nibImgView, forCellReuseIdentifier: Cell.CellImageViewTB)
    }
}

extension HomeVC {
    func checkIfMutlipleCoordinates(latitude: Float, longitude: Float) -> CLLocationCoordinate2D {
        
        var lat = latitude
        var lng = longitude
        
        let arrTemp = nearBy.filter {
            return (latitude == Float($0.latitude ?? "")) && (longitude == Float($0.longitude ?? ""))
        }
        
        if arrTemp.count > 1 {
            // Core Logic giving minor variation to similar lat long
            let variation = randomFloat(min: -0.00005, max: 0.00005)
            lat += variation
            lng += variation
        } else {
            let variation = randomFloat(min: -0.0001, max: 0.0001)
            lat += variation
            lng += variation
        }
        
        let finalPos = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
        return finalPos
    }
    
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }
}


struct SectionModel {
    var name: String?
    var objArray: [Any]?
    var image: String?
}
extension HomeVC : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch  manager.authorizationStatus{
            
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
            openAlert()
        case .denied:
            print("denied")
            openAlert()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            print("authorizedAlways")
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            print("authorizedWhenInUse")
        @unknown default:
            print("@unknown")
        }
    }
    
    func openAlert() {
        let alertController = UIAlertController(title: "Enable Location Services", message: "Special O'Clock wants to access your location only to show you nearby restaurants and bars.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Go to Settings", style: .default, handler: {(cAlertAction) in
            alertController.dismiss(animated: true) {
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
        })
        alertController.addAction(okAction)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }else{
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.lat = location.coordinate.latitude
            self.long = location.coordinate.longitude
            let geocoder = CLGeocoder()
//            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
//                if (error != nil){
//                    print("error in reverseGeocode")
//                }
//                if let placemark = placemarks {
//                    if placemark.count > 0{
//                        let placemark = placemark[0]
//                        
//                        self.getcountry = placemark.country ?? ""
//                        self.getcity = placemark.locality ?? ""
//                        self.getstate = placemark.administrativeArea ?? ""
//                        self.lblLocation.text = placemark.locality ?? ""
//                        
//                        if Store.screenType == 2 {
//                            self.setDrink()
//                        } else {
//                            self.setDine()
//                        }
//                    }
//                } else {
//                    if Store.screenType == 2 {
//                        self.setDrink()
//                    } else {
//                        self.setDine()
//                    }
//                }
//                print(locations.last as Any)
//                self.locationManager.stopUpdatingLocation()
//            }
            self.locationManager.startUpdatingLocation()
        }
    }
}

extension HomeVC {
    //MARK: - MARK SHOW IN GOOGLE MAP
    func getalllocations() {
        gmsMapView.clear()
        let nearbyWithOffers = nearBy.filter { $0.offerPercentage != nil && !$0.offerPercentage!.isEmpty }
           for index in 0..<(nearbyWithOffers.count) {
               if let returnedPlace = nearbyWithOffers[index] as? NearbyRestaurant {
                   
                   var percentage = ""
                   var latitude = "0.0"
                   var longitude = "0.0"
                   var image = ""
                   if let name = returnedPlace.offerPercentage {
                       percentage = name
                   }
                   
                   if let latis = returnedPlace.latitude {
                       latitude = latis
                   }
                   
                   if let longis = returnedPlace.longitude {
                       longitude = longis
                   }
                   
                   if let img = returnedPlace.profileImage {
                       image = img
                   
                   }
                   
                   let offset = 0.0001
                   let offsetLat = (Double(latitude) ?? 0) + Double.random(in: -offset...offset)
                   let offsetLng = (Double(longitude) ?? 0) + Double.random(in: -offset...offset)
                   
                   
                   let marker = GMSMarker()
                   
                   
                   print("=====map loc",latitude,longitude)
                   let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(Double(latitude ) ?? 0.0), longitude: CLLocationDegrees(Double(longitude ) ?? 0.0 ), zoom: 16)
                   marker.position = CLLocationCoordinate2D(latitude: offsetLat, longitude: offsetLng)
                   //checkIfMutlipleCoordinates(latitude: Float(latitude) ?? 0.0, longitude: Float(longitude) ?? 0.0)
                   
                   let view = Bundle.main.loadNibNamed("CustomMarker", owner: nil, options: nil)?.first as! CustomMarker
                   if Store.screenType == 1 {
                       view.offerLbl.text = "\(percentage)%"
                       view.restroImgVw.showIndicator(baseUrl: imageURL, imageUrl: image.replacingOccurrences(of: " ", with: "%20"))
                   }else {
                       view.providerImageView.isHidden = false
                       view.lblPersot.text = ""
                       view.restroImgVw.showIndicator(baseUrl: imageURL, imageUrl: image.replacingOccurrences(of: " ", with: "%20"))
                   }
                   
                   marker.iconView = view
                   marker.map = self.gmsMapView
                   marker.userData = returnedPlace
                   self.gmsMapView.animate(to: camera)
               }
               if self.nearBy.count == 0 {
                   let location = CLLocationCoordinate2D(latitude: Double(Store.userDetails?.latitude ?? "" ) ?? 0, longitude: Double(Store.userDetails?.longitude ?? "" ) ?? 0)
                   let camera1 = GMSCameraPosition.camera(withTarget: location, zoom: 20)
                   gmsMapView.animate(to: camera1)
               } else {
                   let camera2 = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(Double(nearBy.first?.latitude ?? "" ) ?? 0.0), longitude: CLLocationDegrees(Double(nearBy.first?.longitude ?? "" ) ?? 0.0 ), zoom: 11.5)
                   gmsMapView.animate(to: camera2)
               }
           }
           
       }
}
