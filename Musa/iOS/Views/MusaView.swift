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
                .frame(height: 200)
            Image("Cover")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10)
                .offset(y: -110)
                .padding(.bottom, -120)
            

            Text("Some emotional text")
            Spacer()
        }
        .navigationBarTitle("Artist Title - Song name")
        .statusBar(hidden: true)
    }
}

struct MusaView_Previews: PreviewProvider {
    static var previews: some View {
        MusaView()
        MusaView().preferredColorScheme(.dark)
    }
}
