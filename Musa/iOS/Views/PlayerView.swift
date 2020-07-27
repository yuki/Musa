//
//  PlayerView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 27/07/2020.
//

import SwiftUI

struct PlayerView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Image("Cover")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            VStack{
                Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                HStack{
                    Text("0:00")
                    Spacer()
                    Text("1:00")
                }
                Text("Song Title")
                    .font(.title)
                Text("Artist")
                    .foregroundColor(Color.blue)
                HStack{
                    Spacer()
                    if(colorScheme == .dark){
                        Image("Previous").colorInvert()
                    } else {
                        Image("Previous")
                    }
                    Spacer()
                    Image("Play")
                    Spacer()
                    Image("Next")
                    Spacer()
                }
                
                Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                HStack{
                    Image("Shuffle")
                    Spacer()
                    Image("Repeat")
                }
                Spacer()
                    .frame(width: 0.0, height: 5.0)
                    
            }
        }
        
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
