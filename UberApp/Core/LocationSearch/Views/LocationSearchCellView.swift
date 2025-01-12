//
//  LocationSearchCellView.swift
//  UberApp
//
//  Created by STC on 23/12/24.
//

import SwiftUI

struct LocationSearchCellView: View {
    let title : String
    let subTitle:String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill").resizable()
                .foregroundColor(.red)
                .accentColor(.white)
                .frame(width: 40,height: 40)
            VStack(alignment: .leading,spacing: 4){
                Text(title)
                    .font(.body).foregroundColor(.black)
                Text(subTitle).font(.system(size: 15)).foregroundColor(.gray)
                Divider()
            }
            .padding(.leading,8)
            .padding(.vertical,8)
            
        }
        .padding(.leading)
    }
}

struct LocationSearchCellView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchCellView(title: "sAc Cafe", subTitle: "Dattwadi 1234")
    }
}
