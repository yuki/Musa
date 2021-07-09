//
//  ListView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 20/07/2020.
//

import SwiftUI

struct ListView: View {
    let title: String
    let reused: Bool
    
    var body: some View {
        VStack {
            if !reused {
                NavigationView {
                    ExtractedView(title: title)
                    
                }
                
            } else {
                ExtractedView(title: title)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Title", reused: false)
        ListView(title: "Title", reused: false).preferredColorScheme(.dark)
    }
}

struct ExtractedView: View {
    let title: String
    var body: some View {
        List(0..<15) { item in
            if title != "Musas" {
                NavigationLink(
                    destination: ListView(title: "Bla", reused: true)
                ) {
                    ListComponentView()
                }
            } else {
                NavigationLink(destination: MusaView()) {
                    ListComponentView()
                }
            }
            
        }.navigationBarTitle(title)
    }
}
