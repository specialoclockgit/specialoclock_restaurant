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

struct Header{
    var heading : String
    var img : String
    
}
var arrHomeTBModel : [HomeTBModel] = [HomeTBModel(heading: "Location", name:["Central Cape Town","Rondebosch" ],
                                                  img: ["location1" ,"location2"],  restoClub: ["32 Restaurants" , "7 Restaurants"]) ,
                                      HomeTBModel(heading: "Cuisines", name: ["Grill","Sushi" ], img: ["image3" ,"image2"], restoClub:  ["32 Restaurants" , "7 Restaurants"]),
                                      HomeTBModel(heading: "", name: [""], img: [""], restoClub: [""]),
                                      HomeTBModel(heading: "Theme", name: ["OceanView","Hotel" ], img:  ["Theme1","theme2" ], restoClub:  ["32 Restaurants" , "7 Restaurants"])]

class HomeVC: UIViewController  , CLLocationManagerDelegate,MKMapViewDelegate{

    //MARK: - OUTLETS
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
    let arrDrinks : [HomeTBModel] = [HomeTBModel(heading: "Location", name: ["Central Cape Town" ,"Rondebosch"
                                      ],  img: ["location1","location2"], restoClub: ["32 Restaurants", "7 Restaurants"]) ,
                                     HomeTBModel(heading: "Category", name: ["Wise Crax","Bangin Brews"], img: ["drinkImg1","drinkImg2"], restoClub: ["32 Clubs", "7 Clubs"]),
                                     HomeTBModel(heading: "", name: [""], img: [""], restoClub: [""]),
                                     HomeTBModel(heading: "Theme", name: ["Ocean View","Beach" ], img:  ["drinkTheme1","drinkTheme2" ], restoClub: ["32 Bar", "7 Bar"])]
    //Dine In Data
    let arrDineIN : [HomeTBModel] = [HomeTBModel(heading: "Location", name:["Central Cape Town","Rondebosch" ],
                                    img: ["location1" ,"location2"],  restoClub: ["32 Restaurants" , "7 Restaurants"]) ,
                                     HomeTBModel(heading: "Cuisines", name: ["Grill","Grill" ], img: ["image3" ,"image2"], restoClub:  ["32 Restaurants" , "7 Restaurants"]),
                                     HomeTBModel(heading: "", name: [""], img: [""], restoClub: [""]),
                                     HomeTBModel(heading: "Theme", name: ["OceanView","Hotel" ], img:  ["theme1","theme2" ], restoClub:  ["32 Restaurants" , "7 Restaurants"])]
    
    let manager = CLLocationManager()
    var isSelected  = Bool()
    
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib(nibName: Cell.CellHomeTB, bundle: nil)
//        self.tbHomeData.register(nib, forCellReuseIdentifier: Cell.CellHomeTB)
//        let nibImgView = UINib(nibName: Cell.CellImageViewTB, bundle: nil)
//        self.tbHomeData.register(nibImgView, forCellReuseIdentifier: Cell.CellImageViewTB)
        initialLoad()
        tbHomeData.delegate = self
        tbHomeData.dataSource = self
        isSelected = true
        
        //MARK: Dine or Drink UserDefault for itemDetailOffer
        UserDefaults.standard.set(0, forKey: "dineDrinkStatus")
        //MARK: Map kit view
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async {
                self.manager.delegate = self
                self.manager.desiredAccuracy = kCLLocationAccuracyBest
                self.manager.startUpdatingLocation()
                self.mapView.delegate = self
                self.mapView.mapType = .standard
                
                self.mapView.showsUserLocation = true // if you want to show default pin
            }
        }
        if let coor = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coor, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden  = false
        self.tbHomeData.layoutSubviews()
        self.imgProfile.showIndicator(baseUrl: imageURL, imageUrl: Store.userDetails?.image ?? "")
    }
    
    
    //MARK: - ACTIONS
    @IBAction func btnLocationAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: "BookingLocationVC") as! BookingLocationVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    
    @IBAction func btnDine(_ sender: UIButton) {
        if sender.isSelected == false{
            imgViewDinein.image = UIImage(named: "DiningGreen")
            imgViewDrinks.image = UIImage(named: "greyDrink")
            lblDrinks.textColor = UIColor.lightGray
            lblDineIn.textColor = UIColor.black
            sender.isSelected = false
            isSelected = true
            arrHomeTBModel.removeAll()
            arrHomeTBModel.append(contentsOf: arrDineIN)
            //Table cell Heading Array Data
            arrHeading.removeAll()
            arrHeading.append(contentsOf: arrDineHeader)
            tbHomeData.reloadData()
        }
        UserDefaults.standard.set(0, forKey: "dineDrinkStatus")
    }
    
    @IBAction func btnDrinks(_ sender: UIButton) {
        if sender.isSelected == false{
            imgViewDrinks.image = UIImage(named: "greenDrink")
            imgViewDinein.image = UIImage(named: "DiningGray")
            lblDineIn.textColor = UIColor.lightGray
            lblDrinks.textColor = UIColor.black
            sender.isSelected = false
            isSelected = false
            arrHomeTBModel.removeAll()
            arrHomeTBModel.append(contentsOf: arrDrinks)
            //Table Cell Heading Array Data
            arrHeading.removeAll()
            arrHeading.append(contentsOf: arrDrinkHeading)
            tbHomeData.reloadData()
        }
        UserDefaults.standard.set(1, forKey: "dineDrinkStatus")
    }
    
    @IBAction func btnProfileAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.UserProfileVC) as! UserProfileVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
}

//MARK: - EXETNSIONS
extension HomeVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrHomeTBModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tbHomeData.dequeueReusableCell(withIdentifier: Cell.CellImageViewTB, for: indexPath) as! CellImageViewTB
            return cell
        }else{
            let cell = tbHomeData.dequeueReusableCell(withIdentifier: Cell.CellHomeTB, for: indexPath) as! CellHomeTB
            cell.lblHeading.text = arrHeading[indexPath.section].heading
            cell.img.image =  UIImage(named: arrHeading[indexPath.section].img)
            cell.btnSeeMore.addTarget(self, action: #selector(btnSeeMoreAct), for: .touchUpInside)
            cell.btnSeeMore.tag = indexPath.section
            cell.collView.tag = indexPath.section
            cell.collView.reloadData()
            cell.iconString = arrHeading[indexPath.section].img
            cell.heading = arrHeading[indexPath.section].heading
            if isSelected == true {
                cell.isCellSelected = true
            }else{
                cell.isCellSelected = false
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
extension HomeVC{
    @objc func btnSeeMoreAct(sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.DetailItemViewVC) as! DetailItemViewVC
        screen.iconImage = arrHeading[sender.tag].img
        switch sender.tag {
        case 0 :
            arrModel = [ItemsModel(img: UIImage(named: "location1") ?? UIImage(), name: "Central Cape Town", totalRestaurant: "32 Restaurants"),
                        ItemsModel(img: UIImage(named: "location2") ?? UIImage(), name: "Rondebosch", totalRestaurant: "32 Restaurants") ,
                        ItemsModel(img: UIImage(named: "location1") ?? UIImage(), name: "Central Cape Town", totalRestaurant: "7 Restaurants")
                       ]
            screen.heading = arrHeading[sender.tag].heading
            self.navigationController?.pushViewController(screen, animated: true)
            debugPrint("Case 0 btnSeeMoreAct")
        case 1:
            debugPrint("Case 1")
            if isSelected == true {
                debugPrint("Not Selected")
                arrModel = [ItemsModel(img: UIImage(named: "image3") ?? UIImage(), name: "Pies N’ Thighs", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "image4") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "image1") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "yummy") ?? UIImage(), name: "Yummy In The Tummy", totalRestaurant: "10:00- 22:00 30%"),
                            ItemsModel(img: UIImage(named: "tanic") ?? UIImage(), name: "Thai Tanic", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "mozarella") ?? UIImage(), name: "Bella Bella Mozzarella", totalRestaurant: "10:00- 22:00 30%")]
                screen.locationName = "India"
            }else{
                debugPrint("Selected")
                arrModel = [ItemsModel(img: UIImage(named: "drinkImg1") ?? UIImage(), name: "Wise Crax’ Brews", totalRestaurant: "10:00- 22:00 30%") ,
                            ItemsModel(img: UIImage(named: "drinkImg2") ?? UIImage(), name: "Bangin’ Brews", totalRestaurant: "10:00- 22:00 30%"),
                            ItemsModel(img: UIImage(named: "drink1") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "710:00- 22:00 30%") ,
                ]
                screen.locationName = "Cocktail bar"
            }
            screen.heading = arrHeading[sender.tag].heading
            self.navigationController?.pushViewController(screen, animated: true)
           
        case 3:
            if isSelected == true {
                arrModel = [ItemsModel(img: UIImage(named: "theme1") ?? UIImage(), name: "Pies N’ Thighs", totalRestaurant: "32 Restaurants") ,
                            ItemsModel(img: UIImage(named: "image4") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "32 Restaurants") ,
                            ItemsModel(img: UIImage(named: "image1") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "7 Restaurants") ,
                            ItemsModel(img: UIImage(named: "yummy") ?? UIImage(), name: "Yummy In The Tummy", totalRestaurant: "32 Restaurants"),
                            ItemsModel(img: UIImage(named: "tanic") ?? UIImage(), name: "Thai Tanic", totalRestaurant: "7 Restaurants") ,
                            ItemsModel(img: UIImage(named: "mozarella") ?? UIImage(), name: "Bella Bella Mozzarella", totalRestaurant: "32 Restaurants")]
            }else{
                debugPrint("Not Selected")
                arrModel = [ItemsModel(img: UIImage(named: "drinkTheme1") ?? UIImage(), name: "Bangin’ Brews", totalRestaurant: "32 Restaurants") ,
                            ItemsModel(img: UIImage(named: "drinkTheme2") ?? UIImage(), name: "Wise Crax", totalRestaurant: "32 Restaurants") ,
                            ItemsModel(img: UIImage(named: "drink1") ?? UIImage(), name: "Killer Pizza", totalRestaurant: "7 Restaurants") ,
                            ItemsModel(img: UIImage(named: "drink2") ?? UIImage(), name: "Dry DockDry Dock", totalRestaurant: "32 Restaurants"),
                            ]
            }
            screen.heading = arrHeading[sender.tag].heading
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
    func initialLoad(){
        //Cell Nib
        let nib = UINib(nibName: Cell.CellHomeTB, bundle: nil)
        self.tbHomeData.register(nib, forCellReuseIdentifier: Cell.CellHomeTB)
        let nibImgView = UINib(nibName: Cell.CellImageViewTB, bundle: nil)
        self.tbHomeData.register(nibImgView, forCellReuseIdentifier: Cell.CellImageViewTB)
        
    }
}
