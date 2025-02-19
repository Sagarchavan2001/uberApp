//
//  HomeView.swift
//  UberApp
//
//  Created by STC on 22/12/24.
//

import SwiftUI

struct HomeView: View {

    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel : LocationSearchVM
    var body: some View {
        ZStack (alignment: .bottom){
            ZStack(alignment: .top){
                UberMapViewRepresentable(mapstate: $mapState).ignoresSafeArea()
                MapViewActionButton(mapState: $mapState).padding(.leading,10).padding(.top,40)
                
                if mapState == .serchingForLocation{
                    Start_endLocationSearchView(mapState: $mapState)
                    
                    
                }else if mapState == .noInput{
                    LocationSearchView().padding(100).onTapGesture {
                        withAnimation(.spring()){
                            mapState = .serchingForLocation
                        }
                    }
                }
                
             
                
            }
            if mapState == .locationSelected{
                rideRequestView().transition(.move(edge: .bottom))
            }
        }.padding(.bottom,16).ignoresSafeArea()
            .onReceive(LocationManager.shared.$userLocation) { location  in
                if let location = location{
                    locationViewModel.userLocation = location
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
