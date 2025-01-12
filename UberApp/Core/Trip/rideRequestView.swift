//
//  rideRequestView.swift
//  UberApp
//
//  Created by STC on 30/12/24.
//

import SwiftUI

struct rideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    var body: some View {
      
            VStack(){
                Capsule().foregroundColor(Color(.systemGray)).frame(width: 48,height: 6)
                //trip info
                HStack{
                    VStack{
                        Circle().fill(Color(.systemGray)).frame(width: 8,height: 8)
                        Rectangle().fill(Color(.gray)).frame(width: 1,height: 38)
                        Rectangle().fill(Color(.black)).frame(width: 8,height: 8)
                    }
                    VStack(alignment:.leading,spacing:24){
                        HStack{
                            Text("Current Location").font(.system(size: 16,weight: .semibold)).foregroundColor(.gray)
                            Spacer()
                            Text("01:34 AM").font(.system(size: 14,weight: .semibold)).foregroundColor(.gray)
                        }
                        .padding(.bottom,10)
                        HStack{
                            Text("cofee shoop").font(.system(size: 16,weight: .semibold))
                            Spacer()
                            Text("01:54 AM").font(.system(size: 14,weight: .semibold)).foregroundColor(.gray)
                        }
                        
                    }.padding(.leading,8)
                }
                .padding()
                Divider()
                
                //ride type selection view
                Text("SUGGESTED RIDES").font(.subheadline).fontWeight(.semibold).padding().foregroundColor(.gray).frame(maxWidth: .infinity,alignment: .leading)
                ScrollView(.horizontal){
                    HStack(spacing:12){
                        ForEach(RideType.allCases){
                            rideType in
                            VStack(spacing: 8){
                                Image(rideType.imageName).resizable().scaledToFit()
                                Text(rideType.description).font(.system(size: 14,weight: .semibold))
                                Text("$23").font(.system(size: 14,weight: .semibold))
                            }
                            .padding(8)
                            .frame(width: 112,height: 140).foregroundColor(Color(rideType == selectedRideType ? .white : .black)).background(Color(rideType == selectedRideType ? .systemRed : .systemGroupedBackground
                                                                                                                                                  )).scaleEffect(rideType == selectedRideType ? 1.25 : 1.0).cornerRadius(10)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedRideType = rideType
                                    }
                                }
                            
                        }
                    }
                    
                }.padding(.horizontal)
                // payment View....
             
                HStack(spacing:12){
                    Text("Visa").font(.subheadline).fontWeight(.semibold).padding(6).background(.red).cornerRadius(4).foregroundColor(.white).padding(.leading)
                    Text("**** 2177").fontWeight(.bold)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .frame(height: 50).background(Color(.systemGroupedBackground)).cornerRadius(10).padding(.horizontal)
            //request Button
                Button{
                    
                }label: {
                    Text("CONFIRM RIDE").fontWeight(.bold).frame(width: UIScreen.main.bounds.width - 32,height: 50).background(Color(.red)).cornerRadius(10).foregroundColor(Color(.white))
                }
            }.background(Color(.white)).cornerRadius(10)   }
    }


struct rideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        rideRequestView().ignoresSafeArea()
    }
}
