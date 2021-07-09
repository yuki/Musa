//
//  MiniPlayerView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 27/07/2020.
//

import SwiftUI
import MediaPlayer

struct MiniPlayerView: View {
    var body: some View {
        
        HStack {
            Image("cover")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            Text("Song Name asd qwe qwe qwe qwe qq weq weqwe ")
                .lineLimit(1)
                .frame(maxWidth:.infinity, alignment: .leading)
            Button(action: {(
                //Play song
                Musa.default.playPauseSong()
            )}) {
                Image(systemName:"play.fill")
            }
            Button(action: {(
                //Next song
            )}) {
                Image(systemName:"forward.fill")
            }
        }
        .padding(.all, 5)
    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerView()
            .previewLayout(.fixed(width: 300, height: 60.0))
        MiniPlayerView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 300, height: 60.0))
    }
}
