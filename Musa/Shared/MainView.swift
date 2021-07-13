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
//    let tabs = ["Genres","Artists","Albums","Songs","Playlists","Compilations","Composers"]
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
        TabView(selection: .constant(1)) {
            ForEach(tabs,id: \.self) { tab in
                ListView(title: "Title", reused: false).tabItem {
                    Text(tab[0])
                    Image(systemName: tab[1])
                }.tag(1)
            } // ForEach

            ListView(title: "Title", reused: false).tabItem {
                Text("Musas")
                Image("Musas")
            }.tag(8)
//            let mediaItems = MPMediaQuery.songs()
        }
        .popup(isBarPresented: $isBarPresented, isPopupOpen: $isPopupOpen, onOpen: { print("Opened") }, onClose: { print("Closed") }){
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
