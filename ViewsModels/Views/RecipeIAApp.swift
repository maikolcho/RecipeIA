//
//  RecetasApp.swift
//  Receta
//
//  Created by Maik on 27/11/24.
//
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import SwiftUI

@main
struct RecipeIAApp: App {
    @StateObject private var recipesViewModel = RecipesViewModel() // ✅ Crear una única instancia del ViewModel

    init() {
        print("✅ RecipeIAApp se está inicializando...")
        
    }

    var body: some Scene {
        WindowGroup {
            TabBar()
                .environmentObject(recipesViewModel) // ✅ Se pasa a toda la app

                // 🔹 Agregar logs para ver si la app inicia y cierra correctamente
                .onAppear {
                    print("✅ RecipeIAApp se inició correctamente.")
                }
                .onDisappear {
                    print("⚠️ RecipeIAApp se cerró inesperadamente.")
                }
                .buttonStyle(BotonVerdeEstilo()) // Aplica a todos los botones de la app
        }
    }
}
