//
//  LocationSearchView.swift
//  UberApp
//
//  Created by STC on 23/12/24.
//

import SwiftUI

struct LocationSearchView: View {
    var body: some View {
        HStack{
                       Image(systemName: "magnifyingglass")
                           .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original)).foregroundColor(.green)
                           .padding(.leading,30)
                  
            Text("Where To Go?").foregroundColor(Color(.darkGray))
           Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64,height: 50)
        .background( RoundedRectangle(cornerRadius: 25)
            .fill(.white).shadow(radius: 5))
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
