//
//  Estilos.swift
//  RecipeIA
//
//  Created by Maik on 26/3/25.
//

import Foundation
import SwiftUI

extension Color {
    static let FondoClaro = Color("FondoClaro")
    static let BotonVerde = Color("BotonVerde")
    static let TextoPrimario = Color("TextoPrimario")
  
}

struct BotonVerdeEstilo: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.botonVerde)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
