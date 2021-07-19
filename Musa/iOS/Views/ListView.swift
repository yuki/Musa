//
//  ListView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 20/07/2020.
//

import SwiftUI
import MediaPlayer

struct ListView: View {
    let title: String
    let reused: Bool
    let items: MPMediaQuery
    
    var body: some View {
        if title != "Musas" {
            NavigationView(content: {
                List(0..<items.items!.count) { index in
                    ListComponentView(song: items.items![index], origin: title)
                }.navigationBarTitle(title)
            })
        } else {
            MusaView()
        }
            
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Title", reused: false, items: MPMediaQuery())
        ListView(title: "Title", reused: false, items: MPMediaQuery()).preferredColorScheme(.dark)
    }
}

//struct ExtractedView: View {
//    let title: String
//    var body: some View {
//        List(0..<15) { item in
//            if title != "Musas" {
//                NavigationLink(
//                    destination: ListView(title: "Bla", reused: true, items: MPMediaQuery())
//                ) {
//                    ListComponentView()
//                }
//            } else {
//                NavigationLink(destination: MusaView()) {
//                    ListComponentView()
//                }
//            }
//            
//        }.navigationBarTitle(title)
//    }
//}
