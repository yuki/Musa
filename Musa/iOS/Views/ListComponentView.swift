//
//  ListComponentView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 27/07/2020.
//

import SwiftUI

struct ListComponentView: View {
    var body: some View {
        HStack {
            Image("Cover")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
            Text("01")
            Text("Song Name")
            Spacer()
        }
    }
}

struct ListComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ListComponentView()
            .previewLayout(.fixed(width: 300, height: 60.0))
    }
}
