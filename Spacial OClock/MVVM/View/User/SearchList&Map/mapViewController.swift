//
//  mapViewController.swift
//  Spacial OClock
//
//  Created by cqlios on 17/10/23.
//

import UIKit
import GooglePlaces
import GoogleMaps

class mapViewController: UIViewController,GMSMapViewDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var collVw: UICollectionView!
    //MARK: - VARIABELS
    var latitude = Double()
    var longitude = Double()
    var locMarkers = [GMSMarker]()
    var nearBy = [NearbyRestaurant]()
    var tempNearBy = [NearbyRestaurant]()
    var iscomeFrom = Int()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collVw.isHidden = true
        // collVw.isHidden = iscomeFrom == 0 ? true : false
        collVw.delegate = self
        collVw.dataSource = self
        mapView.delegate = self
        if iscomeFrom == 0{
            setLocation()
        } else {
            getalllocations()
            print("countis",nearBy.count)
        }
        
        
        //getalllocations()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setLocation(){
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(self.latitude ), longitude: Double(self.longitude )))
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(Double(self.latitude )), longitude: CLLocationDegrees(Double(longitude)), zoom: 16)
        print("=====map loc",latitude,longitude)
        marker.icon = UIImage.init(named: "pinPerson")
        mapView.animate(to: camera)
        marker.map = self.mapView
    }
    
    //MARK: - FUNCTIONS
    func getalllocations() {
        mapView.clear()
        for index in 0..<nearBy.count {
            if let returnedPlace = nearBy[index] as? NearbyRestaurant {
                
                var percentage = ""
                var latitude = ""
                var longitude = ""
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
                    print("mapImg",image)
                }
                
                let marker = GMSMarker()
                
                let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(Double(latitude ) ?? 0.0), longitude: CLLocationDegrees(Double(longitude ) ?? 0.0 ), zoom: 16)
                
                print("=====map loc",latitude,longitude)
                marker.position = checkIfMutlipleCoordinates(latitude: Float(Double(latitude) ?? 0.0), longitude: Float(Double(longitude) ?? 0.0))
                let view = Bundle.main.loadNibNamed("CustomMarker", owner: nil, options: nil)?.first as! CustomMarker
                if Store.screenType == 1 {
                    view.lblPersot.text = "\(percentage)%"
                    view.providerImageView.isHidden = true
                }else {
                    view.providerImageView.isHidden = false
                    view.lblPersot.text = ""
                    view.providerImageView.showIndicator(baseUrl: imageURL, imageUrl: image.replacingOccurrences(of: " ", with: "%20"))
                }
                self.locMarkers.append(marker)
                marker.iconView = view
                mapView.animate(to: camera)
                marker.map = self.mapView
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if iscomeFrom == 0{
            
        }else{
            if let selectedindex = locMarkers.firstIndex(of: marker){
                self.tempNearBy = self.nearBy.filter({$0.offerPercentage == self.nearBy[selectedindex].offerPercentage})
                self.collVw.isHidden = self.tempNearBy.count == 0 ? true : false
                self.collVw.reloadData()
                //                let vc = self.storyboard?.instantiateViewController(identifier: "ItemDetailsVC") as! ItemDetailsVC
                //                vc.ProductID = self.nearBy[selectedindex].id ?? 0
                //                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        return true
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension mapViewController{
    func checkIfMutlipleCoordinates(latitude : Float , longitude : Float) -> CLLocationCoordinate2D{
        
        var lat = latitude
        var lng = longitude
        
        // arrFilterData is array of model which is giving lat long
        
        let arrTemp = self.nearBy.filter {
            
            return (((latitude == Float($0.latitude ?? "")) && (longitude == Float($0.longitude ?? ""))))
        }
        
        // arrTemp giving array of objects with similar lat long
        if (arrTemp.count ) > 1{
            // Core Logic giving minor variation to similar lat long
            let variation = (randomFloat(min: 0.0, max: 1.0) - 0.5) / 1500
            lat = lat + variation
            lng = lng + variation
            
            let finalPos = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
            return  finalPos
            
        }else{
            let variation = (randomFloat(min: 0.0, max: 1.0) - 0.5) / 1500
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


extension mapViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempNearBy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collVw.dequeueReusableCell(withReuseIdentifier: "mapViewCVC", for: indexPath) as! mapViewCVC
        cell.listing = tempNearBy[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ItemDetailsVC") as! ItemDetailsVC
        vc.ProductID = self.tempNearBy[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collVw.frame.size.width, height: 120)
    }
    
}
