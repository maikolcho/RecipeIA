//
//  Crea RecetasPorCategoriaView.swift
//  RecipeIA
//
//  Created by Maik on 21/3/25.
//

import SwiftUI

struct RecetasPorCategoriaView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    let categoria: Categoria

    @State private var recetaAEditar: Recipe?
    @State private var nuevaCategoria: Categoria = .desayuno
    @State private var mostrarAlerta = false

    var body: some View {
        List {
            ForEach(recipesFiltradas, id: \.id) { receta in
                VStack(alignment: .leading) {
                    HStack {
                        NavigationLink(destination: RecipeView(recipe: receta)) {
                            Text(receta.nombre)
                                .font(.headline)
                        }

                        Spacer()

                        Button {
                            recetaAEditar = receta
                            nuevaCategoria = receta.categoria
                        } label: {
                            Image(systemName: "folder.badge.plus")
                                .foregroundColor(.black)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }

                    Text(receta.descripcion)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Recetas: \(categoria.rawValue)")
        .sheet(item: $recetaAEditar) { receta in
            VStack(spacing: 20) {
                Text("Mover receta a otra categoría")
                    .font(.headline)

                Picker("Categoría", selection: $nuevaCategoria) {
                    ForEach(Categoria.allCases, id: \.self) { cat in
                        Text(cat.rawValue).tag(cat)
                    }
                }
                .pickerStyle(WheelPickerStyle())

                Button("Guardar") {
                    var recetaActualizada = receta
                    recetaActualizada.categoria = nuevaCategoria
                    recipesViewModel.actualizarReceta(recetaActualizada)
                    recetaAEditar = nil
                    mostrarAlerta = true
                }
                .padding()
                .buttonStyle(.borderedProminent)

                Button("Cancelar") {
                    recetaAEditar = nil
                }
                .foregroundColor(.red)
            }
            .padding()
        }
        .overlay(
            VStack {
                if mostrarAlerta {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Receta movida con éxito")
                            .foregroundColor(.green)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .transition(.scale)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                mostrarAlerta = false
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, 10)
        )
    }

    private var recipesFiltradas: [Recipe] {
        recipesViewModel.userRecipes.filter {
            $0.categoria == categoria
        }
    }
}
