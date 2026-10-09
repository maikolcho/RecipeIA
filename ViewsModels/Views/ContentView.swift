//
//  ContentView.swift
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBar() // Asegúrate de que TabBar sea la vista principal
            .environmentObject(RecipesViewModel()) // Pasar el ViewModel globalmente
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipesViewModel())
    }
}
