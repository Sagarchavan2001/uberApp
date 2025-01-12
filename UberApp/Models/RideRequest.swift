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
}
