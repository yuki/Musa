//
//  ListComponentView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 27/07/2020.
//

import SwiftUI
import MediaPlayer

struct ListComponentView: View {
    let song: MPMediaItem
    let origin: String
    
    var body: some View {
        HStack {
            if (origin == "Songs"){
                Image("cover")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
                Text("\(song.albumTrackNumber)")
            }
            Text(song.title ?? "Song name")
            Spacer()
        }.previewLayout(.fixed(width: .infinity, height: 60))
    }
}

struct ListComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ListComponentView(song: MPMediaItem(),origin: "song")
            .previewLayout(.fixed(width: 300, height: 60.0))
        ListComponentView(song: MPMediaItem(),origin: "song")
            .previewLayout(.fixed(width: 300, height: 60.0)).preferredColorScheme(.dark)
    }
}
