//
//  HomeView.swift
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                // Fondo degradado como en Categorías
                LinearGradient(
                    gradient: Gradient(colors: [Color("FondoClaro"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    // Barra de búsqueda
                    SearchBar(text: $searchText)
                        .padding(.horizontal)

                    if recipesViewModel.userRecipes.isEmpty {
                        Text("No has agregado recetas aún.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ScrollView {
                            let filteredRecipes = getFilteredRecipes()
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 16)], spacing: 16) {
                                ForEach(filteredRecipes, id: \.id) { receta in
                                    recipeCardView(for: receta)
                                }
                            }
                            .padding()
                        }
                    }
                }
                .navigationTitle("Mis Recetas")
                .font(.title2.bold())
            }
        }
    }

    private func getFilteredRecipes() -> [Recipe] {
        recipesViewModel.userRecipes.filter {
            searchText.isEmpty ? true : $0.nombre.localizedCaseInsensitiveContains(searchText)
        }
    }

    private func recipeCardView(for receta: Recipe) -> some View {
        VStack(spacing: 8) {
            NavigationLink(destination: RecipeView(recipe: receta)) {
                RecipeCard(recipe: receta)
            }

            Button(action: {
                withAnimation {
                    recipesViewModel.eliminarReceta(receta)
                }
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(.borderless)
        }
        // ❌ Quitamos el fondo blanco
        // ✅ Mantiene la sombra de la RecipeCard
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Buscar recetas...", text: $text)
                .padding(10)
                .background(Color.white.opacity(0.9))
                .cornerRadius(10)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RecipesViewModel())
            .preferredColorScheme(.light)
    }
}
