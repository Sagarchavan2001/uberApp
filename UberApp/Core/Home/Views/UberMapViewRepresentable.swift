//
//  UberMapViewRepresentable.swift
//  UberApp
//
//  Created by STC on 22/12/24.
//

import SwiftUI
import MapKit
struct UberMapViewRepresentable : UIViewRepresentable{
   let mapView = MKMapView()
    //let locationManager = LocationManager.shared
    @Binding var  mapstate:MapViewState
    @EnvironmentObject var locationViewModel : LocationSearchVM
    
    func makeUIView(context: Context) -> some UIView {
        
        mapView.delegate = context.coordinator
        
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Debug : \(mapstate)")
        switch mapstate{
        case .noInput: context.coordinator.clearMapViewAndRecenterUserLocation()
        case .locationSelected:
            break
        case .serchingForLocation:
            if let coordinate = locationViewModel.selectedCoordinateLocation?.coordinate{
                
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configPolyline(withDestinationCoordinat: coordinate)
            }
            break
        }
    }
    func makeCoordinator() -> MapCoordinater {
        return MapCoordinater(parent: self)
    }
}
extension UberMapViewRepresentable{
    class MapCoordinater: NSObject,MKMapViewDelegate{
        let parent : UberMapViewRepresentable
        var userLocationCoordinate : CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        //MARK :- LifeCycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
          
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        // MARK : Helpers
        func addAndSelectAnnotation(withCoordinate  Coordinate : CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = Coordinate
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        func configPolyline(withDestinationCoordinat coordinate : CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
       
        func clearMapViewAndRecenterUserLocation(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let currentRegion = currentRegion{
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }

    
}
