//
//  ContentView.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia on 20/2/24.
//

import SwiftUI

struct ContentView: View {
    
    let tabs:[[String]] = [
        ["Genres","guitars"],
        ["Artists","music.mic"],
        ["Albums","square.stack"],
        ["Songs","music.note"],
        ["Playlists","music.note.list"],
        ["Compilations","person.2.square.stack"],
        ["Composers","person.3"]
    ]
    
    
    var body: some View {
        TabView {
            ForEach(tabs, id:\.self){ tab in
                ListView(title:tab[0]).tabItem {
                    Label(tab[0], systemImage: tab[1])
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
