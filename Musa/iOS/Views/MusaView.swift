//
//  MusaView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 27/07/2020.
//

import SwiftUI

struct MusaView: View {
    var body: some View {
        VStack() {
            MapView(latitude: 43.2686711, longitude: -2.9340121)
                .frame(height: 300)
            Image("Cover")
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10)
                .offset(y: -150)
                .padding(.bottom, -150)
            HStack{
                Text("Artist Title")
                    .font(.largeTitle)
                Text(" - Song name")
                    .font(.title)
            }
            Spacer()
            Text("Some emotional text")
            Spacer()
        }
    }
}

struct MusaView_Previews: PreviewProvider {
    static var previews: some View {
        MusaView()
    }
}
