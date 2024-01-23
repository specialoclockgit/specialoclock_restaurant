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
    
    //MARK: - VARIABELS
    var latitude = Double()
    var longitude = Double()
    var nearBy = [NearbyRestaurant]()
    var iscomeFrom = Int()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        if iscomeFrom == 0{
            setLocation()
        }else{
            getalllocations()
        }
       
        print("countis",nearBy.count)
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
                
                marker.iconView = view
                mapView.animate(to: camera)
                marker.map = self.mapView
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if iscomeFrom == 0{
            
        }else{
            let vc = self.storyboard?.instantiateViewController(identifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = self.nearBy[0].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
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
        if (arrTemp.count ?? 0 ) > 1{
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
