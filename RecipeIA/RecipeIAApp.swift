//
//  RecetasApp.swift
//  Receta
//
//  Created by Maik on 27/11/24.
//
import SwiftUI
import Foundation

@main
struct RecipeIAApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar() // Muestra la barra inferior con todas las pestañas
                .environmentObject(RecipesViewModel())
        }
    }
}
