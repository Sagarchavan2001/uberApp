//
//  Double.swift
//  UberApp
//
//  Created by STC on 18/02/25.
//

import Foundation
extension Double{
    private var currencyFormatter : NumberFormatter{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumIntegerDigits = 2
        return formatter
    }
    func toCurrency()-> String{
        return currencyFormatter.string(for: self) ?? ""
    }
}
