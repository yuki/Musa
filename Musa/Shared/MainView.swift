//
//  MainView.swift
//  Shared
//
//  Created by Rubén Gómez Olivencia on 20/07/2020.
//

import SwiftUI
import Foundation
import MediaPlayer

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
    
    var body: some View {
        TabView(selection: .constant(1)) {
            ForEach(tabs,id: \.self) { tab in
                ListAndPlayerView(title: tab[0],reused: false).tabItem {
                                    Text(tab[0])
                                    Image(systemName: tab[1])
                                }.tag(1)
            }
            ListAndPlayerView(title: "Musas", reused: false).tabItem {
                Text("Musas")
                Image("Musas")
            }.tag(8)
//            let mediaItems = MPMediaQuery.songs()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView().colorScheme(.dark)
    }
}
