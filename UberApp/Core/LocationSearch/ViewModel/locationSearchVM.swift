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
    @Published var selectLocationCoordinate : CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment : String = ""{
        didSet{
            searchCompleter.queryFragment = queryFragment
        }
    }
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
            self.selectLocationCoordinate = Coordinate
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
}
extension LocationSearchVM: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
