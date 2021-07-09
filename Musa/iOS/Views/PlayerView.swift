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
            VStack{
                Image(systemName: "chevron.compact.down").font(.title).padding([.bottom],5)
                Image("cover")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
            }
            .frame(maxWidth:.infinity, maxHeight:.infinity)
            
            VStack {
                HStack{
                    Text("0:00")
                    ProgressView(value: 0.2)
                    Text("1:00")
                }
                .padding(.top)
                VStack {
                    Text("Song Title")
                        .lineLimit(2)
                        .font(.title)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity)
                    Text("Artist")
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth:.infinity, maxHeight:.infinity)
                
                HStack(spacing: 50.0){
                    Image(systemName: "backward.fill")
                    Image(systemName: "play.fill")
                    Image(systemName: "forward.fill")
                }
                .padding(.horizontal)
                .font(.largeTitle)
                .frame(maxWidth:.infinity, maxHeight:.infinity)
                
                HStack{
                    Image(systemName: "speaker.fill")
                    Slider(
                        value: $time,
                        in: 0...100,
                        step: 1
                    )
                    Image(systemName: "speaker.wave.2.fill")
                }

                HStack{
                    Image(systemName: "shuffle")
                    Spacer()
                    Image(systemName: "repeat")
                }
                .padding(.top)
                .font(.title)
            }
            .frame(maxWidth:.infinity, maxHeight:.infinity)
            .fixedSize(horizontal: false, vertical: false)
        }
        .statusBar(hidden: true)
        .padding(10.0)
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
