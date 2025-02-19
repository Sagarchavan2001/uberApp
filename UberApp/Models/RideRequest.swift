//
//  RideRequest.swift
//  UberApp
//
//  Created by STC on 01/01/25.
//

import Foundation
enum RideType: Int,CaseIterable,Identifiable{
    case uberX
    case black
    case uberXL
    var id : Int{return rawValue}
    var description:String{
        switch self{
        case .uberX: return "uber-black"
        case .black: return "uberXL"
        case .uberXL: return"Uber-X"
            
        }
        
    }
    var imageName : String{
        switch self{
        case .uberX: return "uber-black"
        case .black : return "UberXIcon"
        case .uberXL : return "uber-black"
        }
    }
    var baseFare : Double{
        switch self{
        case .uberX : return 10
        case .black : return 20
        case .uberXL : return 30
        }
    }
    func computePrice(for distanceInMeters : Double)->Double{
      let distanceInMiles = distanceInMeters / 1600
        switch self{
        case .uberX : return distanceInMiles * 1.5 + baseFare
        case .black : return distanceInMiles * 2.0 + baseFare
        case .uberXL : return distanceInMiles * 2.5 + baseFare
        }
    }
}
