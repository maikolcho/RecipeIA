//
//  BuscarRecetasView.swift
//  RecipeIA
//
//  Created by Maik on 18/12/24.
//

import SwiftUI

struct BuscarRecetasView: View {
    @StateObject private var viewModel = RecipesViewModel()
    @State private var ingredientes: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Escribe los ingredientes separados por comas", text: $ingredientes)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                Button(action: {
                    let ingredientesArray = ingredientes
                        .split(separator: ",")
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    viewModel.buscarRecetas(con: ingredientesArray)
                }) {
                    Text("Buscar Recetas")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                if viewModel.isLoading {
                    ProgressView("Buscando recetas...")
                        .padding()
                }

                List(viewModel.recipes) { recipe in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(recipe.nombre)
                                .font(.headline)
                            Text("Fuente: Nutritionix")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavorite(recipe: recipe)
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(recipe.isFavorite ? .red : .gray)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.top)

                if viewModel.showError {
                    Text("Error: \(viewModel.errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Buscar Recetas")
            .padding()
        }
    }
}
