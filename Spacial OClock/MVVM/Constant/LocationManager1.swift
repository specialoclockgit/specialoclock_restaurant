//
//  LocationManager.swift
//  MaidFinder
//
//  Created by Mac_Mini17 on 27/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//
import UIKit
import CoreLocation

class LocationData1 {
    var currentLat  : Double?
    var currentLong : Double?
    var device_id   : String?
}

var objLocationData = LocationData1()

class LocationManager1:NSObject,CLLocationManagerDelegate {
    
    static let sharedInstance:LocationManager1 = {
        let instance = LocationManager1()
        return instance
    }()
    
   var locationManager:CLLocationManager!
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
//        debugPrint("user latitude = \(userLocation.coordinate.latitude)")
//        debugPrint("user longitude = \(userLocation.coordinate.longitude)")
        objLocationData.currentLat = userLocation.coordinate.latitude
        objLocationData.currentLong = userLocation.coordinate.longitude
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // The user denied authorization
        } else if (status == CLAuthorizationStatus.authorizedAlways) || (status == CLAuthorizationStatus.authorizedWhenInUse) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                NotificationCenter.default.post(name: Notification.Name("UpdateLocation"), object: nil)
            }
            // The user accepted authorization
        }
    }
    
    func locationManager(_ manager:CLLocationManager, didFailWithError error:Error){
        print("Error \(error)")
    }
}
