//
//  Start&endLocationSearchView.swift
//  UberApp
//
//  Created by STC on 23/12/24.
//

import SwiftUI

struct Start_endLocationSearchView: View {
    @State private var startLocationText = ""
   
    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel : LocationSearchVM
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Circle().fill(Color(.red)).frame(width: 6,height: 6)
                    Rectangle().fill(Color(.red)).frame(width: 1,height: 40)
                    Rectangle().fill(Color(.green)).frame(width: 6,height: 6)
                }.padding(10)
                VStack{
                    TextField("Current Location",text: $viewModel.queryFragment).frame(height: 32).background(Color(.secondarySystemBackground)).padding(.trailing)
                    TextField("Distination Location",text: $viewModel.queryFragment).frame(height: 32).background(Color(.secondarySystemGroupedBackground)).padding(.trailing)
                }
                
            }
            .padding(.top,100)
            Divider()
         //List View
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.results, id:\.self ){ result in
                        LocationSearchCellView(title: result.title, subTitle: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    viewModel.selectLocation(result)

                                    mapState = .locationSelected
                                }
                            }
                    }
                }
            }
        }.background(.white)
    }
}

struct Start_endLocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        Start_endLocationSearchView(mapState: .constant(.serchingForLocation)).environmentObject(LocationSearchVM())
    }
}
