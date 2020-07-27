//
//  MiniView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 27/07/2020.
//

import SwiftUI

struct MiniView: View {
    var body: some View {
        
        HStack {
            Image("Cover")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
            Text("Song Name")
            Spacer()
            Image("Play")
            Image("Next")
        }
    }
}

struct MiniView_Previews: PreviewProvider {
    static var previews: some View {
        MiniView()
            .previewLayout(.fixed(width: 300, height: 60.0))
    }
}
