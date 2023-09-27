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
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        gmsMapView.delegate = self
        initialLoad()
        tbHomeData.delegate = self
        tbHomeData.dataSource = self
//        self.lblLocation.text = Store.userDetails?.location ?? ""
        isSelected = true
        //MARK: Dine or Drink UserDefault for itemDetailOffer
        UserDefaults.standard.set(0, forKey: "dineDrinkStatus")
        self.getUpdatedLocation()
//        setDine()
       // setupMarker()
    }
    
    
    //MARK: - MARK SHOW IN GOOGLE MAP
    func getalllocations() {
            for index in 0..<nearBy.count {
                if let returnedPlace = nearBy[index] as? NearbyRestaurant {
                    
                    var percentage = ""
                    var latitude = "0.0"
                    var longitude = "0.0"
                    
                    if let name = returnedPlace.profileImage {
                        percentage = name as String
                    }
                    
                    if let latis = returnedPlace.latitude {
                        latitude = latis
                    }
                    
                    if let longis = returnedPlace.longitude {
                        longitude = longis
                    }

                    let marker = GMSMarker()
                    
                    let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(Double(latitude ) ?? 0.0), longitude: CLLocationDegrees(Double(longitude ) ?? 0.0 ), zoom: 15)
                  
                    print("=====map loc",latitude,longitude)
                    gmsMapView.animate(to: camera)
                    marker.position = CLLocationCoordinate2DMake(Double(latitude) ?? 0.0, Double(longitude) ?? 0.0)
                   let view = Bundle.main.loadNibNamed("CustomMarker", owner: nil, options: nil)?.first as! CustomMarker
        
                    view.providerImageView.image = UIImage(named: "favourite")
        
                    marker.iconView = view
                    marker.map = self.gmsMapView
                    marker.userData = returnedPlace
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
    
    func setData(type: Int, country: String, state: String) {
        self.viewModel.homeApi(type: type, country: country, state: state,lat: self.lat ?? 0.0, long: self.long ?? 0.0) { (objData) in
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
        self.navigationController?.pushViewController(vc, animated: true)
//        let screen = storyboard?.instantiateViewController(withIdentifier: "BookingLocationVC") as! BookingLocationVC
//        self.navigationController?.pushViewController(screen, animated: true)
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
//        arrHomeTBModel.removeAll()
//        arrHomeTBModel.append(contentsOf: arrDineIN)
        //Table cell Heading Array Data
        arrHeading.removeAll()
        arrHeading.append(contentsOf: arrDineHeader)
        
        UserDefaults.standard.set(0, forKey: "dineDrinkStatus")
        setData(type: 1, country: "India", state: "Punjab")
        self.tbHomeData.layoutSubviews()
    }
    
    func setDrink() {
        imgViewDrinks.image = UIImage(named: "greenDrink")
        imgViewDinein.image = UIImage(named: "DiningGray")
        lblDineIn.textColor = UIColor.lightGray
        lblDrinks.textColor = UIColor.black
        isSelected = false
//        arrHomeTBModel.removeAll()
//        arrHomeTBModel.append(contentsOf: arrDrinks)
        //Table Cell Heading Array Data
        arrHeading.removeAll()
        arrHeading.append(contentsOf: arrDrinkHeading)
        tbHomeData.reloadData()
        UserDefaults.standard.set(1, forKey: "dineDrinkStatus")
        setData(type: 2, country: "India", state: "Punjab")
        self.tbHomeData.layoutSubviews()
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
                print(placemark.country!)
                
                self.lblLocation.text = "\(placemark.locality!)"
            }
        }
        locationManager.stopUpdatingLocation()
    }
}

//MARK: - EXETNSIONS
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tbHomeData.dequeueReusableCell(withIdentifier: Cell.CellImageViewTB, for: indexPath) as! CellImageViewTB
            cell.banners = self.viewModel.homeData?.banners ?? [Banner]()
            cell.collView.reloadData()
            return cell
        }else{
            let cell = tbHomeData.dequeueReusableCell(withIdentifier: Cell.CellHomeTB, for: indexPath) as! CellHomeTB
            cell.lblHeading.text = arrHeading[indexPath.section].heading
            cell.img.image =  UIImage(named: arrHeading[indexPath.section].img)
            cell.btnSeeMore.addTarget(self, action: #selector(btnSeeMoreAct), for: .touchUpInside)
            cell.btnSeeMore.tag = indexPath.section
            cell.collView.tag = indexPath.section
            
            cell.iconString = arrHeading[indexPath.section].img
            cell.heading = arrHeading[indexPath.section].heading
            if indexPath.section == 0 {
                cell.location = self.viewModel.homeData?.location ?? [HomeListLocation]()
                cell.collView.reloadData()
            }else if indexPath.section == 1 {
                if isSelected == true {
                    cell.isCellSelected = true
                    cell.cuisine = self.viewModel.homeData?.cuisine ?? [Cuisine]()
                    cell.collView.reloadData()
                }else{
                    cell.category = self.viewModel.homeData?.category ?? [Category]()
                    cell.collView.reloadData()
                    cell.isCellSelected = false
                }
            }else if indexPath.section == 3 {
                cell.themeArr = self.viewModel.homeData?.theme ?? [ThemeData]()
                cell.collView.reloadData()
            }
            return cell
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return CGFloat(100.0)
        }else{
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
        switch sender.tag {
        case 0 :
            screen.setvalue = "Location"
            screen.location = self.viewModel.homeData?.location ?? [HomeListLocation]()
            self.navigationController?.pushViewController(screen, animated: true)
        case 1:
            debugPrint("Case 1")
            if isSelected == true {
                screen.setvalue = "Cuisine"
                screen.cuisine = self.viewModel.homeData?.cuisine ?? [Cuisine]()
            }else{
                screen.setvalue = "Category"
                screen.category = self.viewModel.homeData?.category ?? [Category]()
            }
            self.navigationController?.pushViewController(screen, animated: true)
           
        case 3:
            if isSelected == true {
                screen.setvalue = "Theme"
                screen.themeArr = self.viewModel.homeData?.theme ?? [ThemeData]()
            }else{
                debugPrint("Not Selected")
            }
            self.navigationController?.pushViewController(screen, animated: true)
            debugPrint("case 3")
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
