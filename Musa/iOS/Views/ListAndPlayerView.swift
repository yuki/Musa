//
//  ListAndPlayerView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 28/07/2020.
//

import SwiftUI

struct ListAndPlayerView: View {
    let title: String
    let reused: Bool
    
    var body: some View {
        VStack {
            ListView(title: title, reused: reused)
            MiniPlayerView()
        }
    }
}

struct ListAndPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ListAndPlayerView(title: "title", reused: false)
        ListAndPlayerView(title: "title", reused: false).preferredColorScheme(.dark)
    }
}
