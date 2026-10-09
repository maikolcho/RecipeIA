//
//  TabBar.swift
//  RecipeIA
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//


import SwiftUI

struct TabBar: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // Fondo transparente
        
        // Colores del fondo (opcional: se puede dejar transparente)
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.95)
        
        // Ítems seleccionados e inactivos
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .darkGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.darkGray]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            BuscarRecetasView()
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }

            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }

            CategoriasView()
                .tabItem {
                    Label("Categorías", systemImage: "list.bullet")
                }

            FavoritosView()
                .tabItem {
                    Label("Favoritos", systemImage: "heart")
                }

            AddRecipeView()
                .tabItem {
                    Label("Nueva Receta", systemImage: "plus")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(RecipesViewModel())
    }
}
