//
//  RowView.swift
//  Musa
//
//  Created by Rubén Gómez Olivencia on 20/2/24.
//

import SwiftUI

struct RowView: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    Group {
        RowView(text: "Prueba")
        RowView(text: "Prueba2")
    }
}
