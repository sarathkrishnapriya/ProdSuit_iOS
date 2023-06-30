//
//  LocationServices.swift
//  ProdSuit
//
//  Created by MacBook on 02/03/23.
//


import CoreLocation
import Combine
import GoogleMaps
import GooglePlaces



class DeviceLocationService:NSObject,CLLocationManagerDelegate{
    
    
    
    var coordinatesPublisher = PassthroughSubject<CLLocationCoordinate2D,Error>()
    var deniedLocationAccessPublisher = PassthroughSubject<Void,Never>()
    
    
    
    private override init() {
        super.init()
    }
    

    static let Shared = DeviceLocationService()
    
    lazy var locationManager : CLLocationManager = {
           let manager = CLLocationManager()
              // manager.startMonitoringSignificantLocationChanges()
               manager.desiredAccuracy = kCLLocationAccuracyBest
               manager.distanceFilter = kCLDistanceFilterNone
              
               manager.delegate = self
              
               return manager
    }()
    
    func requestLocationUpdates() {
            switch locationAuthorizationStatus(manger:locationManager){
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                
            case .authorizedWhenInUse, .authorizedAlways:
                
                locationManager.startUpdatingLocation()
                
            default:
                deniedLocationAccessPublisher.send()
            }
        }
    
    func locationAuthorizationStatus(manger:CLLocationManager) -> CLAuthorizationStatus {
        
        var locationAuthorizationStatus : CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            locationAuthorizationStatus =  manger.authorizationStatus
        } else {
            // Fallback on earlier versions
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        return locationAuthorizationStatus
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         switch locationAuthorizationStatus(manger:manager) {
             
         case .authorizedWhenInUse, .authorizedAlways:
             manager.startUpdatingLocation()
             
         default:
             manager.stopUpdatingLocation()
             deniedLocationAccessPublisher.send()
         }
     }

     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         
         manager.desiredAccuracy = 500
         guard let location = locations.last else { return }
         coordinatesPublisher.send(location.coordinate)
         //locationManager.stopUpdatingLocation()
     }
     
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         coordinatesPublisher.send(completion: .failure(error))
     }
    
    

}

struct LocationFetchViewModel
{
    var deviceLoctionService = DeviceLocationService.Shared
    lazy var locationServiceToken = Set<AnyCancellable>()
    
    init(service:DeviceLocationService){
        deviceLoctionService = service
        deviceLoctionService.requestLocationUpdates()
    
        
    }
    
    mutating func locationCoordinateUpdates(vc:UIViewController,_ completionHandler:@escaping ((CLLocationCoordinate2D) -> Void)){
        
        deviceLoctionService.coordinatesPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink { locationError in
                if let loc_error = locationError as? Error{
                    print(loc_error.localizedDescription)
                }
//                vc.popupAlert(title: "", message: loc_error.localizedDescription, actionTitles: [okTitle], actions: [{action1 in },nil])
                
            } receiveValue: { coordinates in
                
                
                    completionHandler(coordinates)
            
            }.store(in: &locationServiceToken)

          
            
        
    }
    
    mutating func deniedLocationAccess(_ completionHandler:@escaping ((String) -> Void)){
        deviceLoctionService.deniedLocationAccessPublisher
            .sink {
                print("Handle access denied event, possibly with an alert.")
                completionHandler(locationLoginMessage)
       }.store(in: &locationServiceToken)
    }
    
    
   mutating func getAddress(location:(lat: Double, lon: Double),handler: @escaping (String) -> Void)
    {
        var address: String = ""
        
        
        let latitude = location.lat
        let longitude = location.lon
    
        //selectedLat and selectedLon are double values set by the app in a previous process
        let geoCoder = GMSGeocoder()
        let location2D = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeCoordinate(location2D) { response, error in
            if  let addressArray = response?.results() as? [GMSAddress]{
                print(addressArray)
                
              

             let addressInfo = addressArray[0]
                address = addressInfo.lines![0]
            
                handler(address)
            }}
        
    }
}


