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
            Text(title)
            List {
                
            }
            Spacer()
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
