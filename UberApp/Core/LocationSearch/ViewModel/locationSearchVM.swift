//
//  locationSearchVM.swift
//  UberApp
//
//  Created by STC on 28/12/24.
//

import Foundation
import MapKit
class LocationSearchVM : NSObject,ObservableObject{
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedCoordinateLocation : uberlocation?
    @Published var pickUpTime : String?
    @Published var dropOutTime : String?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment : String = ""{
        didSet{
            searchCompleter.queryFragment = queryFragment
        }
    }
    var userLocation : CLLocationCoordinate2D?
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    //Mark : - Helpers
    func selectLocation(_ localSearch : MKLocalSearchCompletion){
        locationsearch(forLocaldsearchCompletion: localSearch) { responce, error in
            if let error = error{
                print("DEBUG :Location search Fail error :  \(error) ")
                return
            }
            guard let item = responce?.mapItems.first else {return}
            let Coordinate = item.placemark.coordinate
            self.selectedCoordinateLocation = uberlocation(title: localSearch.title, coordinate: Coordinate)
            print("DEBUG : \(Coordinate)")
        }
    }
    func locationsearch(forLocaldsearchCompletion localsearch : MKLocalSearchCompletion, completion : @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localsearch.title.appending(localsearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion
        )
    }
    func computeRidePrice(forType type:RideType)-> Double{
        guard let distcoordinate = selectedCoordinateLocation?.coordinate else { return 0.0}
        guard let usercoordinate = self.userLocation else { return 0.0}
        let userLocation = CLLocation(latitude: usercoordinate.latitude, longitude: usercoordinate.longitude)
        let distination = CLLocation(latitude: distcoordinate.latitude, longitude: distcoordinate.longitude)
        let tripdistanceInMeters = userLocation.distance(from: distination)
        return type.computePrice(for: tripdistanceInMeters)
    }
    func getDestinationRoute(from userlocation : CLLocationCoordinate2D,to destination : CLLocationCoordinate2D, completion: @escaping(MKRoute)-> Void){
        let userPlaceMark = MKPlacemark(coordinate: userlocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlaceMark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let route = response?.routes.first else{return}
            self.configurePickUpAndDropUpTime(with: route.expectedTravelTime)
            completion(route)
        }
    }
    func configurePickUpAndDropUpTime(with expectedTravelTime : Double){
       let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:aa"
        pickUpTime = formatter.string(from: Date())
        dropOutTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
}
extension LocationSearchVM: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
