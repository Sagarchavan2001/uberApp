//
//  LocationManager.swift
//  UberApp
//
//  Created by STC on 22/12/24.
//

import CoreLocation
class LocationManager : NSObject,ObservableObject{
    private let loacationManager = CLLocationManager()
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
        guard !locations.isEmpty else {return}
        loacationManager.stopUpdatingLocation()
    }
}
