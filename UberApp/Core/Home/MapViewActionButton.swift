//
//  MapViewActionButton.swift
//  UberApp
//
//  Created by STC on 23/12/24.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel : LocationSearchVM
    var body: some View {
        Button{
            withAnimation(.spring()){
                actionForState(mapState)
            }
            
        }  label: {
            Image(systemName:imageForState(mapState)).font(.title2).foregroundColor(.black).padding().background(.white).clipShape(Circle()).shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    func actionForState(_ state: MapViewState){
        switch state{
        case .noInput: print("DEBUG : NO INPUT")
        case .serchingForLocation: mapState = .noInput
            viewModel.selectedCoordinateLocation = nil
        case .locationSelected: mapState = .noInput
        }
    }
    func imageForState(_ state : MapViewState)-> String{
        switch state{
        case .noInput:
            return "line.horizontal.3"
        case .serchingForLocation, .locationSelected:
        return "arrow.left"
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
