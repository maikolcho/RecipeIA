//
//  TabBar.swift
//
//
//  
//
import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            RecipeListView()
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
            AddRecipeView()  // ← Se agregó la opción de agregar recetas
                .tabItem {
                    Label("Nueva Receta", systemImage: "plus")
                }
            
                
        }
    }
}

