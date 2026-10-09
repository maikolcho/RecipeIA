//
//  FavoritosView.swift
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import SwiftUI

struct FavoritosView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel

    var body: some View {
        NavigationView {
            ZStack {
                // Fondo degradado
                LinearGradient(
                    gradient: Gradient(colors: [Color("FondoClaro"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Group {
                    if recipesViewModel.favoriteRecipes.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "heart.slash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray.opacity(0.6))

                            Text("¡Aún no has añadido recetas a favoritos!")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .font(.headline)
                                .padding(.horizontal)
                        }
                    } else {
                        List {
                            ForEach(recipesViewModel.favoriteRecipes) { receta in
                                NavigationLink(destination: RecipeView(recipe: receta)) {
                                    HStack(spacing: 12) {
                                        AsyncImage(url: URL(string: receta.image)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                        } placeholder: {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(8)
                                        }

                                        VStack(alignment: .leading) {
                                            Text(receta.nombre)
                                                .font(.system(size: 17, weight: .semibold))
                                            Text(receta.categoria.rawValue)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                            .onDelete(perform: eliminarFavorito)
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                    }
                }
            }
            .navigationTitle("Favoritos")
            .toolbar {
                EditButton()
            }
        }
    }

    /// 🔥 Eliminar receta de favoritos
    private func eliminarFavorito(at offsets: IndexSet) {
        for index in offsets {
            let receta = recipesViewModel.favoriteRecipes[index]
            recipesViewModel.toggleFavorite(recipe: receta)
        }
    }
}

struct FavoritosView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritosView()
            .environmentObject(RecipesViewModel())
    }
}
