//
//  ReusableView.swift
//  iOS
//
//  Created by Rubén Gómez Olivencia on 20/07/2020.
//

import SwiftUI

struct ReusableView: View {
    let title: String
    
    var body: some View {
        VStack {
        NavigationView {
            List(0..<5) { item in
                if title != "Musa" {
                    NavigationLink(destination: Text("asd")) {
                        ListComponentView()
                    }
                } else {
                    NavigationLink(destination: Text("asd")) {
                        MusaView()
                    }
                }

            }.navigationBarTitle(title)
        }
        MiniView()
            .frame(height: 60.0)
        }
        
    }
}

struct ReusableView_Previews: PreviewProvider {
    static var previews: some View {
        ReusableView(title: "Title")
    }
}
