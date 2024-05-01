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
    func customMarkerDidTapDetailView(_ marker: CustomMarker) {
        print("88888888888")
    }
    
    
    //MARK: - OUTLETS
    @IBOutlet weak var mapView: GMSMapView!

    //MARK: - VARIABELS
    private var clusterManager: GMUClusterManager!
    private var clusterItem : [GMUClusterItem]!
    var latitude = Double()
    var longitude = Double()
    var locMarkers = [GMSMarker]()
    var nearBy = [NearbyRestaurant]()
    var tempNearBy = [NearbyRestaurant]()
    var iscomeFrom = Int()
    var selectedRestroId : Int?
    var locationMarker = GMSMarker()
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
        } else if let selectedindex = locMarkers.firstIndex(of: marker) {
            marker.tracksInfoWindowChanges = true
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
        let algorithm =  GMUNonHierarchicalDistanceBasedAlgorithm()
        //GMUGridBasedClusterAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        self.clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        renderer.minimumClusterSize = 4
       // renderer.maximumClusterZoom = 4
        //self.clusterManager.cluster()
       // self.clusterManager.setDelegate(self as GMUClusterManagerDelegate, mapDelegate: self)
        self.clusterManager.setDelegate(self, mapDelegate: self)
        self.clusterManager.setMapDelegate(self)
        setMarkers()
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
                
                var offsetLat = lat
                var offsetLng = lng
                
                // Add small random offset to avoid overlapping markers
                let offset = 0.0001
                offsetLat += Double.random(in: -offset...offset)
                offsetLng += Double.random(in: -offset...offset)
                
                let state_marker = GMSMarker()
                state_marker.position = CLLocationCoordinate2D(latitude: offsetLat, longitude: offsetLng)
                
                state_marker.map = mapView
                
                let customInfoWindow = Bundle.main.loadNibNamed("CustomMarker", owner: self, options: nil)?[0] as? CustomMarker
                customInfoWindow?.setupData(body: nearBy[i])
                state_marker.iconView = customInfoWindow
                state_marker.zIndex = 50
                
                let data = structName(lat: nearBy[i])
                state_marker.userData = data
                
                locMarkers.append(state_marker)
                let newData = MapItem(position: state_marker.position, data: nearBy[i])
                items.append(newData)
//                let clusterItem = GMUStaticCluster(item: state_marker)
                clusterManager.add(newData)
               
            }
        
            
            clusterManager.cluster()
            
            // Move camera to the first marker
            if let firstMarker = nearBy.first, let lat = Double(firstMarker.latitude ?? "0.0"), let lng = Double(firstMarker.longitude ?? "0.0") {
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 20)
                mapView.animate(to: camera)
            }
        }
    }


    func generatePOIItems(_ accessibilityLabel: String, position: CLLocationCoordinate2D, icon: UIImage?) {
      
    }
}
extension mapViewController : GMUClusterRendererDelegate {
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        print("will render call")
    }
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
        
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
            vc.modalPresentationStyle = .pageSheet
            
            if #available(iOS 15.0, *) {
                if let sheet = vc.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.selectedDetentIdentifier = .medium
                    //sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                }
            } else {
                // Fallback on earlier versions
            }
            
            self.present(vc, animated: true)
            
            
        }else {
            print("Something went wrong")
        }
  
        
//        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
//                                                        zoom: mapView.camera.zoom + 1)
//               let update = GMSCameraUpdate.setCamera(newCamera)
//               mapView.moveCamera(update)

        return true
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

//    func setmarkers() {
//        mapView.clear()
//        mapView.isMyLocationEnabled = true
//        clusterManager.clearItems()
//        if self.nearBy.count != 0 {
//
//            for i in 0..<(self.nearBy.count) {
//                let state_marker = GMSMarker()
//                state_marker.position = checkIfMutlipleCoordinates(latitude: Float(Double(self.nearBy[i].latitude ?? "0.0") ?? 0.0), longitude: Float(Double(self.nearBy[i].longitude ?? "0.0") ?? 0.0))
//                state_marker.map = self.mapView
//                let customInfoWindow = Bundle.main.loadNibNamed("CustomMarker", owner: self, options: nil)![0] as! CustomMarker
//                customInfoWindow.setupData(body: self.nearBy[i])
//                let data = structName(lat: nearBy[i])
//                state_marker.userData = data
//
//                state_marker.iconView = customInfoWindow
//                state_marker.zIndex = 50
//                locMarkers.append(state_marker)
//                clusterManager.add(state_marker)
//            }
//
//            clusterManager.cluster()
//        }
//
//        if self.nearBy.count > 0 {
//            let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees((Double(self.nearBy[0].latitude ?? "0.0") ?? 0.0)), longitude: CLLocationDegrees((Double(self.nearBy[0].longitude ?? "0.0") ?? 0.0) ), zoom: 20)
//            self.mapView.animate(to: camera)
//        }
//
//
//    }
class MapItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var data: NearbyRestaurant?
    
    init(position: CLLocationCoordinate2D, data: NearbyRestaurant) {
        self.position = position
        self.data = data
    }
}



