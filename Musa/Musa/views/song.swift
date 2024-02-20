//
//  song.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia on 20/2/24.
//

import SwiftUI

struct song: View {
    let title: String
    
    var body: some View {
        Text(title)
    }
}

#Preview {
    song(title: "prueba")
}
