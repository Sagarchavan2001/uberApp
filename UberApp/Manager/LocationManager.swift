//
//  LocationManager.swift
//  UberApp
//
//  Created by STC on 22/12/24.
//

import CoreLocation
class LocationManager : NSObject,ObservableObject{
    private let loacationManager = CLLocationManager()
    static let shared  = LocationManager()
    @Published var userLocation : CLLocationCoordinate2D?
    override init() {
        super.init()
        loacationManager.delegate = self
        loacationManager.desiredAccuracy = kCLLocationAccuracyBest
        loacationManager.requestWhenInUseAuthorization()
        loacationManager.startUpdatingLocation()
    }
}
extension LocationManager : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        self.userLocation  = location.coordinate
        loacationManager.stopUpdatingLocation()
    }
}
