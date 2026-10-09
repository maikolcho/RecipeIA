//
//  RecipeList 2.swift
//  RecipeIA
//
//  Created by Maik on 4/2/25.
//
import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipesViewModel()
    @State private var ingredientes: String = ""

    var body: some View {
        NavigationView {  // 🔹 Asegurar NavigationView
            VStack {
                TextField("Ingresa los ingredientes", text: $ingredientes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    let ingredientesList = ingredientes.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    viewModel.buscarRecetas(con: ingredientesList)
                }) {
                    Text("Buscar Recetas")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView("Cargando recetas...")
                        .padding()
                }

                ScrollView {
                    if !viewModel.recipes.isEmpty {
                        RecipeList(recipes: viewModel.recipes)
                    } else if !viewModel.isLoading {
                        Text("No se encontraron recetas.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
            .navigationTitle("Buscar Recetas") // 🔹 Confirmar que la navegación esté habilitada
        }
    }
}

