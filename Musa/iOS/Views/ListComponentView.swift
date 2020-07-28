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
                .frame(width: 50, height: 50)
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