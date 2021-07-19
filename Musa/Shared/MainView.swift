//
//  MainView.swift
//  Shared
//
//  Created by Rubén Gómez Olivencia on 20/07/2020.
//

import SwiftUI
import Foundation
import MediaPlayer
import LNPopupUI

struct MainView: View {
    let musa = Musa.default
    
    let tabs = [
        ["Genres","guitars"],
        ["Artists","music.mic"],
        ["Albums","square.stack"],
        ["Songs","music.note"],
        ["Playlists","music.note.list"],
        ["Compilations","person.2.square.stack"],
        ["Composers","person.3"]
    ]
    @State var isBarPresented = true
    @State var isPopupOpen = false
    
    var body: some View {
        TabView() {
            ForEach(tabs,id: \.self) { tab in
                ListView(title: tab[0], reused: false, items: musa.query[tab[0]]!).tabItem {
                    Text(tab[0])
                    Image(systemName: tab[1])
                }
            } // ForEach
            ListView(title: "Musas", reused: false, items: MPMediaQuery()).tabItem {
                Text("Musas")
                Image("Musas")
            }
        }
        .popup(isBarPresented: $isBarPresented, isPopupOpen: $isPopupOpen){
            PlayerView()
        }
        .popupProgress(0.2)
        .popupBarProgressViewStyle(.top)
//        .popupBarCustomView {
//            MiniPlayerView()
//        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView().colorScheme(.dark)
    }
}
