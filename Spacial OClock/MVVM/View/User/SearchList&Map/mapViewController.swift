//
//  mapViewController.swift
//  Spacial OClock
//
//  Created by cqlios on 17/10/23.
//

import UIKit
import GooglePlaces
import GoogleMaps

class mapViewController: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var mapView: GMSMapView!
    
    //MARK: - VARIABELS
    var latitude = Double()
    var longitude = Double()
    var nearBy = [NearbyRestaurant]()
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - FUNCTIONS
    func getalllocations() {
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
                    
                    let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(Double(latitude ) ?? 0.0), longitude: CLLocationDegrees(Double(longitude ) ?? 0.0 ), zoom: 50)
                  
                    print("=====map loc",latitude,longitude)
                    mapView.animate(to: camera)
                    marker.position = CLLocationCoordinate2DMake(Double(latitude) ?? 0.0, Double(longitude) ?? 0.0)
                   let view = Bundle.main.loadNibNamed("CustomMarker", owner: nil, options: nil)?.first as! CustomMarker
                    view.lblPersot.text = "\(percentage)%"
//                    view.providerImageView.image = UIImage(named: "favourite")
                    marker.iconView = view
                    marker.map = self.mapView
                    marker.userData = returnedPlace
                }
            }
       
        }
}

