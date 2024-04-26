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
    @IBOutlet weak var collVw: UICollectionView!
    //MARK: - VARIABELS
    private var clusterManager: GMUClusterManager!
    var latitude = Double()
    var longitude = Double()
    var locMarkers = [GMSMarker]()
    var nearBy = [NearbyRestaurant]()
    var tempNearBy = [NearbyRestaurant]()
    var iscomeFrom = Int()
    var selectedRestroId : Int?
    var locationMarker = GMSMarker()
    var selectedMarker: GMSMarker?
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collVw.isHidden = true
        collVw.delegate = self
        collVw.dataSource = self
       // mapView.delegate = self
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
            print(nearBy[selectedindex].name ?? "")
            
            if selectedMarker == marker {
                if let view = marker.iconView as? CustomMarker {
                    //view.detailVw.isHidden.toggle()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let itemDetailsVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                    itemDetailsVC.ProductID = self.nearBy[selectedindex].id ?? 0
                    self.navigationController?.pushViewController(itemDetailsVC, animated: true)
                    
                    
                }
            } else {
                if let prevSelectedMarker = selectedMarker, let prevView = prevSelectedMarker.iconView as? CustomMarker {
                    prevView.detailVw.isHidden = true
                }
                
                if let view = marker.iconView as? CustomMarker {
                    view.detailVw.isHidden = false
                }
                
                selectedMarker = marker
            }
        }
        return true
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
        self.clusterManager.cluster()
        self.clusterManager.setDelegate(self as GMUClusterManagerDelegate, mapDelegate: self)
        self.clusterManager.setDelegate(self, mapDelegate: self)
        self.clusterManager.setMapDelegate(self)
        setmarkers()
    }
    
    func setmarkers() {
        mapView.clear()
        mapView.isMyLocationEnabled = true
        clusterManager.clearItems()
        if self.nearBy.count != 0 {
            for i in 0..<(self.nearBy.count){
                let state_marker = GMSMarker()
                state_marker.position = checkIfMutlipleCoordinates(latitude: Float(Double(self.nearBy[i].latitude ?? "0.0") ?? 0.0), longitude: Float(Double(self.nearBy[i].longitude ?? "0.0") ?? 0.0))
                state_marker.map = self.mapView
                let customInfoWindow = Bundle.main.loadNibNamed("CustomMarker", owner: self, options: nil)![0] as! CustomMarker
                customInfoWindow.setupData(body: self.nearBy[i])
                let data = structName(lat: nearBy[i])
                state_marker.userData = data
                self.mapView.camera = GMSCameraPosition.camera(withTarget: state_marker.position, zoom: 18)
                self.mapView.animate(toZoom: 18)
                state_marker.iconView = customInfoWindow
                state_marker.zIndex = 50
                locMarkers.append(state_marker)
                clusterManager.add(state_marker)
            }
            clusterManager.cluster()
        }
        
    }
    func generatePOIItems(_ accessibilityLabel: String, position: CLLocationCoordinate2D, icon: UIImage?) {
        //        guard let item = POIItem(position: position, name: accessibilityLabel, icon: icon) else {
        //            return
        //        }
        //        self.clusterManager.add(item)
    }
}
extension mapViewController : GMUClusterRendererDelegate {
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        
        print("will render call")
        let val = (marker.userData as! GMUCluster)
//        for i in 0..<(self.nearBy.count){
//            
//      
//            let state_marker = GMSMarker()
//            let customInfoWindow = Bundle.main.loadNibNamed("CustomMarker", owner: self, options: nil)![0] as! CustomMarker
//            state_marker.position = CLLocationCoordinate2D(latitude: Double(
//                self.nearBy[i].latitude ?? "0.0") ?? 0.0, longitude:Double( self.nearBy[i].longitude ?? "0.0") ?? 0.0)
//           state_marker.iconView = customInfoWindow
//            customInfoWindow.restroImgVw.showIndicator(baseUrl: imageURL, imageUrl: self.nearBy[i].profileImage?.replacingOccurrences(of: " ", with: "%20") ?? "")
////            customInfoWindow.lblname.text = (self.nearBy[i].customer?.name ?? "")
////            customInfoWindow.lblreview.text = "\(self.arrayGetLocation[i].reviewCount ?? 0) Reviews"
////            customInfoWindow.LBLADDRESS.text = (self.arrayGetLocation[i].streetAddress ?? "")
//           
//        }
    }
    
    
    func allKeysForValue<K, V : Equatable>(dict: [K : V], val: V) -> [K] {
        return dict.filter{ $0.1 == val }.map{ $0.0 }
    }
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
        
        return true
    }
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
        return false
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
        cell.offerTimings = tempNearBy[indexPath.row].offer_timings
        cell.collVw.reloadData()
        cell.callBack = { [weak self] restId in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
            vc.ProductID = self?.tempNearBy[indexPath.row].id ?? 0
            vc.selectedOfferId = restId
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ItemDetailsVC") as! ItemDetailsVC
        vc.ProductID = self.tempNearBy[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collVw.frame.size.width, height: 130)
    }
    
}
