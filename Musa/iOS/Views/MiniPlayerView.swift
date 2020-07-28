//
//  MiniPlayerView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 27/07/2020.
//

import SwiftUI

struct MiniPlayerView: View {
    var body: some View {
        
        HStack {
            Image("Cover")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            Text("Song Name")
            Spacer()
            Image("Play")
            Image("Next")
        }
//        .padding(.all, 5)
    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerView()
            .previewLayout(.fixed(width: 300, height: 60.0))
    }
}
