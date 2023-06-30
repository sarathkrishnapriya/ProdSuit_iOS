//
//  MapviewVC.swift
//  ProdSuit
//
//  Created by MacBook on 27/04/23.
//

import UIKit
import Combine
import GoogleMaps
import GooglePlaces
import CoreLocation


protocol LeadLocationDelegate:AnyObject{
    func getLeadLocation(location:String,coordinates:(lat: Double, lon: Double),vc:UIViewController)
}
class MapviewVC: UIViewController {
    
    var deviceLocationService = DeviceLocationService.Shared
    var coordinates: (lat: Double, lon: Double) = (0, 0)
    var isFetchLocation:Bool = true
    lazy var mapLocationCancellable = Set<AnyCancellable>()
    weak var locationDelegate : LeadLocationDelegate?
    var placesClient: GMSPlacesClient!
    fileprivate func mapStackShowHide(_ isVisible:Bool=false) {
        _ = self.mapStackView.subviews.map{ $0.isHidden = isVisible }
        self.mapStackView.isHidden = isVisible
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.mapStackView.layoutIfNeeded()
        }
    }
    
    var currentLocationText:String=""{
        didSet{
            if currentLocationText != ""{
                
                mapStackShowHide(false)
                
            }else{
                mapStackShowHide(true)
            }
        }
    }
    
//     lazy var mapView: GMSMapView = GMSMapView() {
//        didSet {
//            //you can config and customise your map here
//            self.mapView.delegate = self
//        }
//    }
    
   

    @IBOutlet weak var mapStackView: UIStackView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var gmsMapView: GMSMapView!{
                didSet {
                    //you can config and customise your map here
                    self.gmsMapView.delegate = self
                }
            }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
     
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        deviceLocationService.requestLocationUpdates()
        if isFetchLocation == true{
        locationCoordinateUpdates()
        deniedLocationAccess()
        }else{
            self.gmsMapCameraViewSetUp(self.coordinates)
        }
        
        
    }
    
   
    
  
    
    
    func locationCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
        
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .first()
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: {[unowned self] coordinate in
                
                self.coordinates = (coordinate.latitude, coordinate.longitude)
                self.gmsMapCameraViewSetUp(self.coordinates)
            }.store(in: &mapLocationCancellable)

    }
    
    func deniedLocationAccess(){
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Handle access denied event, possibly with an alert.")
                self.popupAlert(title: "Location Service", message: locationLoginMessage, actionTitles: [closeTitle], actions: [{action1 in
                    print("login location pop up closed")
                },nil])
            }
            .store(in: &mapLocationCancellable)
    }
    
    fileprivate func placemarkerMethod(_ coordinates: (lat: Double, lon: Double)) {
        
        
        let marker = GMSMarker.init()
        
        marker.position = CLLocationCoordinate2D(latitude: coordinates.lat, longitude: coordinates.lon)
        
        marker.title = self.currentLocationText
        
        marker.snippet = ""
        marker.map = self.gmsMapView
        
    }
    
    func gmsMapCameraViewSetUp(_ coordinates:(lat: Double, lon: Double)){
        
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.lat, longitude: coordinates.lon, zoom: 16)
       
        
        gmsMapView.camera = camera
        
        placesClient = GMSPlacesClient.shared()
        getAddressFromLocation(coordinates)
        
        
       
                
    }
    
    func getAddressFromLocation(_ coordinates:(lat: Double, lon: Double)){
        
        let placeFields: GMSPlaceField = [.name, .coordinate,.addressComponents]
        
        
        
        let geoCoder = GMSGeocoder()
        let location2D = CLLocationCoordinate2D.init(latitude: coordinates.lat, longitude: coordinates.lon)
        geoCoder.reverseGeocodeCoordinate(location2D) { response, error in
            if  let addressArray = response?.results() as? [GMSAddress]{
                print(addressArray)
                
                self.currentLocationText = self.displayLocationInfo(placemark: addressArray)
                self.locationLabel.text = self.currentLocationText
                self.placemarkerMethod(coordinates)
            }
            
        }
    
    }
    
    
    func displayLocationInfo(placemark: [GMSAddress]) -> String    {

           

           var adr: String  = ""

        let addressInfo = placemark[0]
           
        adr = addressInfo.lines![0]
        return adr
       }
    
    
    @IBAction func locationFetchButtonAction(_ sender: UIButton) {
        
        self.dismiss(animated: false) {
            
            
            self.locationDelegate?.getLeadLocation(location: self.currentLocationText,coordinates:self.coordinates,vc: self)
            
            
            
            DispatchQueue.main.async {
                self.deviceLocationService.locationManager.stopUpdatingLocation()
                self.deviceLocationService.locationManager.delegate = nil
                
                

            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.deviceLocationService.locationManager.delegate = nil
        self.deviceLocationService.locationManager.stopUpdatingHeading()
        self.mapLocationCancellable.dispose()
        self.gmsMapView = GMSMapView()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
         print("receive memory waring map vc")
    }
    
    
    deinit{
        
        
        print("gms mapview deallocated")
        self.gmsMapView = GMSMapView()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapviewVC:GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: coordinates.lat, longitude: coordinates.lon)
//        marker.title = currentLocationText
//        marker.snippet = ""
//        marker.map = mapView
    }
}
