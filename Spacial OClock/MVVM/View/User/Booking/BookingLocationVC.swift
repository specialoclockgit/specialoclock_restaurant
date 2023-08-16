//
//  BookingLocationVC.swift
//  Spacial OClock
//
//  Created by cql211 on 18/07/23.
//

import UIKit
import MapKit
import CoreLocation
class BookingLocationVC: UIViewController  , CLLocationManagerDelegate, MKMapViewDelegate{
    
    //MARK: Outlets
    @IBOutlet weak var mapKitView : MKMapView!
    
    //MARK: Variables
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapKitView.delegate = self
        tabBarController?.tabBar.isHidden = true
        mapKitView.showsUserLocation = true
        mapKitView.userLocation.title = ""
        
        mapKitView.overrideUserInterfaceStyle = .light
        getLocation()
        let userLocation =  CLLocationCoordinate2D(latitude: Double(30.7046) , longitude: Double(76.7179) )
        let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapKitView.setRegion(viewRegion, animated: true)
    }

    private func getLocation() {
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.notDetermined || status == CLAuthorizationStatus.denied || status == CLAuthorizationStatus.restricted
        {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "userLocationPin")
            // annotationView.canShowCallout = true
            
            let image = UIImage(named: "currentLocation") // Load the image
            let imageView = UIImageView(image: image)
            let imageSize = CGSize(width: 150, height: 40) // Adjust the size of the image if needed
            let imageOffset = CGPoint(x: -70, y: -50) // Adjust the image offset as desired
            
            imageView.frame = CGRect(origin: imageOffset, size: imageSize)
            annotationView.addSubview(imageView)
            
            annotationView.markerTintColor = .clear
            annotationView.glyphImage = UIImage(named: "userLocation")
            return annotationView
        }
        return nil
    }
    
    //MARK: Button Actions
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
