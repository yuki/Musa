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
        Text(title)
        
        
    }
}

struct ReusableView_Previews: PreviewProvider {
    static var previews: some View {
        ReusableView(title: "Title")
    }
}
