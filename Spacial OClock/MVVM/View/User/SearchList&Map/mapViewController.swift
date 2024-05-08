//
//  mapViewController.swift
//  Spacial OClock
//
//  Created by cqlios on 17/10/23.
//

import UIKit
import GooglePlaces
import GoogleMaps
import GoogleMapsUtils

struct structName:Codable {
    var lat: NearbyRestaurant?
}

class mapViewController: UIViewController, GMSMapViewDelegate  {
        
    //MARK: - OUTLETS
    @IBOutlet weak var mapView: GMSMapView!

    //MARK: - VARIABELS
    private var clusterManager: GMUClusterManager!
    
    var latitude = Double()
    var longitude = Double()
    var locMarkers = [GMSMarker]()
    var nearBy = [NearbyRestaurant]()
    var tempNearBy = [NearbyRestaurant]()
    var iscomeFrom = Int()
    var selectedMarker: GMSMarker?
    var items: [MapItem] = []
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        if iscomeFrom == 0 {
            setLocation()
        } else {
            initializeClusterItems()
        }
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
    
   
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if iscomeFrom == 0 {
        } 
        print("3")
        //else if let selectedindex = locMarkers.firstIndex(of: marker) {
            marker.tracksInfoWindowChanges = true
                if selectedMarker == marker {
                    mapView.selectedMarker = nil
                    selectedMarker = nil
                } else {
                    mapView.selectedMarker = marker
                    selectedMarker = marker
                }
 
            return true
        }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if let selectedindex = locMarkers.firstIndex(of: marker) {
            let customInfoWindow = Bundle.main.loadNibNamed("WindowForMap", owner: self, options: nil)![0] as! WindowForMap
            customInfoWindow.setupData(body: self.nearBy[selectedindex])
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 1.9)
            return customInfoWindow
        }
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let selectedindex = locMarkers.firstIndex(of: marker) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let itemDetailsVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            itemDetailsVC.ProductID = self.nearBy[selectedindex].id ?? 0
            self.navigationController?.pushViewController(itemDetailsVC, animated: true)
        }
    }
  
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


    
extension mapViewController: GMUClusterManagerDelegate {
    
    func initializeClusterItems()
    {
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        self.clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        renderer.minimumClusterSize = 2
        renderer.maximumClusterZoom = 16
        self.clusterManager.setDelegate(self, mapDelegate: self)
        self.clusterManager.setMapDelegate(self)
        setMarkers()
        self.clusterManager.cluster()
    }
    
    func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
    }
    
    func setMarkers() {
        mapView.clear()
        mapView.isMyLocationEnabled = true
        clusterManager.clearItems()
        
        if !nearBy.isEmpty {
            for i in 0..<nearBy.count {
                guard let lat = Double(nearBy[i].latitude ?? "0.0"),
                      let lng = Double(nearBy[i].longitude ?? "0.0") else {
                    continue
                }
                
                let offset = 0.0001
                let offsetLat = lat + Double.random(in: -offset...offset)
                let offsetLng = lng + Double.random(in: -offset...offset)
                
                let state_marker = GMSMarker()
               
                let position =  CLLocationCoordinate2D(latitude: offsetLat, longitude: offsetLng)
               // state_marker.position = position
               // state_marker.map = mapView
                
//                let customInfoWindow = Bundle.main.loadNibNamed("CustomMarker", owner: self, options: nil)?[0] as? CustomMarker
//                customInfoWindow?.setupData(body: nearBy[i])
//                state_marker.iconView = customInfoWindow
                state_marker.zIndex = 50
                let data =  structName(lat: nearBy[i])
                //state_marker.userData = data
                locMarkers.append(state_marker)
                let newData = MapItem(position: position, data: nearBy[i])
                items.append(newData)
                clusterManager.add(newData)
               
            }
            clusterManager.cluster()
            if let firstMarker = nearBy.first, let lat = Double(firstMarker.latitude ?? "0.0"), let lng = Double(firstMarker.longitude ?? "0.0") {
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 30)
                mapView.animate(to: camera)
            }
        }
    }


   
}
extension mapViewController : GMUClusterRendererDelegate {
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        print("will render call")
    }
    
    func renderer(_ renderer: GMUClusterRenderer, markerFor object: Any) -> GMSMarker? {
        switch object {
        case let item as MapItem:
            let marker = GMSMarker()
            marker.position = item.position
            let customInfoWindow = Bundle.main.loadNibNamed("CustomMarker", owner: self, options: nil)?[0] as? CustomMarker
            customInfoWindow?.setupData(body:item.data)
            marker.zIndex = 50
            marker.iconView = customInfoWindow
            marker.isTappable = true
            marker.userData = item.data
            marker.map = mapView
            return marker
            
        default:
            return nil
        }
    }
    
    
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
       
        
        if let item = clusterItem as? MapItem {
            // Create a marker for the cluster item
            let marker = GMSMarker(position: item.position)
            marker.map = mapView
            
            if selectedMarker == marker {
                mapView.selectedMarker = nil
                selectedMarker = nil
            } else {
                mapView.selectedMarker = marker
                selectedMarker = marker
            }
        }
        
        return true
    }

    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        
        var newBody = [NearbyRestaurant]()
        if let items = cluster.items as? [MapItem] {
            for item in items {
                if let itemData = item.data {
                    newBody.append(itemData)
                }
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ClusterResultVC") as! ClusterResultVC
            vc.nearByBody = newBody
            vc.callBack = { [weak self] databody in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let itemDetailsVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                itemDetailsVC.ProductID = databody?.id ?? 0
                self?.navigationController?.pushViewController(itemDetailsVC, animated: true)
        }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
            
        }else {
            print("Something went wrong")
        }
  
        
//        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
//                                                        zoom: mapView.camera.zoom + 1)
//               let update = GMSCameraUpdate.setCamera(newCamera)
//               mapView.moveCamera(update)

        return false
    }
}
extension mapViewController{
    func checkIfMutlipleCoordinates(latitude : Float , longitude : Float) -> CLLocationCoordinate2D{
        var lat = latitude
        var lng = longitude
        let arrTemp = self.nearBy.filter {
            return (((latitude == Float($0.latitude ?? "")) && (longitude == Float($0.longitude ?? ""))))
        }
        if (arrTemp.count ) > 1{
            let variation = (randomFloat(min: 0.0, max: 1.0) - 0.5) / 1000
            lat = lat + variation
            lng = lng + variation
            let finalPos = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
            return  finalPos
        }else{
            let variation = (randomFloat(min: 0.0, max: 1.0) - 0.5) / 1000
            lat = lat + variation
            lng = lng + variation
            let finalPos = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
            return  finalPos
        }
        
    }
    
    func randomFloat(min: Float, max:Float) -> Float {
        return (Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }
}


class MapItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var data: NearbyRestaurant?
    
    init(position: CLLocationCoordinate2D, data: NearbyRestaurant) {
        self.position = position
        self.data = data
    }
}



