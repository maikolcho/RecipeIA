//
//  BuscarRecetasView.swift
//  RecipeIA
//
//  Created by Maik on 18/12/24.
//
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import SwiftUI

struct BuscarRecetasView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @State private var ingredientes: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color("FondoClaro") // Fondo personalizado
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer().frame(height: 30)

                    Text("Buscar Recetas")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)

                    TextField("Ingresa ingredientes separados por comas", text: $ingredientes)
                        .padding()
                        .background(Color.black.opacity(0.1)) // 🔄 Menos blanco, más contraste
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1) // 🔄 Borde sutil más tenue
                        )
                        .padding(.horizontal)
                        .foregroundColor(.black) // 🔄 Texto en blanco
                        .font(.system(size: 16, weight: .medium))



                    // ✅ Botón completamente redondo y limpio
                    Button(action: buscarRecetas) {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                            Text("Buscar Recetas")
                                .fontWeight(.semibold)
                        }
                        .font(.system(size: 16))
                        .padding(.horizontal, 28)
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .background(
                            Capsule()
                                .fill(Color.green)
                        )
                    }
                    .buttonStyle(PlainButtonStyle()) // 🔥 Este elimina estilos heredados por defecto


                    if recipesViewModel.isLoading {
                        ProgressView("Buscando recetas…")
                            .padding()
                    } else if recipesViewModel.showError {
                        Text(recipesViewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        List {
                            ForEach(recipesViewModel.recipes) { receta in
                                NavigationLink(destination: RecipeView(recipe: receta)) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(receta.nombre)
                                            .font(.headline)
                                        Text(receta.descripcion)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 6)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                    }

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }

    private func buscarRecetas() {
        let ingredientesArray = ingredientes
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        Task {
            await recipesViewModel.buscarRecetas(con: ingredientesArray)
        }
    }
}
