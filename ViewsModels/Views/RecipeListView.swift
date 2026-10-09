//
//  RecipeList 2.swift
//  RecipeIA
//
//  Created by Maik on 4/2/25.
//
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel

    var body: some View {
        NavigationView {
            ZStack {
                // ✅ Fondo degradado
                LinearGradient(
                    gradient: Gradient(colors: [Color("FondoClaro"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                if recipesViewModel.userRecipes.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.6))
                        Text("Aún no tienes recetas guardadas.")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(recipesViewModel.userRecipes) { recipe in
                            NavigationLink(destination: RecipeView(recipe: recipe)) {
                                HStack(spacing: 12) {
                                    AsyncImage(url: URL(string: recipe.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipped()
                                            .cornerRadius(10)
                                            .shadow(radius: 2)
                                    } placeholder: {
                                        ZStack {
                                            Color.gray.opacity(0.2)
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.gray.opacity(0.5))
                                        }
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(10)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(recipe.nombre)
                                            .font(.headline)
                                            .foregroundColor(.primary)

                                        Text(recipe.categoria.rawValue)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
            .navigationTitle("Mis Recetas")
            .font(.system(size: 18, weight: .semibold))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipesViewModel())
    }
}
