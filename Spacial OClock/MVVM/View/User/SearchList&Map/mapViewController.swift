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
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        print("countis",nearBy.count)
        getalllocations()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    //MARK: - FUNCTIONS
    func getalllocations() {
        mapView.clear()
        for index in 0..<nearBy.count {
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
                
                let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(Double(latitude ) ?? 0.0), longitude: CLLocationDegrees(Double(longitude ) ?? 0.0 ), zoom: 16)
                
                print("=====map loc",latitude,longitude)
//                mapView.animate(to: camera)
                marker.position = checkIfMutlipleCoordinates(latitude: Float(Double(latitude) ?? 0.0), longitude: Float(Double(longitude) ?? 0.0))
                //CLLocationCoordinate2DMake(Double(latitude) ?? 0.0, Double(longitude) ?? 0.0)
                let view = Bundle.main.loadNibNamed("CustomMarker", owner: nil, options: nil)?.first as! CustomMarker
                view.lblPersot.text = "\(percentage)%"
                
                //                    view.providerImageView.image = UIImage(named: "favourite")
                marker.iconView = view
                mapView.animate(to: camera)
                marker.map = self.mapView
//                marker.userData = returnedPlace
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let vc = self.storyboard?.instantiateViewController(identifier: "ItemDetailsVC") as! ItemDetailsVC
        vc.ProductID = self.nearBy[0].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
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
            //            let eventTemp = self.viewModel.eventData?.filter {
            //
            //                return (((latitude == Float($0.latitude ?? "0.0")) && (longitude == Float($0.longitude ?? "0.0"))))
            //            }
            //
            //  if (eventTemp?.count ?? 0) > 1{
            // Core Logic giving minor variation to similar lat long

            let variation = (randomFloat(min: 0.0, max: 1.0) - 0.5) / 1500
            lat = lat + variation
            lng = lng + variation

            // }

            let finalPos = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
            return  finalPos

        }

    }

    func randomFloat(min: Float, max:Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
