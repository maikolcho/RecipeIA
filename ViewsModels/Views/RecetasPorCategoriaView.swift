//
//  RecetasPorCategoriaView.swift
//  RecipeIA
//
//  Created by Maik on 21/3/25.
//
import SwiftUI

struct RecetasPorCategoriaView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    let categoria: String

    @State private var recetaAEditar: Recipe?
    @State private var nuevaCategoria: String = ""

    var body: some View {
        List {
            ForEach(recipesFiltradas, id: \.id) { receta in
                VStack(alignment: .leading) {
                    HStack {
                        Text(receta.nombre)
                            .font(.headline)
                        Spacer()

                        Button {
                            recetaAEditar = receta
                            nuevaCategoria = receta.categoria.rawValue
                        } label: {
                            Image(systemName: "folder.badge.plus")
                                .foregroundColor(.blue)
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
        .navigationTitle("Recetas: \(categoria)")
        .sheet(item: $recetaAEditar) { receta in
            VStack(spacing: 20) {
                Text("Mover receta a otra categoría")
                    .font(.headline)

                Picker("Selecciona una categoría", selection: $nuevaCategoria) {
                    ForEach(recipesViewModel.categories, id: \.self) { cat in
                        Text(cat).tag(cat)
                    }
                }
                .pickerStyle(WheelPickerStyle())

                Button("Guardar") {
                    var recetaActualizada = receta
                    recetaActualizada.categoria = Categoria.from(rawValue: nuevaCategoria)
                    recipesViewModel.actualizarReceta(recetaActualizada)
                    recetaAEditar = nil
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
    }

    private var recipesFiltradas: [Recipe] {
        recipesViewModel.userRecipes.filter {
            $0.categoria.rawValue == categoria
        }
    }
}
