//
//  ListView.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia on 20/2/24.
//

import SwiftUI

struct ListView: View {
    
    let title: String
    
    var body: some View {
        NavigationSplitView {
            List{
                NavigationLink {
                        song(title: "qwe")
                    } label: {
                        song(title: "www")
                    }
//                NavigationLink(destination: ListView(title: "asd")) {
//                    RowView(text: "qwe")
//                }
//                NavigationLink(destination: ListView(title: "asd2")) {
//                    RowView(text: "qwe")
//                }
//                NavigationLink(destination: ListView(title: "asd3")) {
//                    RowView(text: "qwe")
//                }
            }.navigationTitle(title)
        } detail: {
            Text("Select one of the "+title)
        }
        

    }
}

#Preview {
    ListView(title: "titulo")
}
