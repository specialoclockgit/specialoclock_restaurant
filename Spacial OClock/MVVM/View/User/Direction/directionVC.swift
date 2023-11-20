//
//  directionVC.swift
//  Spacial OClock
//
//  Created by cqlios on 20/11/23.
//

import UIKit
import MapKit

class directionVC: UIViewController, MKMapViewDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - VARIABELS
    var lat:Double?
    var lng:Double?
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if objLocationData.currentLat == 0.0 {
            return
        }
        
        mapView.delegate = self
        
        let sourceLocation = CLLocationCoordinate2D(latitude: objLocationData.currentLat ?? 0.0, longitude: objLocationData.currentLong ?? 0.0)
        let destinationLocation = CLLocationCoordinate2D(latitude: lat ?? 0.0 ,longitude: lng ?? 0.0)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let sourceRegion = MKCoordinateRegion(center: sourceLocation, span: span)
        mapView.setRegion(sourceRegion, animated: true)
        
        let destinationRegion = MKCoordinateRegion(center: destinationLocation, span: span)
        mapView.setRegion(destinationRegion, animated: true)
        
        let sourcePin = MKPointAnnotation()
        sourcePin.coordinate = sourceLocation
        mapView.addAnnotation(sourcePin)
        
        let destinationPin = MKPointAnnotation()
        destinationPin.coordinate = destinationLocation
        // destinationPin.title = name_tile ?? "Spot Location"
        mapView.addAnnotation(destinationPin)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    CommonUtilities.shared.showAlert(message: error.localizedDescription, isSuccess: .error)
                    //print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated:Bool){
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - LIFE CYCLE
    func mapView(_ mapView:MKMapView, rendererFor overlay:MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
    }
    
    
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
