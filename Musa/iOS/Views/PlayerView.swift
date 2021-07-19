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
                Image("cover")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
            }
            .frame(maxWidth:.infinity, maxHeight:.infinity)
            .padding([.top],25)
            
            VStack {
                HStack{
                    Text("0:00")
                    ProgressView(value: 0.2)
                    Text("1:00")
                }
                .padding(.top)
                VStack {
                    Text("Song Title")
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .font(.largeTitle)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity)
                    Text("Artist")
                        .font(.title2)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth:.infinity, maxHeight:.infinity)
                
                HStack(spacing: 50.0){
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "backward.fill")
                    }
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: true ? "pause.fill" : "play.fill").font(.system(size: 50))
                    }
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "forward.fill")
                    }
                }
                .padding(.horizontal)
                .font(.system(size: 30))
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
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "shuffle")
                    }
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "repeat")
                    }
                }
                .padding(.top)
                .font(.title)
            }
            .frame(maxWidth:.infinity, maxHeight:.infinity)
            .fixedSize(horizontal: false, vertical: false)
        }
        .padding(10.0)
        .popupProgress(0.2)
        .popupBarProgressViewStyle(.top)
        .popupTitle("Song Title")
        .popupImage(Image("cover").resizable())
        .popupBarItems({
            HStack(spacing: 20) {
                Button(action: {
//                    isPlaying.toggle()
                }) {
                    Image(systemName: true ? "pause.fill" : "play.fill")
                }

                Button(action: {
                    print("Next")
                }) {
                    Image(systemName: "forward.fill")
                }
            }
            .font(.system(size: 20))
        })
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
