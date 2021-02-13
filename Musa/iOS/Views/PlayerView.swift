//
//  PlayerView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 27/07/2020.
//

import SwiftUI

struct PlayerView: View {
    @State private var time: Double = 50
    
    var body: some View {
        VStack {
            Image("cover")
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
            Image("cover")
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
//            VStack {
//                HStack{
//                    Text("0:00")
//                    ProgressView(value: 0.2)
//                    VStack {
//
//                        Spacer()
//                    }
//                    Text("1:00")
//                }
//                .fixedSize(horizontal: false, vertical: true)
//                Text("Song Title")
//                    .font(.title)
//                Text("Artist")
//                    .foregroundColor(Color.blue)
//                HStack{
//                    Spacer()
//                    Image(systemName: "backward.fill")
//                    Spacer()
//                    Image(systemName: "play.fill")
//                    Spacer()
//                    Image(systemName: "forward.fill")
//                    Spacer()
//                }
//                HStack{
//                    Image(systemName: "speaker.fill")
//                    Slider(
//                        value: $time,
//                        in: 0...100,
//                        step: 1
//                    )
//                    Image(systemName: "speaker.wave.2.fill")
//                }
//                HStack{
//                    Image(systemName: "shuffle")
//                    Spacer()
//                    Image(systemName: "repeat")
//                }
//            }
//            .fixedSize(horizontal: false, vertical: false)
        }
        .statusBar(hidden: true)
//        .padding(10.0)
        
        
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerView()
            PlayerView().preferredColorScheme(.dark)
                
        }
    }
}
