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

struct Header{
    var heading : String
    var img : String
    
}
var arrHomeTBModel : [HomeTBModel] = [HomeTBModel(heading: "Location", name:["Central Cape Town","Rondebosch" ],
                                                  img: ["location1" ,"location2"],  restoClub: ["32 Restaurants" , "7 Restaurants"]) ,
                                      HomeTBModel(heading: "Cuisines", name: ["Grill","Sushi" ], img: ["image3" ,"image2"], restoClub:  ["32 Restaurants" , "7 Restaurants"]),
                                      HomeTBModel(heading: "", name: [""], img: [""], restoClub: [""]),
                                      HomeTBModel(heading: "Theme", name: ["OceanView","Hotel" ], img:  ["Theme1","theme2" ], restoClub:  ["32 Restaurants" , "7 Restaurants"])]

var arrHome = ["Location","Cuisines","","Theme"]

class HomeVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, GMSMapViewDelegate{

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
    
    //MARK: - VARIABELS
    var lat : Double?
    var long : Double?
    let locationManager = CLLocationManager()
    var arrHeading  : [Header] = [Header(heading: "Locations", img: "PIN")  ,
                                  Header(heading: "Cuisines", img: "soup") ,
                                  Header(heading: "", img: "" ),
                                  Header(heading: "Theme", img: "mask")]
    var arrDineHeader : [Header] = [Header(heading: "Locations", img: "PIN")  ,
                                    Header(heading: "Cuisines", img: "soup") ,
                                    Header(heading: "", img: "" ),
                                    Header(heading: "Theme", img: "mask")]
    
    var arrDrinkHeading : [Header] = [Header(heading: "Locations", img: "PIN")  ,
                                      Header(heading: "Categories", img: "category") ,
                                      Header(heading: "", img: "" ),
                                      Header(heading: "Theme", img: "mask")]
    //Drink Data
    let arrDrinks : [HomeTBModel] = [HomeTBModel(heading: "Location", name: ["Central Cape Town" ,"Rondebosch"],  img: ["location1","location2"], restoClub: ["32 Restaurants", "7 Restaurants"]) ,HomeTBModel(heading: "Category", name: ["Wise Crax","Bangin Brews"], img: ["drinkImg1","drinkImg2"], restoClub: ["32 Clubs", "7 Clubs"]),HomeTBModel(heading: "", name: [""], img: [""], restoClub: [""]),HomeTBModel(heading: "Theme", name: ["Ocean View","Beach" ], img:  ["drinkTheme1","drinkTheme2" ], restoClub: ["32 Bar", "7 Bar"])]
    //Dine In Data
    let arrDineIN : [HomeTBModel] = [HomeTBModel(heading: "Location", name:["Central Cape Town","Rondebosch" ],img: ["location1" ,"location2"],  restoClub: ["32 Restaurants" , "7 Restaurants"]) ,HomeTBModel(heading: "Cuisines", name: ["Grill","Grill" ], img: ["image3" ,"image2"], restoClub:  ["32 Restaurants" , "7 Restaurants"]),HomeTBModel(heading: "", name: [""], img: [""], restoClub: [""]),HomeTBModel(heading: "Theme", name: ["OceanView","Hotel" ], img:  ["theme1","theme2" ], restoClub:  ["32 Restaurants" , "7 Restaurants"])]
    
    let manager = CLLocationManager()
    var isSelected  = Bool()
    var viewModel = HomeViewModel()
    var nearBy = [NearbyRestaurant]()
    var locationUpdated = Bool()
    var getstate = String()
    var getcity = String()
    var getcountry = String()
    
    
    
    fileprivate var sectionArray: [SectionModel] = []
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        gmsMapView.delegate = self
        initialLoad()
        tbHomeData.delegate = self
        tbHomeData.dataSource = self
        isSelected = true
        //MARK: Dine or Drink UserDefault for itemDetailOffer
        UserDefaults.standard.set(0, forKey: "dineDrinkStatus")
        self.getUpdatedLocation()
    }
    
    
    //MARK: - MARK SHOW IN GOOGLE MAP
    func getalllocations() {
            for index in 0..<(nearBy.count) {
                if let returnedPlace = nearBy[index] as? NearbyRestaurant {
                    
                    var percentage = ""
                    var latitude = "0.0"
                    var longitude = "0.0"
                    
                    if let name = returnedPlace.offerPercentage {
                        percentage = name
                    }
                    
                    if let latis = returnedPlace.latitude {
                        latitude = latis
                    }
                    
                    if let longis = returnedPlace.longitude {
                        longitude = longis
                    }
                    
                    let marker = GMSMarker()
              
                    
                    print("=====map loc",latitude,longitude)
               
                    marker.position = checkIfMutlipleCoordinates(latitude: Float(latitude) ?? 0.0, longitude: Float(longitude) ?? 0.0)
                
                   let view = Bundle.main.loadNibNamed("CustomMarker", owner: nil, options: nil)?.first as! CustomMarker
                    view.lblPersot.text = "\(percentage)%"
//                    view.providerImageView.image = UIImage(named: "favourite")
                    marker.iconView = view
                    marker.map = self.gmsMapView
                    marker.userData = returnedPlace
                }
                if self.nearBy.count == 0 {
                    let location = CLLocationCoordinate2D(latitude: Double(Store.userDetails?.latitude ?? "" ) ?? 0, longitude: Double(Store.userDetails?.longitude ?? "" ) ?? 0)
                    let camera1 = GMSCameraPosition.camera(withTarget: location, zoom: 5)
                    gmsMapView.animate(to: camera1)
                } else {
                    let camera2 = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(Double(nearBy.first?.latitude ?? "" ) ?? 0.0), longitude: CLLocationDegrees(Double(nearBy.first?.longitude ?? "" ) ?? 0.0 ), zoom: 5)
                    gmsMapView.animate(to: camera2)
                }
            }
       
        }
    
    override func viewWillAppear(_ animated: Bool) {
        setDine()
        tabBarController?.tabBar.isHidden  = false
        self.tbHomeData.layoutSubviews()
        self.imgProfile.showIndicator(baseUrl: imageURL, imageUrl: Store.userDetails?.image ?? "")
    }
    
    
    func getUpdatedLocation(){
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
         //   locationManager.distanceFilter = 100.0
            if #available(iOS 14.0, *) {
                locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            } else {
                // Fallback on earlier versions0000
            }
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        //MARK:- Enable Location Services
        if !hasLocationPermission() {
            let alertController = UIAlertController(title: "Enable Location Services", message: "Special o'clock wants to access your location only to provide better experience to you.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationUpdated = true
                locationManager.delegate = self
             //   locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
            }else{
                locationUpdated = false
            }
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            @unknown default:
                fatalError()
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }
    
    func setData(type: Int, country: String, state: String, city:String) {
        self.sectionArray.removeAll()
        self.viewModel.homeApi(type: type, country: country, city: city, state: state,lat: self.lat ?? 0.0, long: self.long ?? 0.0) { (objData) in
            
            if objData?.location?.count ?? 0 != 0 {
                let obj = SectionModel(name: "Location",objArray: objData?.location ?? [],image: "PIN")
                self.sectionArray.append(obj)
            }
            
            if objData?.cuisine?.count ?? 0 != 0 {
                let obj = SectionModel(name: "Cusinis",objArray: objData?.cuisine ?? [],image: "soup")
                self.sectionArray.append(obj)
            }
            
            if objData?.highily_rated_bars_restos?.count ?? 0 != 0 {
                let obj = SectionModel(name: "Popular",objArray: objData?.highily_rated_bars_restos ?? [],image: "Popular")
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
            self.viewModel.homeData = objData
            self.nearBy = objData?.nearby_restaurants ?? []
            self.getalllocations()
            self.tabBarController?.tabBar.isHidden  = false
            self.tbHomeData.layoutSubviews()
            self.tbHomeData.reloadData()
            print("themeArr",self.viewModel.homeData?.theme?.count)
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnLocationAct(_ sender : UIButton){
        let serviceStoryboard = UIStoryboard.init(name: "RestoBar", bundle: nil)
        let vc = serviceStoryboard.instantiateViewController(withIdentifier: "MyOfferVC") as! MyOfferVC
        vc.callback = { dataa in
            self.getcity = dataa
            self.lblLocation.text = self.getcity
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnDine(_ sender: UIButton) {
        if sender.isSelected == false{
            setDine()
            sender.isSelected = false
        }
    }
    
    @IBAction func btnDrinks(_ sender: UIButton) {
        if sender.isSelected == false{
               setDrink()
            sender.isSelected = false
        }
    }
    
    func setDine() {
        imgViewDinein.image = UIImage(named: "DiningGreen")
        imgViewDrinks.image = UIImage(named: "greyDrink")
        lblDrinks.textColor = UIColor.lightGray
        lblDineIn.textColor = UIColor.black
        isSelected = true
        arrHeading.removeAll()
        arrHeading.append(contentsOf: arrDineHeader)
        UserDefaults.standard.set(0, forKey: "dineDrinkStatus")
        setData(type: 1, country:self.getcountry, state: "", city: self.getcity)
        self.tbHomeData.layoutSubviews()
    }
    
    func setDrink() {
        imgViewDrinks.image = UIImage(named: "greenDrink")
        imgViewDinein.image = UIImage(named: "DiningGray")
        lblDineIn.textColor = UIColor.lightGray
        lblDrinks.textColor = UIColor.black
        isSelected = false
        arrHeading.removeAll()
        arrHeading.append(contentsOf: arrDrinkHeading)
        tbHomeData.reloadData()
        UserDefaults.standard.set(1, forKey: "dineDrinkStatus")
       // setData(type: 2, country: self.getcountry, state: self.getstate, city: self.getcity)
        self.tbHomeData.layoutSubviews()
    }
    @IBAction func btnMapView(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "mapViewController") as! mapViewController
//        vc.latitude = self.lat ?? 0.0
//        vc.longitude = self.long ?? 0.0
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        vc.city = self.getcity
        vc.type = 1
        vc.latitude = self.lat ?? 0.0
        vc.longitude = self.long ?? 0.0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnProfileAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.UserProfileVC) as! UserProfileVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    //FUNCTION CURRENT LOCATIONS
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lat = locValue.latitude
        self.long = locValue.longitude
        let location = locations.last! as CLLocation
        //  self.locationLbl.text = location
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks as? [CLPlacemark]
            if placemark?.count ?? 0>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                self.getcountry = placemark.country ?? ""
               // self.getcity = placemark.administrativeArea ?? ""
                self.getstate = placemark.locality ?? ""
                print(placemark.country!)
                
                self.lblLocation.text = "\(placemark.locality!)"
            //    self.lblLocation.text = placemarks.coun
            }
        }
        locationManager.stopUpdatingLocation()
    }
}

//MARK: - EXETNSIONS
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sectionArray[indexPath.section].name == "Banner" {
            let cell = tbHomeData.dequeueReusableCell(withIdentifier: Cell.CellImageViewTB, for: indexPath) as! CellImageViewTB
            cell.banners = self.viewModel.homeData?.banners ?? [Banner]()
            cell.collView.reloadData()
            return cell
        } else {
            let cell = tbHomeData.dequeueReusableCell(withIdentifier: Cell.CellHomeTB, for: indexPath) as! CellHomeTB
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
            } else if sectionArray[indexPath.section].name == "Cusinis" {
                cell.isCellSelected = true
                cell.cuisine = sectionArray[indexPath.section].objArray as? [Cuisine] ?? []
                cell.collView.reloadData()
            }else if sectionArray[indexPath.section].name == "Popular" {
                cell.heishtresto = sectionArray[indexPath.section].objArray as? [AllBarsResto] ?? []
                cell.collView.reloadData()
            }else if sectionArray[indexPath.section].name == "Theme" {
                cell.themeArr = sectionArray[indexPath.section].objArray as? [ThemeData] ?? []
                cell.collView.reloadData()
            }else if sectionArray[indexPath.section].name == "A-Z" {
                cell.allresto = sectionArray[indexPath.section].objArray as? [AllBarsResto] ?? []
                cell.collView.reloadData()
            }
            return cell
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sectionArray[indexPath.section].name == "Banner" {
            return CGFloat(80)
        } else {
            return CGFloat(250.0)
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
        let screen = storyboard?.instantiateViewController(withIdentifier: "homeSeeMoreVC") as! homeSeeMoreVC
        switch sectionArray[sender.tag].name {
        case "Location" :
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.location = sectionArray[sender.tag].objArray as? [HomeListLocation] ?? []
            self.navigationController?.pushViewController(screen, animated: true)
            
        case "Cusinis" :
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.cuisine = sectionArray[sender.tag].objArray as? [Cuisine] ?? []
            self.navigationController?.pushViewController(screen, animated: true)
            
        case "Category" :
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.category = sectionArray[sender.tag].objArray as? [Category] ?? []
            self.navigationController?.pushViewController(screen, animated: true)
           
        case "Popular" :
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.all_bars_restos = sectionArray[sender.tag].objArray as? [AllBarsResto] ?? []
            self.navigationController?.pushViewController(screen, animated: true)
            
        case "Theme" :
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.themeArr = sectionArray[sender.tag].objArray as? [ThemeData] ?? []
            self.navigationController?.pushViewController(screen, animated: true)
            
        case "A-Z" :
            screen.setvalue = sectionArray[sender.tag].name ?? ""
            screen.highily_rated_bars_restos = sectionArray[sender.tag].objArray as? [AllBarsResto] ?? []
            self.navigationController?.pushViewController(screen, animated: true)
            
//        case 1:
//            debugPrint("Case 1")
//            if isSelected == true {
//                screen.setvalue = "Cuisine"
//                screen.cuisine = self.viewModel.homeData?.cuisine ?? [Cuisine]()
//            }else{
//                screen.setvalue = "Category"
//                screen.category = self.viewModel.homeData?.category ?? [Category]()
//            }
//            self.navigationController?.pushViewController(screen, animated: true)
//
//        case 3:
//            if isSelected == true {
//                screen.setvalue = "Theme"
//                screen.themeArr = self.viewModel.homeData?.theme ?? [ThemeData]()
//            }else{
//                screen.setvalue = "Theme"
//                screen.themeArr = self.viewModel.homeData?.theme ?? [ThemeData]()
//                debugPrint("Not Selected")
//            }
//            self.navigationController?.pushViewController(screen, animated: true)
//            debugPrint("case 3")
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
    func checkIfMutlipleCoordinates(latitude : Float , longitude : Float) -> CLLocationCoordinate2D {
           
           var lat = latitude
           var lng = longitude
           // arrFilterData is array of model which is giving lat long
            let arrTemp = nearBy.filter {
               return (((latitude == Float($0.latitude ?? "")) && (longitude == Float($0.longitude ?? ""))))
           }
           // arrTemp giving array of objects with similar lat long
        if (arrTemp.count ) > 1{
               // Core Logic giving minor variation to similar lat long
               let variation = (randomFloat(min: 0.0, max: 2.0) - 0.5) / 1500
               lat = lat + variation
               lng = lng + variation
               let finalPos = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
               return  finalPos
           } else {
               let variation = (randomFloat(min: 0.0, max: 2.0) - 0.5) / 1500
               lat = lat + variation
               lng = lng + variation
               let finalPos = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
               return  finalPos
           }
       }
       
       func randomFloat(min: Float, max:Float) -> Float {
           return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
       }
}


struct SectionModel {
    var name: String?
    var objArray: [Any]?
    var image: String?
}
