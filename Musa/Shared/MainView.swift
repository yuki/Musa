//
//  MainView.swift
//  Shared
//
//  Created by Rubén Gómez Olivencia on 20/07/2020.
//

import SwiftUI

struct MainView: View {
    let tabs = ["Genres","Artists","Albums","Songs","Playlists","Compilations","Composers"]
    
    var body: some View {
        
        TabView(selection: .constant(1)) {
            ForEach(tabs,id: \.self) { tab in
                ReusableView(title: tab).tabItem {
                                    Text(tab)
                                    Image(tab)
                                }.tag(1)
            }
            ReusableView(title: "Musas").tabItem {
                Text("Musas")
                Image("Musas")
            }.tag(8)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
